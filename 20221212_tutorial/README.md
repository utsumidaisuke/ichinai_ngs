# 20221212_tutorialの内容  
**肺炎球菌サンプルのマッピング**  
- 肺炎球菌のサンプルfastqファイルを肺炎球菌の参照配列に対してマッピングを行う  

## 参考論文  
[Using whole genome sequencing to identify resistance determinants and predict antimicrobial resistance phenotypes for year 2015 invasive pneumococcal disease isolates recovered in the United States](https://pubmed.ncbi.nlm.nih.gov/27542334/)

## データ内容
pdf: 利用したfastqファイルの元論文

## fastqファイルの取得
fastq-dumpでfastqファイルをダウンロード
```
fastq-dump --gzip --split-files --outdir fastq SRR18253109
```

## 参照ファイルの取得
fnaとgffファイルがダウンロード可能なサイト
```
https://www.ncbi.nlm.nih.gov/genome/?term=streptococcus%20pneumoniae
```

wgetでファイルをダウンロードし、refディレクトリに保存
gzファイルの解凍
```
wget -c https://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/002/076/835/GCF_002076835.1_ASM207683v1/GCF_002076835.1_ASM207683v1_genomic.gff.gz -O ref/streptococcus_pneumoniae.gff.gz
gunzip ref/streptococcus_pneumoniae.gff.gz
```
```
wget -c https://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/002/076/835/GCF_002076835.1_ASM207683v1/GCF_002076835.1_ASM207683v1_genomic.fna.gz -O ref/streptococcus_pneumoniae.fna.gz
gunzip ref/streptococcus_pneumoniae.fna.gz
