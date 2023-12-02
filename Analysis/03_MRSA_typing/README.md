# MRSA_typingの内容
各MRSAサンプルののショートリードをsnippyを使い参照配列にマッピングを行う<br>
各サンプルの配列のアライメントを行いコアゲノムを抽出する<br>
gubbinsで組み換え領域を除外した後に、snp情報から系統樹を作成<br>

## 参考文献
下記の論文の解析結果の再現を試みる<br>
組み換え配列の除外にClonalFrameMLを使っているが、本解析では代替としてgubbinsを使用<br>
今回は本論文の**CC59**のMRSAのデータを使って説明<br>
[Changes in the Genotypic Characteristics of Community-Acquired Methicillin-Resistant Staphylococcus aureus Collected in 244 Medical Facilities in Japan between 2010 and 2018: a Nationwide Surveillance](https://journals.asm.org/doi/epub/10.1128/spectrum.02272-21)

実際の解析フローは下記の論文に添付されているsnakemakeのフローに準じる<br>
[Whole Genome Sequencing Analysis of Porcine Faecal Commensal Escherichia coli Carrying Class 1 Integrons from Sows and Their Offspring](https://www.mdpi.com/2076-2607/8/6/843)<br>
[GitHubサイト](https://github.com/CJREID/snplord)

## 必要なツールの準備
#### 必要なライブラリのインストール
```
sudo apt-get install libtabixpp-dev
```
#### 仮想環境の構築
```
mamba create -n mrsa python=3.9 -y
mamba activate mrsa
```
#### 必要なライブラリのインストール
```
mamba install -c bioconda entrez-direct -y
mamba install -c bioconda parallel-fastq-dump -y
mamba install -c bioconda fastqc -y
mamba install -c bioconda trim-galore -y
mamba install -c bioconda snippy -y
mamba install -c bioconda gubbins -y
mamba install -c bioconda seqkit -y
mamba install -c bioconda igvtools -y
mamba install -c anaconda pandas -y
mamba install -c anaconda numpy -y
mamba install -c anaconda seaborn=0.13.0 -y
```
## リポジトリのクローン
```
git clone https://github.com/utsumidaisuke/ichinai_ngs.git
cd ichinai_ngs/Analysis/03_MRSA_typing/
```

## サンプルデータの準備
#### fastqデータのリポジトリ
[PRJDB11170](https://www.ncbi.nlm.nih.gov/Traces/study/?acc=DRP008386&o=acc_s%3Aa)

#### parallel-fastq-dumpでfastqファイルをダウンロード(data/に保存)
```
bash prep/prep_fastq.sh
```

## 参照ゲノム
CC8: [NC_007793](https://www.ncbi.nlm.nih.gov/nuccore/NC_007793)<br>
CC22: [NZ_CP007659](https://www.ncbi.nlm.nih.gov/nuccore/NZ_CP007659)<br>
CC30: [NZ_CP009361](https://www.ncbi.nlm.nih.gov/nuccore/NZ_CP009361)<br>
CC59: [CP003166](https://www.ncbi.nlm.nih.gov/nuccore/CP003166)

## リファレンスファイルの準備
#### efetchで参照配列を取得(gbk/に保存)
```
bash prep/prep_ref.sh
```

## 解析のフロー
解析のフェーズは２つに分かれる<br>
**1st phase**: 各サンプルの前処理と参照配列(P003166.gb)へのアライメント<br>
**2nd phase**: コアゲノム抽出および組み換え領域の除外、系統樹作成<br>
### 1st phase
1. fastqcでfastqファイルのクオリティーチェック<br>
2. trim-galoreでアダプタートリミング<br>
3. snippyで参照配列にリードをアライメント<br>
### 2nd phase
4. snippy-coreでコアゲノムを検出<br>
5. seqkitでアライメントデータから参照配列を除外<br>
6. snippy-clean_full_alnでアライメントデータのクリーニング<br>
7. run_gubbins.pyで組み換え領域を除外<br>
8. snp-sitesでSNPサイトを検出<br>
9. FastTreeで系統樹の作成<br>
10. ヒートマップの作成<br>

## 解析の実行
### 1st phaseの解析
各サンプルのQC、トリミング、アライメント
```
bash phase_1.sh CAM-1790
```
すべてのサンプルに対してphase_1.shを実施
```
for i in CAM-1790 CAM-1791 CAM-1961 CAM-1964 CAM-2026 CAM-2066 CAM-2096
do
bash phase_1.sh $i
done
```

#### phase_1.shの内容
```
# 解析結果保存用のディレクトリを作成
mkdir -p results/$1/fastq results/$1/qc

# fastqcでfastqファイルのクオリティーチェック
fastqc data/$1_1.fastq.gz data/$1_2.fastq.gz -o results/$1/qc

# trim-galoreでアダプタートリミング
trim_galore --gzip --paired data/$1_1.fastq.gz data/$1_2.fastq.gz -o results/$1/fastq

# snippyで参照配列(CP003166.gb)にリードをアライメント
snippy --cpus 10 --force --outdir results/$1/$1 --ref gbk/CP003166.gb --R1 results/$1/fastq/$1_1_val_1.fq.gz --R2 results/$1/fastq/$1_2_val_2.fq.gz
```

### 2nd phaseの解析
各サンプルのアライメントデータを統合して解析
```
bash phase_2.sh CAM-1790 CAM-1791 CAM-1961 CAM-1964 CAM-2026 CAM-2066 CAM-2096
```
#### phase_2.shの内容
heatmap画像が出力されるが、サンプルの順番を並べ替える必要あり<br>
その際には、heatmap_df.csvを利用する<br>
```
# snippy-coreでコアゲノムを検出
snippy-core  --ref gbk/CP003166.gb --prefix results/snippy-core/core $(for i in 1790 1791 1961 1964 2026 2066 2096; do echo results/CAM-$i/CAM-$i; done)

# seqkitでアライメントデータから参照配列を除外
seqkit grep -i -v -p Reference results/snippy-core/core.full.aln > results/snippy-core/core.full.noref.aln

# snippy-clean_full_alnでアライメントデータのクリーニング
snippy-clean_full_aln results/snippy-core/core.full.noref.aln > results/snippy-core/core.full.noref.clean.aln

# run_gubbins.pyで組み換え領域を除外
run_gubbins.py --threads 16 --prefix results/snippy-core/gubbins/gubbins results/snippy-core/core.full.noref.clean.aln

# snp-sitesでSNPサイトを検出
snp-sites -c results/snippy-core/gubbins/gubbins.filtered_polymorphic_sites.fasta > results/snippy-core/core.full.noref.clean.final.aln

# FastTreeで系統樹の作成
FastTree -gtr -nt results/snippy-core/core.full.noref.clean.final.aln  > results/snippy-core/core.full.noref.clean.final.newick

# ヒートマップの作成
python heatmap.py
```