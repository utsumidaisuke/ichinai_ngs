# MRSA_typingの内容
MRSAのショートリードをマッピングし、vcfファイルから系統樹を作成
簡略化目的にCC30のサンプルのみ使用

## 文献
[Changes in the Genotypic Characteristics of Community-Acquired Methicillin-Resistant Staphylococcus aureus Collected in 244 Medical Facilities in Japan between 2010 and 2018: a Nationwide Surveillance](https://journals.asm.org/doi/epub/10.1128/spectrum.02272-21)

## ダウンロードデータ
[PRJDB11170](https://www.ncbi.nlm.nih.gov/Traces/study/?acc=DRP008386&o=acc_s%3Aa)

## 参照ゲノム
CC8: [NC_007793](https://www.ncbi.nlm.nih.gov/nuccore/NC_007793)<br>
CC22: [NZ_CP007659](https://www.ncbi.nlm.nih.gov/nuccore/NZ_CP007659)<br>
CC30: [NZ_CP009361](https://www.ncbi.nlm.nih.gov/nuccore/NZ_CP009361)<br>
CC59: [CP003166](https://www.ncbi.nlm.nih.gov/nuccore/CP003166)

## 解析のフロー
1. MRSAの各サンプルのfastqファイルの取得
2. 各MRSAタイプのゲノムにbwaでマッピング
3. bamファイルをsamtoolsのmpileupで統合
4. 統合したmpileupファイルをvarascanでバリアントコールし、vcfファイルを作成
5. vcf2phylip.pyでvcfファイルをphyファイルに変換
6. phymlでphyファイルを読み込み、系統樹を作成
7. FigTreeで系統樹を可視化

## 各種ツールの準備
### 仮想環境の構築
```
mamba create -n mrsa python=3.10 -y
mamba activate nano_pipe
```
### 必要なライブラリのインストール
```
mamba install -c bioconda parallel-fastq-dump -y
mamba install -c bioconda sra-tools -y
mamba install -c bioconda bwa -y
mamba install -c bioconda samtools -y
mamba install -c bioconda varscan -y
mamba install -c bioconda phyml -y
```
### vcf2phylip.pyのインストール
[vcf2phylip](https://github.com/edgardomortiz/vcf2phylip): vcf2phylip.pyの実行ファイルの取得
```
git clone https://github.com/edgardomortiz/vcf2phylip.git
```

## 解析の実行
### fastqファイルの取得
```
for i in $(cat data/download_list.txt); do parallel-fastq-dump --threads 8 --split-files --gzip --outdir data/fastq --sra-id $i; done
```
### guppyでベースコールしfast5をfastqに変換
```
guppy_basecaller --flowcell FLO-MIN106 --kit SQK-RBK004 -x cuda:0 -i data -s output/guppy -r
```
### NanoPlotででクオリティーチェック
```
NanoPlot --summary output/guppy/sequencing_summary.txt --loglength -o output/nano_summary
```
### filtlongでトリミング
```
for i in $(ls output/guppy/pass/*.fastq | sed -e 's/\.fastq//g' | sed -e 's/output\/guppy\/pass\///g')
do
filtlong --min_length 1000 --keep_percent 90 output/guppy/pass/$i\.fastq | gzip -> output/filtered/$i\.filtered.fastq.gz
done
```
### fastq.gzを統合し、idの重複を修正
```
cat output/filtered/*gz > output/filtered/combined.fastq.gz
seqkit rename output/filtered/combined.fastq.gz > output/filtered/combined.renamed.fastq
```
### flyeでassembly
```
flye --nano-raw output/filtered/combined.renamed.fastq --out-dir output/flye_assembly --threads 50 --scaffold
```
### medakaでpolishing
```
```
### Kleborateでアノテーション
```
kleborate -a output/medaka/consensus.fasta --all -o output/kleborate/kleborate_result.txt
```
### RAST-tkでアノテーション
```
rast-create-genome --scientific-name "Klebsiella pneumoniae" --genetic-code 11 --domain Bacteria --contigs output/medaka/consensus.fasta > output/RASTtk/K_pneumoniae.gto
rast-process-genome -i output/RASTtk/K_pneumoniae.gto -o output/RASTtk/K_pneumoniae.gto2
rast-export-genome genbank -i output/RASTtk/K_pneumoniae.gto2 -o output/RASTtk/K_pneumoniae.gbk
```
