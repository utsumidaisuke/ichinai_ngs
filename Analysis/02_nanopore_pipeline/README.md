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

### guppy (GPUの設定が必要)   
[サイト](https://community.nanoporetech.com/downloads): 環境にあったインストーラーをダウンロード 

### medaka
medakaに必要なライブラリのインストール
```
sudo apt update
for i in bzip2 g++ zlib1g-dev libbz2-dev liblzma-dev libffi-dev libncurses5-dev libcurl4-gnutls-dev libssl-dev curl make cmake wget python3-all-dev gdebi-core
do
sudo apt install $i
done
``` 
medakaおよび依存関係ツールのインストール
```
mamba install -c bioconda minimap2=2.11 -y
mamba install -c bioconda bcftools=1.11 -y
mamba install -c bioconda samtools=1.11 -y
pip install medaka
```
