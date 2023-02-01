# unicycler_tutorialの内容  
**肺炎球菌サンプルのde novo assembly**  
参考論文のMinionとilluminaデータからunicyclerを使用し、de novo assemblyを行う

## unicycler
ショートリードとロングリードからde novo assemblyを行いバクテリアゲノム配列を決定する
[github](https://github.com/rrwick/Unicycler)  

## 参考論文  
[Complete Genome Sequence of Streptococcus pneumoniae Strain Rx1, a Hex Mismatch Repair-Deficient Standard Transformation Recipient](https://pubmed.ncbi.nlm.nih.gov/34647809/)
pdfディレクトリに利用したfastqファイルの元論文

## fastqファイルの取得
fastq-dumpでfastqファイルをダウンロードし、fastqディレクトリに保存  
SRR13873708: minionデータ  
SRR13873709: illuminaデータ
```
fastq-dump --gzip --outdir fastq SRR13873708
fastq-dump --gzip --split-files --outdir fastq SRR13873709
```

## De novo assembly
unicyclerを用いてショートリードとロングリードをハイブリッドでde novo assemblyする  
  
**unicycler実行時の注意点**  
M1 Macではunicyclerが正常に動作しない  
メモリの小さい(4GB以下)だとunicyclerが途中で停止してしまう。  

**参考サイト**   
[Unicycler](https://github.com/rrwick/Unicycler): De novo assemblyツール   
[Bandage](https://rrwick.github.io/Bandage/): FASTAファイル可視化ツール  

## パイプライン
**1. アダプターのトリミング**   
```
trim_galore --paired fastq/SRR13873709_1.fastq.gz fastq/SRR13873709_2.fastq.gz
```

**2. unicyclerでde novo assembly**  
```
unicycler -1 SRR13873709_1_val_1.fq.gz -2 SRR13873709_2_val_2.fq.gz -l fastq/SRR13873708.fastq.gz --mode bold -o result
```

**3. prodigalで遺伝子了領域を予測**
```
prodigal -i result/assembly.fasta -o result/sp.genes -a result/sp.faa
```

