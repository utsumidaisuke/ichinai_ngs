# Klebsiella_pneumoniae_genomeの内容  
**肺炎球菌サンプルのマッピング**  
肺炎球菌のサンプルfastqファイルを肺炎球菌の参照配列に対してマッピングを行う  

## 参考論文  
[Genomic epidemiology and temperature dependency of hypermucoviscous Klebsiella pneumoniae in Japan](https://pubmed.ncbi.nlm.nih.gov/35622495/)  
肺炎桿菌ゲノムをショート・ロングリードでDe novo assemblyし配列を決定  
genotypeごとに分類

## fastqファイルの取得
```
parallel -j 5 parallel-fastq-dump --threads 8 --split-files --gzip --outdir fastq --sra-id {} :::: sample.txt
```
