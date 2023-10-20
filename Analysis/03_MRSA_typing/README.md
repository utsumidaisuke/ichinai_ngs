# MRSA_typingの内容
MRSAのショートリードを参照配列にマッピング<br>
snippyで複数サンプルのアライメント<br>
gubbinsで組み換え配列の削除<br>
snp情報から系統樹を作成<br>


## 参考文献
下記の論文の解析結果の再現を試みる<br>
組み換え配列の除外にClonalFrameMLを使っているが、本解析では代替としてgubbinsを使用<br>
[Changes in the Genotypic Characteristics of Community-Acquired Methicillin-Resistant Staphylococcus aureus Collected in 244 Medical Facilities in Japan between 2010 and 2018: a Nationwide Surveillance](https://journals.asm.org/doi/epub/10.1128/spectrum.02272-21)

実際の解析フローは下記の論文に添付されているsnakemakeのフローに準じる<br>
[Whole Genome Sequencing Analysis of Porcine Faecal Commensal Escherichia coli Carrying Class 1 Integrons from Sows and Their Offspring](https://www.mdpi.com/2076-2607/8/6/843)<br>
[GitHubサイト](https://github.com/CJREID/snplord)

## ダウンロードデータ
[PRJDB11170](https://www.ncbi.nlm.nih.gov/Traces/study/?acc=DRP008386&o=acc_s%3Aa)

## 参照ゲノム(data/fastaに保存)
CC8: [NC_007793](https://www.ncbi.nlm.nih.gov/nuccore/NC_007793)<br>
CC22: [NZ_CP007659](https://www.ncbi.nlm.nih.gov/nuccore/NZ_CP007659)<br>
CC30: [NZ_CP009361](https://www.ncbi.nlm.nih.gov/nuccore/NZ_CP009361)<br>
CC59: [CP003166](https://www.ncbi.nlm.nih.gov/nuccore/CP003166)

## 解析のフロー
解析のフェーズは２つに分かれる<br>
**1st phase**: 各サンプルの前処理と参照配列へのアライメント<br>
**2nd phase**: 各サンプルのアライメント情報を統合し処理<br>
#### 1st phase
- fastqcでfastqファイルのクオリティーチェック<br>
- trim-galoreでアダプタートリミング<br>
- snippyで参照配列にリードをアライメント<br>
#### 2nd phase
- snippy-coreでコアゲノムを検出<br>
- seqkitでアライメントデータから参照配列を除外<br>
- snippy-clean_full_alnでアライメントデータのクリーニング<br>
- run_gubbins.pyで組み換え領域を除外<br>
- snp-sitesでSNPサイトを検出<br>
- FastTreeで系統樹の作成<br>
- ヒートマップの作成<br>


## 各種ツールの準備
#### 必要なライブラリのインストール
```
sudo apt-get install libtabixpp-dev
```

### 仮想環境の構築
```
mamba create -n nishiyama python=3.9 -y
mamba activate nishiyama
```
#### 必要なライブラリのインストール
```
mamba install -c bioconda parallel-fastq-dump -y
mamba install -c bioconda fastqc -y
mamba install -c bioconda trim-galore -y
mamba install -c bioconda snippy -y
mamba install -c bioconda gubbins -y
mamba install -c bioconda seqkit -y
```
## サンプルデータの準備
### parallel-fastq-dumpでfastqファイルをダウンロード
```
bash prep_fastq.sh
```

## 解析の実行
### 1st phase
#### 解析結果保存用のディレクトリを作成
```
mkdir -p results/CAM-1790/fastq results/CAM-1790/qc
```
#### fastqcでfastqファイルのクオリティーチェック
```
fastqc data/CAM-1790_1.fastq.gz data/CAM-1790_2.fastq.gz -o results/CAM-1790/qc
```
#### trim-galoreでアダプタートリミング
```
trim_galore --gzip --paired data/CAM-1790_1.fastq.gz data/CAM-1790_2.fastq.gz -o results/CAM-1790/fastq
```
#### snippyで参照配列にリードをアライメント
```
snippy --cpus 10 --force --outdir results/CAM-1790/CAM-1790 --ref gbk/CP003166.gb --R1 results/CAM-1790/fastq/CAM-1790_1_val_1.fq.gz --R2 results/CAM-1790/fastq/CAM-1790_2_val_2.fq.gz
```
### 2nd phase
#### snippy-coreでコアゲノムを検出
```
snippy-core  --ref gbk/CP003166.gb --prefix results/snippy-core/core $(for i in 1790 1791 1961 1964 2026 2066 2096; do echo results/CAM-$i/CAM-$i; done)
```
#### seqkitでアライメントデータから参照配列を除外
```
seqkit grep -i -v -p Reference results/snippy-core/core.full.aln > results/snippy-core/core.full.noref.aln
```
#### snippy-clean_full_alnでアライメントデータのクリーニング
```
snippy-clean_full_aln results/snippy-core/core.full.noref.aln > results/snippy-core/core.full.noref.clean.aln
```
#### run_gubbins.pyで組み換え領域を除外
```
run_gubbins.py --threads 16 --prefix results/snippy-core/gubbins/gubbins results/snippy-core/core.full.noref.clean.aln
```
#### snp-sitesでSNPサイトを検出
```
snp-sites -c results/snippy-core/gubbins/gubbins.filtered_polymorphic_sites.fasta > results/snippy-core/core.full.noref.clean.final.aln
```
#### FastTreeで系統樹の作成
```
FastTree -gtr -nt results/snippy-core/core.full.noref.clean.final.aln  > results/snippy-core/core.full.noref.clean.final.newick
```
#### ヒートマップの作成
```
python heatmap.py
```