use std::{
    cell::RefCell,
    fs::File,
    io::{BufReader, Read},
    sync::atomic::AtomicU64,
};

use anyhow::Result;
use once_cell::sync::OnceCell;
use tokio::{runtime::Runtime, sync::Mutex};

use crate::wordnet::{
    repository::Repository,
    terms::{FullTerm, PartialTerm},
};

static COUNTER: AtomicU64 = AtomicU64::new(0);

static PATH: Mutex<OnceCell<String>> = Mutex::const_new(OnceCell::new());

#[tokio::main(flavor = "current_thread")]
pub async fn try_init(path: String) {
    let locked = PATH.lock().await;
    locked.get_or_init(|| path);

}

#[tokio::main(flavor = "current_thread")]
pub async fn find_suggestions(text: String, count: u32) -> Result<Vec<PartialTerm>> {
    let mut path = Repository::from_path(PATH.lock().await.get().unwrap().as_str()).await?;
    Ok(path.find_terms(&text, count as u64).await?)
}

#[tokio::main(flavor = "current_thread")]
pub async fn unwrap_term(term: PartialTerm) -> Result<FullTerm> {
    let mut path = Repository::from_path(PATH.lock().await.get().unwrap().as_str()).await?;
    Ok(path.unwrap_term(&term).await?)
}

pub fn get() -> u64 {
    COUNTER.fetch_add(1, std::sync::atomic::Ordering::SeqCst)
}

#[tokio::main(flavor = "current_thread")]
pub async fn read(file_path: String) -> Result<String> {
    let mut file = BufReader::new(File::open(file_path)?);
    let mut buf = String::new();
    file.read_to_string(&mut buf)?;
    Ok(buf)
}
