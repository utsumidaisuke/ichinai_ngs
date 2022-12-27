# De novo assemly

### 解析内容 
肺炎球菌のilluminaとPacBioのリードデータからUnicyclerを使ってde novo assemblyを行う

### 注意点
M1 Macではunicyclerが正常に動作しない  
メモリの小さい(4GB以下)だとunicyclerが途中で停止してしまう。  

### 参考サイト  
[Unicycler](https://github.com/rrwick/Unicycler)

### GFAファイル可視化ツール
[Bandage](https://rrwick.github.io/Bandage/)


### パイプライン
**1. アダプターのトリミング**   
```
trim_galore --paired SRR13873709_1.fastq.gz SRR13873709_2.fastq.gz
```

**2. unicyclerでde nobo assembly**  
```
unicycler -1 SRR13873709_1_val_1.fq.gz -2 SRR13873709_2_val_2.fq.gz -l SRR13873708.fastq.gz --mode bold -o hybrid
```

**3. prodigalで遺伝子了領域を予測**
```
prodigal -i hybrid/assembly.fasta -o hybrid/sp.genes -a hybrid/sp.faa
```

