# Klebsiella_pneumoniae_genomeの内容  
**肺炎球菌サンプルのマッピング**  
肺炎球菌のサンプルfastqファイルを肺炎球菌の参照配列に対してマッピングを行う  

## 参考論文  
[Genomic epidemiology and temperature dependency of hypermucoviscous Klebsiella pneumoniae in Japan](https://pubmed.ncbi.nlm.nih.gov/35622495/)  
肺炎桿菌ゲノムをショート・ロングリードでDe novo assemblyし配列を決定  
genotypeごとに分類

## 論文内のサンプルデータ情報
https://www.ncbi.nlm.nih.gov/Traces/study/?acc=DRP007748&o=acc_s%3Aa

## 上記のサイトの情報をもとにDRRのIDリストを作成した
**samples.txt**: 論文内で解析されているすべてのサンプルのDRRのIDを記載   

## 各サンプルのfastqファイルの取得
DRRのIDをもとにparallel-fastq-dumpを使ってfastq.gzファイルをダウンロード  
ダウンロード後のファイル合計サイズは58G程度  
```
parallel -j 5 parallel-fastq-dump --threads 8 --split-files --gzip --outdir fastq --sra-id {} :::: sample.txt
```
