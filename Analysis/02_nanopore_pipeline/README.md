# nanopore_pipelineの内容
minionから出力されたfast5ファイルをもとにした解析パイプラインの実行  
  

## 解析のフロー
1. guppyでベースコールし、fast5からfastqファイルへの変換
2. NanoPlotでクオリティーチェック
3. filtlongでトリミング
4. fastqファイルの統合および、重複の修正
5. flyeでassembly
6. medakaでpolishing
7. kleborateで菌種のアノテーション
8. RAST-tkで遺伝子領域のアノテーション
  

## 解析するfast5ファイル
dataディレクトリにfast5ファイルを保存
  

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
  
  
## 解析の実行
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
medaka_consensus -i output/filtered/combined.renamed.fastq -d output/flye_assembly/assembly.fasta -o output/medaka -t 20
```

### Kleborateでアノテーション
```
kleborate -a output/medaka/consensus.fasta --all -o output/kleborate/kleborate_result.txt
```

# RAST-tkでアノテーション
```
rast-create-genome --scientific-name "Klebsiella pneumoniae" --genetic-code 11 --domain Bacteria --contigs output/medaka/consensus.fasta > output/RASTtk/K_pneumoniae.gto
rast-process-genome -i output/RASTtk/K_pneumoniae.gto -o output/RASTtk/K_pneumoniae.gto2
rast-export-genome genbank -i output/RASTtk/K_pneumoniae.gto2 -o output/RASTtk/K_pneumoniae.gbk
```
