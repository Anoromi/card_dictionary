use anyhow::Result;
use tokio::{
    fs::File,
    io::{AsyncReadExt, BufReader},
};

pub(crate) struct SizedReader {
    reader: BufReader<File>,
    len: u64,
}

impl std::ops::DerefMut for SizedReader {
    fn deref_mut(&mut self) -> &mut Self::Target {
        &mut self.reader
    }
}

impl std::ops::Deref for SizedReader {
    type Target = BufReader<File>;

    fn deref(&self) -> &Self::Target {
        &self.reader
    }
}

impl SizedReader {
    #[inline]
    pub(crate) async fn from_file(file: File) -> Result<Self> {
        let len = dbg!(file.metadata().await?.len());
        Ok(Self {
            reader: BufReader::new(file),
            len,
        })
    }

    pub(crate) fn len(&self) -> u64 {
        self.len
    }

    pub(crate) async fn read_string(&mut self, count: u64) -> Result<String> {
        let mut buffer = Vec::new();
        for _ in 0..count {
            let next = self.read_u8().await?;
            buffer.push(next);
            if next & 128 == 0 {
            } else if next & 32 == 0 {
                buffer.push(self.read_u8().await?);
            } else if next & 16 == 0 {
                buffer.push(self.read_u8().await?);
                buffer.push(self.read_u8().await?);
            } else {
                buffer.push(self.read_u8().await?);
                buffer.push(self.read_u8().await?);
                buffer.push(self.read_u8().await?);
            }
        }
        // dbg!(buffer.iter().map(|v| *v as char).collect::<Vec<_>>());
        // dbg!(String::from_utf8(buffer.clone()));
        Ok(String::from_utf8(buffer)?)
    }

    pub(crate) async fn read_variable_u64(&mut self) -> Result<u64> {
        let mut v = 0u64;
        let mut shift = 0u64;
        let mut next = self.read_u8().await?;
        while next & 128 == 0 {
           v |= (next as u64) << shift;
           next = self.read_u8().await?;
           shift += 7;
        }
        v |= (((next & 127) as u64) << shift) as u64;
        Ok(v)
    }
}
