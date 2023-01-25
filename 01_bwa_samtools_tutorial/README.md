# 20221212_tutorialの内容  
**肺炎球菌サンプルのマッピング**  
肺炎球菌のサンプルfastqファイルを肺炎球菌の参照配列に対してマッピングを行う  

## 参考論文  
[Using whole genome sequencing to identify resistance determinants and predict antimicrobial resistance phenotypes for year 2015 invasive pneumococcal disease isolates recovered in the United States](https://pubmed.ncbi.nlm.nih.gov/27542334/)  
pdfディレクトリに利用したfastqファイルの元論文  
上記論文のデータをサンプルデータとして利用

## fastqファイルの取得
fastq-dumpでfastqファイルをダウンロードし、fastqディレクトリに保存
```
fastq-dump --gzip --split-files --outdir fastq SRR18253109
```

## 参照ファイルの取得
fnaとgffファイルがダウンロード可能なサイト  
ダウンロードしたファイルはrefディレクトリに保存
```
https://www.ncbi.nlm.nih.gov/genome/?term=streptococcus%20pneumoniae
```

wgetでファイルをダウンロード
gzファイルの解凍
```
wget -c https://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/002/076/835/GCF_002076835.1_ASM207683v1/GCF_002076835.1_ASM207683v1_genomic.gff.gz -O ref/streptococcus_pneumoniae.gff.gz
gunzip ref/streptococcus_pneumoniae.gff.gz
```
```
wget -c https://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/002/076/835/GCF_002076835.1_ASM207683v1/GCF_002076835.1_ASM207683v1_genomic.fna.gz -O ref/streptococcus_pneumoniae.fna.gz
gunzip ref/streptococcus_pneumoniae.fna.gz

## マッピング
肺炎球菌の参照ゲノム配列に対して、サンプルのリードをマッピングする
**パイプライン**

**1. アダプターのトリミング**   
```
trim_galore --paired SRR18253109_1.fastq.gz SRR18253109_2.fastq.gz
```

**2. bwaでマッピング**  
```
bwa mem -M -t 1 -R "@RG\tID:genome_tuto\tSM:tuto\tPL:ILLUMINA\tLB:tuto" ../ref/streptococcus_pneumoniae.fna SRR18253109_1_val_1.fq.gz SRR18253109_2_val_2.fq.gz > sp.sam
```

**3. samtoolsでsamファイルをbamファイルに変換**
```
samtools view -bS sp.sam > sp.bam
```

**4. bamファイルのソート**
```
samtools sort sp.bam > sp_sort.bam
```

**5. bamファイルのインデックスを作成**
```
samtools index sp_sort.bam
```

**6 sp_sort.bamをigvで閲覧**
```
igv
```

