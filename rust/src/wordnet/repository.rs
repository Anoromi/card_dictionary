use std::{
    convert::TryFrom,
    io::SeekFrom,
    ops::{Deref, Index, IndexMut},
    ptr,
};

use super::{
    dictionary::Dictionary,
    dictionary_data::{Reference, Relation, UnwrappedData, UseCase},
    enum_types::{RelationType, WordType},
    terms::{FullTerm, PartialTerm},
};
use anyhow::Result;
use tokio::{
    io::{AsyncReadExt, AsyncSeekExt},
    join,
};

pub struct Repository {
    noun: Dictionary,
    verb: Dictionary,
    adjective: Dictionary,
    adverb: Dictionary,
}

impl Repository {
    fn new(noun: Dictionary, verb: Dictionary, adjective: Dictionary, adverb: Dictionary) -> Self {
        Self {
            noun,
            verb,
            adjective,
            adverb,
        }
    }

    pub async fn from_path(path: &str) -> Result<Repository> {
        macro_rules! get_path {
            ($name : expr, $type : expr) => {
                Dictionary::from_path(format!("{}/{}", path, $name), $type)
            };
        }
        let v = join!(
            get_path!("noun", WordType::Noun),
            get_path!("verb", WordType::Verb),
            get_path!("adjective", WordType::Adjective),
            get_path!("adverb", WordType::Adverb),
        );
        Ok(Repository {
            noun: v.0?,
            verb: v.1?,
            adjective: v.2?,
            adverb: v.3?,
        })
    }

    pub async fn data_at(&mut self, word_type: WordType, index: u64) -> Result<UnwrappedData> {
        let dict = &mut self[word_type];
        dict.relation_reference_mut()
            .seek(SeekFrom::Start(index * 8))
            .await?;
        let position = dict.relation_reference_mut().read_u64().await?;
        dict.relation_data_mut()
            .seek(SeekFrom::Start(position))
            .await?;
        let words = {
            let words_count = dict.relation_data_mut().read_variable_u64().await?;
            let mut vec = Vec::new();
            for _ in 0..words_count {
                let len = dict.relation_data_mut().read_variable_u64().await?;
                vec.push(dict.relation_data_mut().read_string(len).await?);
            }
            vec
        };

        let use_cases = {
            if word_type != WordType::Verb {
                vec![]
            } else {
                let count = dict.relation_data_mut().read_variable_u64().await?;
                let mut vec = Vec::with_capacity(count as usize);
                for _ in 0..count {
                    let id = dict.relation_data_mut().read_variable_u64().await?;
                    let word_ind = dict.relation_data_mut().read_variable_u64().await?;
                    vec.push(UseCase::new(id, word_ind));
                }
                vec
            }
        };

        let definition = {
            let count = dict.relation_data_mut().read_variable_u64().await?;
            dict.relation_data_mut().read_string(count).await?
        };
        let relations = {
            let count = dict.relation_data_mut().read_variable_u64().await?;
            let mut references = Vec::with_capacity(count as usize);
            for _ in 0..count {
                let index = dbg!(dict.relation_data_mut().read_variable_u64().await?);
                let w_type = WordType::try_from(dbg!(dict.relation_data_mut().read_u8().await?)).unwrap();
                let r_type = RelationType::try_from(dbg!(dict.relation_data_mut().read_u8().await?)).unwrap();
                references.push((index, w_type, r_type));
                // vec.push(Relation::new(
                //     dict.partial_data_at(w_type, index),
                //     relationType,
                //     wordType,
                // ))
            }
            drop(dict);
            let mut vec = Vec::with_capacity(count as usize);
            for (index, w_type, r_type) in references.into_iter() {
                vec.push(Relation::new(
                    self[w_type].partial_data_at(index).await?,
                    r_type,
                    w_type,
                ));
            }
            vec
        };
        Ok(UnwrappedData::new(
            words, relations, definition, use_cases, word_type,
        ))
    }

    pub async fn data_at_reference(
        &mut self,
        reference: &Reference,
    ) -> Result<UnwrappedData, anyhow::Error> {
        return self.data_at(reference.word_type, reference.index).await;
    }

    pub async fn unwrap_term(&mut self, term: &PartialTerm) -> Result<FullTerm> {
        let mut references = Vec::with_capacity(term.references.len());
        for v in term.references.iter() {
            references.push(self.data_at_reference(v).await?);
        }
        Ok(FullTerm::new(term.term.to_string(), references))
    }

    pub async fn find_terms(
        &mut self,
        lower_bound: &str,
        count: u64,
    ) -> Result<Vec<PartialTerm>> {
        let higher_bound = {
            let last_char = lower_bound.char_indices().last();
            if let Some((last_ind, last_char)) = last_char {
                let mut bound = lower_bound[..last_ind].to_string();
                bound.push(char::from_u32((last_char as u32).saturating_add(1)).unwrap());
                bound
            } else {
                return Ok(vec![]);
            }
        };

        #[inline]
        async fn initial_set(
            term: Option<(PartialTerm, u64)>,
            dictionary: &mut Dictionary,
            higher_bound: &str,
        ) -> Result<Option<PartialTerm>> {
            if let Some(term) = term {
                if term.0.term.as_str() > higher_bound {
                    return Ok(None);
                }
                dictionary.move_to(term.1 + 1).await?;
                return Ok(Some(term.0));
            } else {
                Ok(None)
            }
        }

        macro_rules! test_set {
            ($term : expr) => {
                if let Some(term) = $term {
                    if term.term.as_str() >= higher_bound.as_str() {
                        None
                    } else {
                        Some(term)
                    }
                } else {
                    None
                }
            };
        }

        #[inline]
        async fn search_start(
            dict: &mut Dictionary,
            lower_bound: &str,
        ) -> Result<Option<PartialTerm>> {
            let term = dict.term(lower_bound).await?;
            // Ok(term)
            match term {
                Some(term) => Ok(Some(term /* , dict.index_position().await? */)),
                None => Ok(None),
            }
        }

        macro_rules! search_start {
            ($dictionary : expr) => {
                search_start(&mut $dictionary, &lower_bound)
            };
        }

        let values =
        join!(
        // (
            search_start!(self.noun),
            search_start!(self.verb),
            search_start!(self.adjective),
            search_start!(self.adverb),
        );
        let mut values = [
            (&mut self.noun, test_set!(values.0?)),
            (&mut self.verb, test_set!(values.1?)),
            (&mut self.adjective, test_set!(values.2?)),
            (&mut self.adverb, test_set!(values.3?)),
        ];

        dbg!(&values[0].1);
        dbg!(&values[1].1);
        dbg!(&values[2].1);
        dbg!(&values[3].1);
        let mut terms = vec![];
        for _ in 0..count {
            let mut min: Option<usize> = None;
            for i in 0..values.len() {
                let item = &values[i];
                if item.1.is_some()
                    && (min.is_none()
                        || item.1.as_ref().unwrap().term.as_str()
                            < values[min.unwrap()].1.as_ref().unwrap().term.as_str())
                {
                    min = Some(i);
                }
            }

            match min {
                None => break,
                Some(min) => {
                    let v = &mut values[min];
                    let mut term: PartialTerm =
                        std::mem::replace(&mut v.1, test_set!(v.0.next_term().await?)).unwrap();
                    for i in 0..values.len() {
                        if i == min {
                            continue;
                        }

                        if matches!(values[i].1.as_ref(), Some(x) if x.term == term.term) {
                            term.combine(values[i].1.take().unwrap());
                            let next_term = test_set!(values[i].0.next_term().await?);
                            dbg!(&next_term);
                            values[i].1 = next_term;
                        }
                    }
                    terms.push(term)
                }
            }
        }
        Ok(terms)
    }
}

impl Index<WordType> for Repository {
    type Output = Dictionary;

    fn index(&self, index: WordType) -> &Self::Output {
        match index {
            WordType::Noun => &self.noun,
            WordType::Verb => &self.verb,
            WordType::Adjective => &self.adjective,
            WordType::Satellite => &self.adjective,
            WordType::Adverb => &self.adverb,
        }
    }
}

impl IndexMut<WordType> for Repository {
    fn index_mut(&mut self, index: WordType) -> &mut Self::Output {
        match index {
            WordType::Noun => &mut self.noun,
            WordType::Verb => &mut self.verb,
            WordType::Adjective => &mut self.adjective,
            WordType::Satellite => &mut self.adjective,
            WordType::Adverb => &mut self.adverb,
        }
    }
}
