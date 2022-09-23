use flutter_rust_bridge::frb;

use super::enum_types::{RelationType, WordType};

#[derive(Debug)]
#[frb]
pub struct Reference {
    pub index: u64,
    pub word_type: WordType,
}

impl Reference {
    pub fn new(index: u64, word_type: WordType) -> Self {
        Self { index, word_type }
    }
}

#[derive(Debug)]
#[frb]
pub struct Relation {
    pub relation: PartialUnwrappedData,
    pub relation_type: RelationType,
    pub word_type: WordType,
}

impl Relation {
    pub fn new(
        relation: PartialUnwrappedData,
        relation_type: RelationType,
        word_type: WordType,
    ) -> Self {
        Self {
            relation,
            relation_type,
            word_type,
        }
    }
}

#[derive(Debug)]
#[frb]
pub struct PartialUnwrappedData {
    pub words: Vec<String>,
    pub index: u64,
}

impl PartialUnwrappedData {
    pub fn new(words: Vec<String>, index: u64) -> Self {
        Self { words, index }
    }
}

#[derive(Debug)]
#[frb]
pub struct UnwrappedData {
    pub words: Vec<String>,
    pub relations: Vec<Relation>,
    pub definition: String,
    pub use_cases: Vec<UseCase>,
    pub word_type: WordType,
}

impl UnwrappedData {
    pub fn new(
        words: Vec<String>,
        relations: Vec<Relation>,
        definition: String,
        use_cases: Vec<UseCase>,
        word_type: WordType,
    ) -> Self {
        Self {
            words,
            relations,
            definition,
            use_cases,
            word_type,
        }
    }
}

#[derive(Debug)]
#[frb]
pub struct UseCase {
    pub id: u64,
    pub word_index: u64,
}

impl UseCase {
    pub fn new(id: u64, word_index: u64) -> Self {
        Self { id, word_index }
    }
}
