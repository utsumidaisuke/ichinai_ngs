# 20221226_tutorialの内容  
- **肺炎球菌サンプルのde novo assembly**  
  - 参考論文のMinionとilluminaデータからunicyclerを使用し、de novo assemblyを行う

## 参考論文  
- [Complete Genome Sequence of Streptococcus pneumoniae Strain Rx1, a Hex Mismatch Repair-Deficient Standard Transformation Recipient](https://pubmed.ncbi.nlm.nih.gov/34647809/)
- pdf: 利用したfastqファイルの元論文

## fastqファイルの取得
fastq-dumpでfastqファイルをダウンロードし、fastqディレクトリに保存
```
fastq-dump --gzip --outdir fastq SRR13873708
fastq-dump --gzip --split-files --outdir fastq SRR13873709
