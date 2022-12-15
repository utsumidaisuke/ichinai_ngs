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

**2. spades.pyでde nobo assembly**  
```
unicycler -1 SRR15216322_1.fastq.gz -2 SRR15216322_2.fastq.gz -l SRR15216323.fastq -o hybrid --mode bold
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
