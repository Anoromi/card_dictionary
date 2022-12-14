#![allow(
    non_camel_case_types,
    unused,
    clippy::redundant_closure,
    clippy::useless_conversion,
    clippy::unit_arg,
    clippy::double_parens,
    non_snake_case
)]
// AUTO GENERATED FILE, DO NOT EDIT.
// Generated by `flutter_rust_bridge`.

use crate::api::*;
use flutter_rust_bridge::*;

// Section: imports

use crate::wordnet::dictionary_data::PartialUnwrappedData;
use crate::wordnet::dictionary_data::Reference;
use crate::wordnet::dictionary_data::Relation;
use crate::wordnet::dictionary_data::UnwrappedData;
use crate::wordnet::dictionary_data::UseCase;
use crate::wordnet::enum_types::RelationType;
use crate::wordnet::enum_types::WordType;
use crate::wordnet::terms::FullTerm;
use crate::wordnet::terms::PartialTerm;

// Section: wire functions

#[no_mangle]
pub extern "C" fn wire_try_init(port_: i64, path: *mut wire_uint_8_list) {
    FLUTTER_RUST_BRIDGE_HANDLER.wrap(
        WrapInfo {
            debug_name: "try_init",
            port: Some(port_),
            mode: FfiCallMode::Normal,
        },
        move || {
            let api_path = path.wire2api();
            move |task_callback| Ok(try_init(api_path))
        },
    )
}

#[no_mangle]
pub extern "C" fn wire_find_suggestions(port_: i64, text: *mut wire_uint_8_list, count: u32) {
    FLUTTER_RUST_BRIDGE_HANDLER.wrap(
        WrapInfo {
            debug_name: "find_suggestions",
            port: Some(port_),
            mode: FfiCallMode::Normal,
        },
        move || {
            let api_text = text.wire2api();
            let api_count = count.wire2api();
            move |task_callback| find_suggestions(api_text, api_count)
        },
    )
}

#[no_mangle]
pub extern "C" fn wire_unwrap_term(port_: i64, term: *mut wire_PartialTerm) {
    FLUTTER_RUST_BRIDGE_HANDLER.wrap(
        WrapInfo {
            debug_name: "unwrap_term",
            port: Some(port_),
            mode: FfiCallMode::Normal,
        },
        move || {
            let api_term = term.wire2api();
            move |task_callback| unwrap_term(api_term)
        },
    )
}

#[no_mangle]
pub extern "C" fn wire_get(port_: i64) {
    FLUTTER_RUST_BRIDGE_HANDLER.wrap(
        WrapInfo {
            debug_name: "get",
            port: Some(port_),
            mode: FfiCallMode::Normal,
        },
        move || move |task_callback| Ok(get()),
    )
}

#[no_mangle]
pub extern "C" fn wire_read(port_: i64, file_path: *mut wire_uint_8_list) {
    FLUTTER_RUST_BRIDGE_HANDLER.wrap(
        WrapInfo {
            debug_name: "read",
            port: Some(port_),
            mode: FfiCallMode::Normal,
        },
        move || {
            let api_file_path = file_path.wire2api();
            move |task_callback| read(api_file_path)
        },
    )
}

// Section: wire structs

#[repr(C)]
#[derive(Clone)]
pub struct wire_list_reference {
    ptr: *mut wire_Reference,
    len: i32,
}

#[repr(C)]
#[derive(Clone)]
pub struct wire_PartialTerm {
    term: *mut wire_uint_8_list,
    references: *mut wire_list_reference,
}

#[repr(C)]
#[derive(Clone)]
pub struct wire_Reference {
    index: u64,
    word_type: i32,
}

#[repr(C)]
#[derive(Clone)]
pub struct wire_uint_8_list {
    ptr: *mut u8,
    len: i32,
}

// Section: wrapper structs

// Section: static checks

// Section: allocate functions

#[no_mangle]
pub extern "C" fn new_box_autoadd_partial_term_0() -> *mut wire_PartialTerm {
    support::new_leak_box_ptr(wire_PartialTerm::new_with_null_ptr())
}

#[no_mangle]
pub extern "C" fn new_list_reference_0(len: i32) -> *mut wire_list_reference {
    let wrap = wire_list_reference {
        ptr: support::new_leak_vec_ptr(<wire_Reference>::new_with_null_ptr(), len),
        len,
    };
    support::new_leak_box_ptr(wrap)
}

#[no_mangle]
pub extern "C" fn new_uint_8_list_0(len: i32) -> *mut wire_uint_8_list {
    let ans = wire_uint_8_list {
        ptr: support::new_leak_vec_ptr(Default::default(), len),
        len,
    };
    support::new_leak_box_ptr(ans)
}

// Section: impl Wire2Api

pub trait Wire2Api<T> {
    fn wire2api(self) -> T;
}

impl<T, S> Wire2Api<Option<T>> for *mut S
where
    *mut S: Wire2Api<T>,
{
    fn wire2api(self) -> Option<T> {
        if self.is_null() {
            None
        } else {
            Some(self.wire2api())
        }
    }
}

impl Wire2Api<String> for *mut wire_uint_8_list {
    fn wire2api(self) -> String {
        let vec: Vec<u8> = self.wire2api();
        String::from_utf8_lossy(&vec).into_owned()
    }
}

impl Wire2Api<PartialTerm> for *mut wire_PartialTerm {
    fn wire2api(self) -> PartialTerm {
        let wrap = unsafe { support::box_from_leak_ptr(self) };
        Wire2Api::<PartialTerm>::wire2api(*wrap).into()
    }
}

impl Wire2Api<i32> for i32 {
    fn wire2api(self) -> i32 {
        self
    }
}

impl Wire2Api<Vec<Reference>> for *mut wire_list_reference {
    fn wire2api(self) -> Vec<Reference> {
        let vec = unsafe {
            let wrap = support::box_from_leak_ptr(self);
            support::vec_from_leak_ptr(wrap.ptr, wrap.len)
        };
        vec.into_iter().map(Wire2Api::wire2api).collect()
    }
}

impl Wire2Api<PartialTerm> for wire_PartialTerm {
    fn wire2api(self) -> PartialTerm {
        PartialTerm {
            term: self.term.wire2api(),
            references: self.references.wire2api(),
        }
    }
}

impl Wire2Api<Reference> for wire_Reference {
    fn wire2api(self) -> Reference {
        Reference {
            index: self.index.wire2api(),
            word_type: self.word_type.wire2api(),
        }
    }
}

impl Wire2Api<u32> for u32 {
    fn wire2api(self) -> u32 {
        self
    }
}

impl Wire2Api<u64> for u64 {
    fn wire2api(self) -> u64 {
        self
    }
}

impl Wire2Api<u8> for u8 {
    fn wire2api(self) -> u8 {
        self
    }
}

impl Wire2Api<Vec<u8>> for *mut wire_uint_8_list {
    fn wire2api(self) -> Vec<u8> {
        unsafe {
            let wrap = support::box_from_leak_ptr(self);
            support::vec_from_leak_ptr(wrap.ptr, wrap.len)
        }
    }
}

impl Wire2Api<WordType> for i32 {
    fn wire2api(self) -> WordType {
        match self {
            0 => WordType::Noun,
            1 => WordType::Verb,
            2 => WordType::Adjective,
            3 => WordType::Satellite,
            4 => WordType::Adverb,
            _ => unreachable!("Invalid variant for WordType: {}", self),
        }
    }
}

// Section: impl NewWithNullPtr

pub trait NewWithNullPtr {
    fn new_with_null_ptr() -> Self;
}

impl<T> NewWithNullPtr for *mut T {
    fn new_with_null_ptr() -> Self {
        std::ptr::null_mut()
    }
}

impl NewWithNullPtr for wire_PartialTerm {
    fn new_with_null_ptr() -> Self {
        Self {
            term: core::ptr::null_mut(),
            references: core::ptr::null_mut(),
        }
    }
}

impl NewWithNullPtr for wire_Reference {
    fn new_with_null_ptr() -> Self {
        Self {
            index: Default::default(),
            word_type: Default::default(),
        }
    }
}

// Section: impl IntoDart

impl support::IntoDart for FullTerm {
    fn into_dart(self) -> support::DartCObject {
        vec![self.term.into_dart(), self.data.into_dart()].into_dart()
    }
}
impl support::IntoDartExceptPrimitive for FullTerm {}

impl support::IntoDart for PartialTerm {
    fn into_dart(self) -> support::DartCObject {
        vec![self.term.into_dart(), self.references.into_dart()].into_dart()
    }
}
impl support::IntoDartExceptPrimitive for PartialTerm {}

impl support::IntoDart for PartialUnwrappedData {
    fn into_dart(self) -> support::DartCObject {
        vec![self.words.into_dart(), self.index.into_dart()].into_dart()
    }
}
impl support::IntoDartExceptPrimitive for PartialUnwrappedData {}

impl support::IntoDart for Reference {
    fn into_dart(self) -> support::DartCObject {
        vec![self.index.into_dart(), self.word_type.into_dart()].into_dart()
    }
}
impl support::IntoDartExceptPrimitive for Reference {}

impl support::IntoDart for Relation {
    fn into_dart(self) -> support::DartCObject {
        vec![
            self.relation.into_dart(),
            self.relation_type.into_dart(),
            self.word_type.into_dart(),
        ]
        .into_dart()
    }
}
impl support::IntoDartExceptPrimitive for Relation {}

impl support::IntoDart for RelationType {
    fn into_dart(self) -> support::DartCObject {
        match self {
            Self::Antonym => 0,
            Self::MemberHolonym => 1,
            Self::PartHolonym => 2,
            Self::SubstanceHolonym => 3,
            Self::VerbGroup => 4,
            Self::MemberMeronym => 5,
            Self::PartMeronym => 6,
            Self::SubstanceMeronym => 7,
            Self::SimilarTo => 8,
            Self::Entailment => 9,
            Self::DerivationallyRelatedForm => 10,
            Self::MemberOfThisDomainTopic => 11,
            Self::MemberOfThisDomainRegion => 12,
            Self::MemberOfThisDomainUsage => 13,
            Self::DomainOfSynsetTopic => 14,
            Self::DomainOfSynsetRegion => 15,
            Self::DomainOfSynsetUsage => 16,
            Self::ParticipleOfVerb => 17,
            Self::Attribute => 18,
            Self::Cause => 19,
            Self::Hypernym => 20,
            Self::InstanceHypernym => 21,
            Self::DerivedFromAdjective => 22,
            Self::PertainsToNoun => 23,
            Self::AlsoSee => 24,
            Self::Hyponym => 25,
            Self::InstanceHyponym => 26,
        }
        .into_dart()
    }
}

impl support::IntoDart for UnwrappedData {
    fn into_dart(self) -> support::DartCObject {
        vec![
            self.words.into_dart(),
            self.relations.into_dart(),
            self.definition.into_dart(),
            self.use_cases.into_dart(),
            self.word_type.into_dart(),
        ]
        .into_dart()
    }
}
impl support::IntoDartExceptPrimitive for UnwrappedData {}

impl support::IntoDart for UseCase {
    fn into_dart(self) -> support::DartCObject {
        vec![self.id.into_dart(), self.word_index.into_dart()].into_dart()
    }
}
impl support::IntoDartExceptPrimitive for UseCase {}

impl support::IntoDart for WordType {
    fn into_dart(self) -> support::DartCObject {
        match self {
            Self::Noun => 0,
            Self::Verb => 1,
            Self::Adjective => 2,
            Self::Satellite => 3,
            Self::Adverb => 4,
        }
        .into_dart()
    }
}
// Section: executor

support::lazy_static! {
    pub static ref FLUTTER_RUST_BRIDGE_HANDLER: support::DefaultHandler = Default::default();
}

// Section: sync execution mode utility

#[no_mangle]
pub extern "C" fn free_WireSyncReturnStruct(val: support::WireSyncReturnStruct) {
    unsafe {
        let _ = support::vec_from_leak_ptr(val.ptr, val.len);
    }
}
