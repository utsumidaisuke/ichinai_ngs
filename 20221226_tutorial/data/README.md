# データの取得方法  

### fastqファイルの取得
fastq-dumpでfastqファイルをダウンロードし、fastqディレクトリに保存
```
fastq-dump --gzip --split-files --outdir fastq SRR18253109
```

### 参照ファイルの取得  
fnaとgffファイルがダウンロード可能なサイト
```
https://www.ncbi.nlm.nih.gov/genome/?term=streptococcus%20pneumoniae
```

wgetでファイルをダウンロードし、refに保存  
gzファイルの解凍
```
wget -c https://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/002/076/835/GCF_002076835.1_ASM207683v1/GCF_002076835.1_ASM207683v1_genomic.gff.gz -O ref/streptococcus_pneumoniae.gff.gz
gunzip ref/streptococcus_pneumoniae.gff.gz
```
```
wget -c https://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/002/076/835/GCF_002076835.1_ASM207683v1/GCF_002076835.1_ASM207683v1_genomic.fna.gz -O ref/streptococcus_pneumoniae.fna.gz
gunzip ref/streptococcus_pneumoniae.fna.gz
```

