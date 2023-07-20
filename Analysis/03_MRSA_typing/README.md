# MRSA_typingの内容
MRSAのショートリードをマッピングし、vcfファイルから系統樹を作成

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

## 1. fastqファイルの取得
dataディレクトリにfast5ファイルを保存
<br><br>  
## 各種ツールの下準備と関連情報
### 仮想環境の構築
```
mamba create -n nano_pipe python=3.8 -y
mamba activate nano_pipe
```
### 必要なライブラリのインストール
```
sudo apt update
for i in bzip2 g++ zlib1g-dev libbz2-dev liblzma-dev libffi-dev libncurses5-dev libcurl4-gnutls-dev libssl-dev curl make cmake wget python3-all-dev gdebi-core
do
sudo apt install $i
done
```
### guppyのインストール (GPUの設定が必要)   
[サイト](https://community.nanoporetech.com/downloads): 環境にあったインストーラーをダウンロード 
```
wget -c https://cdn.oxfordnanoportal.com/software/analysis/ont_guppy_6.4.6-1~focal_amd64.deb
sudo apt install ont_guppy_6.4.6-1~focal_amd64.deb
rm ont_guppy_6.4.6-1~focal_amd64.deb
```
### RAST-tkのインストール
```
curl -O -L https://github.com/BV-BRC/BV-BRC-CLI/releases/download/1.040/bvbrc-cli-1.040.deb
sudo gdebi bvbrc-cli-1.040.deb -y
rm bvbrc-cli-1.040.deb
```
### NanoPlot、filtlong、flye、ont-fast5-api、seqkit、gslのインストール
```
mamba install -c bioconda nanoplot -y
mamba install -c bioconda filtlong -y
mamba install -c bioconda graphviz -y
mamba install -c bioconda flye -y
mamba install -c bioconda ont-fast5-api -y
mamba install -c bioconda seqkit -y
mamba install -c conda-forge gsl=2.5 -y
```
### Kleborateおよび必要なライブラリのインストール
```
mamba install -c conda-forge biopython -y
mamba install -c bioconda blast -y
mamba install -c bioconda mash -y
```
```
cd config
git clone --recursive https://github.com/katholt/Kleborate.git
cd Kleborate/kaptive
git pull https://github.com/katholt/Kaptive master
cd ../
python3 setup.py install
cd ../
```
### medakaおよび必要なライブラリのインストール
```
mamba install -c bioconda minimap2=2.11 -y
mamba install -c bioconda bcftools=1.11 -y
mamba install -c bioconda samtools=1.11 -y
pip install medaka
```
<br><br>
## 解析の実行
### 保存ディレクトリの作成
```
for i in filtered flye_assembly guppy kleborate medaka nano_summary RASTtk
do
mkdir -p output/$i
done
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