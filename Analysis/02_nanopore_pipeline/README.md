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

### guppy (GPUの設定が必要)   
[サイト](https://community.nanoporetech.com/downloads): 環境にあったインストーラーをダウンロード 

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

### Kleborateをよび必要なライブラリのインストール
```
mamba install biopython -y
mamba install blast -y
mamba install mash -y
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
