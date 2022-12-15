# De novo assemly

### 解析内容 
肺炎球菌のilluminaとPacBioのリードデータからUnicyclerを使ってde novo assemblyを行う

### 参考サイト  
[Genome assembly: PacBio, Illumina and Illumina+PacBio hybrid data](https://bioinformaticshome.com/edu/Bioinformatics/Genome_Assembly/Bacterial_Genome/Genome_assembly_tutorial.html)

### パイプライン
**1. アダプターのトリミング**   
```
trim_galore --paired SRR18253109_1.fastq.gz SRR18253109_2.fastq.gz
```

**2. unicyclerでde nobo assembly**  
```
unicycler -1 SRR13873709_1_val_1.fq.gz -2 SRR13873709_2_val_2.fq.gz -l SRR13873708.fastq.gz --mode bold -o hybrid
```


