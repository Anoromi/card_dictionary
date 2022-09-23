use flutter_rust_bridge::frb;

use super::dictionary_data::{Reference, UnwrappedData};
#[derive(Debug)]
#[frb]
pub struct FullTerm {
    pub term: String,
    pub data: Vec<UnwrappedData>,
}

impl FullTerm {
    pub fn new(term: String, data: Vec<UnwrappedData>) -> Self {
        Self { term, data }
    }
}

#[derive(Debug)]
#[frb(dart_metadata=("freezed"))]
pub struct PartialTerm {
    pub term: String,
    pub references: Vec<Reference>,
}

impl PartialTerm {
    pub fn new(term: String, references: Vec<Reference>) -> Self {
        Self { term, references }
    }

    pub fn combine(&mut self, mut other: Self) {
        assert_eq!(self.term, other.term);
        for v in other.references.drain(..) {
            self.references.push(v);
        }
    }

}
