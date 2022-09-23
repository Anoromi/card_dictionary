
use tokio::{fs::*, io::*};

use super::{
    counted_reader::SizedReader,
    dictionary_data::{PartialUnwrappedData, Reference},
    enum_types::WordType,
    terms::PartialTerm,
};
use anyhow::Result;

type Reader = SizedReader;

pub struct Dictionary {
    path: String,
    index_data: Reader,
    index_reference: Reader,
    index_words: Reader,
    relation_data: Reader,
    relation_reference: Reader,
    word_type: WordType,
    index_size: u64,
    relation_size: u64,
}

impl Dictionary {
    fn new(
        path: String,
        index_data: Reader,
        index_reference: Reader,
        index_words: Reader,
        relation_data: Reader,
        relation_reference: Reader,
        word_type: WordType,
        index_size: u64,
        relation_size: u64,
    ) -> Self {
        Self {
            path,
            index_data,
            index_reference,
            index_words,
            relation_data,
            relation_reference,
            word_type,
            index_size,
            relation_size,
        }
    }

    pub async fn next_term(&mut self) -> Result<Option<PartialTerm>> {
        if self.index_reference.stream_position().await? >= self.index_reference.len() {
            return Ok(None);
        }
        let word_position = self.index_reference.read_u64().await?;
        let data_position = self.index_reference.read_u64().await?;
        self.index_words
            .seek(SeekFrom::Start(word_position))
            .await?;
        self.index_data.seek(SeekFrom::Start(data_position)).await?;
        let word = {
            let word_len = self.index_words.read_variable_u64().await?;
            self.index_words
                .read_string(word_len)
                .await?
                .replace('_', " ")
        };
        dbg!(self.index_data.stream_position().await?);
        dbg!(self.index_data.len());
        let data_length = self.index_data.read_variable_u64().await?;

        let references = {
            let mut vec = vec![];
            for _ in 0..data_length {
                vec.push(Reference::new(
                    self.index_data.read_variable_u64().await?,
                    self.word_type,
                ));
            }
            vec
        };

        Ok(Some(PartialTerm::new(word, references)))
    }

    #[inline]
    pub async fn term_at(&mut self, index: u64) -> Result<Option<PartialTerm>> {
        self.move_to(index).await?;
        self.next_term().await
    }

    #[inline]
    pub async fn move_to(&mut self, index : u64) -> Result<()> {
        let position = index * 16;
        self.index_reference.seek(SeekFrom::Start(position)).await?;
        Ok(())
    }

    pub async fn index_position(&mut self) -> Result<u64> {
        Ok(self.index_reference.stream_position().await?)
    }

    pub async fn partial_data_at(&mut self, index: u64) -> Result<PartialUnwrappedData> {
        let position = index * 8;
        self.relation_reference
            .seek(SeekFrom::Start(position))
            .await?;
        let reference = self.relation_reference.read_u64().await?;
        self.relation_data.seek(SeekFrom::Start(reference)).await?;
        let count = self.relation_data.read_variable_u64().await?;
        let words = {
            let mut vec = Vec::with_capacity(count as usize);
            for _ in 0..count {
                let len = self.relation_data.read_variable_u64().await?;
                vec.push(self.relation_data.read_string(len).await?);
            }
            vec
        };

        Ok(PartialUnwrappedData::new(words, index))
    }

    pub async fn term(&mut self, lower_bound: &str) -> Result<Option<PartialTerm>> {
        let mut min = 0;
        let mut max = self.index_size - 1;
        dbg!(&max);
        let mut next: String;
        while min <= max {
            let mid = dbg!((min + (max - min) / 2));
            next = dbg!(self.word_at(mid).await?.unwrap());
            // dbg!(next.len());
            let comp = dbg!(next.as_str().cmp(lower_bound));
            match comp {
                std::cmp::Ordering::Less => min = mid + 1,
                std::cmp::Ordering::Equal => {min = mid; break;},
                std::cmp::Ordering::Greater if min != max=> max = mid - 1,
                std::cmp::Ordering::Greater => break
            }
        }
        dbg!(min);
        Ok(dbg!(self.term_at(min).await?))
    }

    pub async fn word_at(&mut self, index: u64) -> Result<Option<String>> {
        let position = index * 16;
        self.index_reference.seek(SeekFrom::Start(position)).await?;
        if self.index_reference.len() == self.index_reference.stream_position().await? {
            return Ok(None);
        }

        // dbg!(self.index_reference.stream_position().await?);

        let word_position = self.index_reference.read_u64().await?;
        self.index_reference.read_u64().await?;
        self.index_words
            .seek(SeekFrom::Start(word_position)).await?;
        // dbg!(self.index_words.stream_position().await?);
        let word_len = self.index_words.read_variable_u64().await?;
        let word = self
            .index_words
            .read_string(word_len)
            .await?;
            // .replace('_', " ");
        Ok(Some(word))
    }

    pub async fn from_path(d: String, word_type: WordType) -> Result<Self> {
        macro_rules! path {
            ($s : expr ) => {
                Reader::from_file(File::open(format!("{}/{}", &d, &$s)).await?).await?
            };
        }
        dbg!(word_type);
        let index_data = path!("indexData");
        let index_reference = path!("indexReference");
        let index_words = path!("indexWords");
        let relation_data = path!("relationData");
        let relation_reference = path!("relationReference");
        let index_size = index_reference.len() / 16;
        let relation_size = relation_reference.len() / 8;
        Ok(Dictionary::new(
            d,
            index_data,
            index_reference,
            index_words,
            relation_data,
            relation_reference,
            word_type,
            index_size,
            relation_size,
        ))
    }

    pub(crate) fn path(&self) -> &str {
        self.path.as_ref()
    }

    pub(crate) fn index_data_mut(&mut self) -> &mut Reader {
        &mut self.index_data
    }

    pub(crate) fn index_reference_mut(&mut self) -> &mut Reader {
        &mut self.index_reference
    }

    pub(crate) fn index_words_mut(&mut self) -> &mut Reader {
        &mut self.index_words
    }

    pub(crate) fn relation_data_mut(&mut self) -> &mut Reader {
        &mut self.relation_data
    }

    pub(crate) fn relation_reference_mut(&mut self) -> &mut Reader {
        &mut self.relation_reference
    }

    pub(crate) fn word_type(&self) -> WordType {
        self.word_type
    }

    pub(crate) fn index_size(&self) -> u64 {
        self.index_size
    }

    pub(crate) fn relation_size(&self) -> u64 {
        self.relation_size
    }
}
