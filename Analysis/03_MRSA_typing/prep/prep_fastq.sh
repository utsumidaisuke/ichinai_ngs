# テストデータのダウンロード
parallel-fastq-dump --threads 8 --split-files --gzip --outdir ../data --sra-id DRR272466 DRR272467 DRR272504 DRR272505 DRR272522 DRR272529 DRR272539
mv ../data/DRR272466_1.fastq.gz ../data/CAM-1790_1.fastq.gz
mv ../data/DRR272467_1.fastq.gz ../data/CAM-1791_1.fastq.gz
mv ../data/DRR272504_1.fastq.gz ../data/CAM-1961_1.fastq.gz
mv ../data/DRR272505_1.fastq.gz ../data/CAM-1964_1.fastq.gz
mv ../data/DRR272522_1.fastq.gz ../data/CAM-2026_1.fastq.gz
mv ../data/DRR272529_1.fastq.gz ../data/CAM-2066_1.fastq.gz
mv ../data/DRR272539_1.fastq.gz ../data/CAM-2096_1.fastq.gz
mv ../data/DRR272466_2.fastq.gz ../data/CAM-1790_2.fastq.gz
mv ../data/DRR272467_2.fastq.gz ../data/CAM-1791_2.fastq.gz
mv ../data/DRR272504_2.fastq.gz ../data/CAM-1961_2.fastq.gz
mv ../data/DRR272505_2.fastq.gz ../data/CAM-1964_2.fastq.gz
mv ../data/DRR272522_2.fastq.gz ../data/CAM-2026_2.fastq.gz
mv ../data/DRR272529_2.fastq.gz ../data/CAM-2066_2.fastq.gz
mv ../data/DRR272539_2.fastq.gz ../data/CAM-2096_2.fastq.gz