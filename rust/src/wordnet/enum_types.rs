use num_enum::TryFromPrimitive;

#[derive(Clone, Copy, PartialEq, Eq, Hash, TryFromPrimitive, Debug)]
#[repr(u8)]
pub enum WordType {
    Noun = 0,
    Verb,
    Adjective,
    Satellite,
    Adverb,
}

impl WordType {
    pub fn from_char(c: char) -> WordType {
        match c {
            's' => WordType::Satellite,
            'r' => WordType::Adverb,
            'n' => WordType::Noun,
            'v' => WordType::Verb,
            'a' => WordType::Adjective,
            _ => panic!("unexpected word_type symbol"),
        }
    }

}

#[derive(TryFromPrimitive, Clone, Copy, PartialEq, Eq, Debug)]
#[repr(u8)]
pub enum RelationType{
    Antonym,
    MemberHolonym,
    PartHolonym,
    SubstanceHolonym,
    VerbGroup,
    MemberMeronym,
    PartMeronym,
    SubstanceMeronym,
    SimilarTo,
    Entailment,
    DerivationallyRelatedForm,
    MemberOfThisDomainTopic,
    MemberOfThisDomainRegion,
    MemberOfThisDomainUsage,
    DomainOfSynsetTopic,
    DomainOfSynsetRegion,
    DomainOfSynsetUsage,
    ParticipleOfVerb,
    Attribute,
    Cause,
    Hypernym,
    InstanceHypernym,
    DerivedFromAdjective,
    PertainsToNoun,
    AlsoSee,
    Hyponym,
    InstanceHyponym,
}
