#[cfg(test)]
mod test {

    use anyhow::Result;

    use crate::wordnet::{enum_types::WordType, repository::Repository};

    #[tokio::test]
    async fn ft1() -> Result<()> {
        let mut ha = Repository::from_path(
            r"C:/Users/Andrii/.vscode/code/flutter/fst/packages/wordnet_dictionary/data",
        )
        .await?;
        dbg!(ha.find_terms("lya", 10).await?);
        // let bound = "ly";
        // dbg!(ha[WordType::Noun].term(bound).await?);
        // dbg!(ha[WordType::Verb].term(bound).await?);
        // dbg!(ha[WordType::Adjective].term(bound).await?);
        // dbg!(ha[WordType::Adverb].term(bound).await?);
        Ok(())
    }

    #[tokio::test]
    async fn ft2() -> Result<()> {
        let mut ha =
            Repository::from_path(r"C:\Users\Andrii\.vscode\code\flutter\fst\assets\data").await?;
        // dbg!(ha[WordType::Adverb].term("v").await? );
        dbg!(ha.find_terms("v", 20).await?);
        // let bound = "ly";
        // dbg!(ha[WordType::Noun].term(bound).await?);
        // dbg!(ha[WordType::Verb].term(bound).await?);
        // dbg!(ha[WordType::Adjective].term(bound).await?);
        // dbg!(ha[WordType::Adverb].term(bound).await?);
        Ok(())
    }

    #[tokio::test]
    async fn tu1() -> Result<()> {
        let mut ha =
            Repository::from_path(r"C:\Users\Andrii\.vscode\code\flutter\fst\assets\data").await?;
        let v = dbg!(ha
            .find_terms("la", 3)
            .await?
            .into_iter()
            .skip(1)
            .next()
            .unwrap());
        dbg!(ha.unwrap_term(&v).await?);
        Ok(())
    }
}
