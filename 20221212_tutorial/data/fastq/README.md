# マッピング

### 肺炎球菌の参照ゲノム配列に対して、サンプルのリードをマッピングする
1. アダプターのトリミング 
```
trim_galore --paired SRR18253109_1.fastq.gz SRR18253109_2.fastq.gz
```

1. bwaでマッピング
```
bwa mem -M -t 1 -R "@RG\tID:genome_tuto\tSM:tuto\tPL:ILLUMINA\tLB:tuto" ../ref/streptococcus_pneumoniae.fna SRR18253109_1_val_1.fq.gz SRR18253109_2_val_2.fq.gz > sp.sam
```

1. samtoolsでsamファイルをbamファイルに変換
```
samtools view -h sp.sam > sp.bam
```

1. bamファイルのソート
```
samtools sort sp.bam > sp_sort.bam
```

1. bamファイルのインデックスを作成
```
samtools index sp_sort.bam
```
