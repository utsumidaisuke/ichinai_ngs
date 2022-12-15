# データの取得方法  

### fastqファイルの取得
fastq-dumpでfastqファイルをダウンロードし、fastqディレクトリに保存
```
fastq-dump --gzip --outdir fastq SRR13873708 
fastq-dump --gzip --split-files --outdir fastq SRR13873709
```

