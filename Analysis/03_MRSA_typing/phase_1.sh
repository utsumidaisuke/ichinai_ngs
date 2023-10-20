# 準備
mkdir -p results/$1/fastq results/$1/qc 

# quality check
fastqc data/$1_1.fastq.gz data/$1_2.fastq.gz -o results/$1/qc

# trimming
trim_galore --gzip --paired data/$1_1.fastq.gz data/$1_2.fastq.gz -o results/$1/fastq

# alignment
snippy --cpus 10 --force --outdir results/$1/$1 --ref gbk/CP003166.gb --R1 results/$1/fastq/$1_1_val_1.fq.gz --R2 results/$1/fastq/$1_2_val_2.fq.gz
