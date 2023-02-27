# 次世代シーケンサー(NGS)チュートリアル 

## このリポジトリの内容
**Analysis**: 実際に行う解析のワークフローなどの説明  
**Tutorial**: 個別の解析ツールの説明  

## 解析のための下準備
各種ツールをインストールするための環境を構築する必要あり  
M1 Macは様々な不具合が生じるので、使用を推奨しない

## 必要な環境の設定
(MacとWindowsは設定方法が異なる)  

### Macの場合
- [homebrew](https://brew.sh/index_ja)のインストール
```
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"	
```
- [mamba](https://github.com/conda-forge/miniforge)のインストール
```
wget -c https://github.com/conda-forge/miniforge/releases/latest/download/Mambaforge-MacOSX-x86_64.sh
/bin/bash -c Mambaforge-MacOSX-x86_64.sh
```
mambaのインストールが終了したら、一度ターミナルを閉じて再起動の必要あり  
再起動を行わないと、"mamba not found"のエラーが表示される

- 必要なツールのインストールをbrewで行う
```
brew install sratoolkit  
brew install wget  
brew install parallel
```
sratoolkit: fastqファイルをダウンロード  
wget: コマンドラインでファイルをダウンロード  
<br>  

### Windows Linuxの場合
(WindowsではWSLをインストールした後、**Ubuntu22.04**をインストールしている前提)
- [mamba](https://github.com/conda-forge/miniforge)のインストール
```
wget -c https://github.com/conda-forge/miniforge/releases/latest/download/Mambaforge-Linux-x86_64.sh
/bin/bash https://github.com/conda-forge/miniforge/releases/latest/download/Mambaforge-Linux-x86_64.sh  
```
インストール途中に下記のメッセージが表示されたときには、と表示されたときには"yes"と入力する  
```
Do you wish the installer to initialize Mambaforge by running conda init? [yes|no]
```

mambaのインストールが終了したら、一度ターミナルを閉じて再起動の必要あり   
再起動を行わないと、"mamba not found"のエラーが表示される
  
- 必要なツールのインストールをatpで行う
```
sudo apt update
sudo apt install sra-toolkit
sudo apt install parallel
```

## 仮想環境の構築 (MacとWindows共通)
- mambaで仮想環境を設定し立ち上げる
```
mamba create -n ngs python=3.10
mamba activate ngs
```

- 必要なツールのインストールをmambaで行う
```
mamba install -c bioconda igv -y
mamba install -c bioconda bwa -y
mamba install -c bioconda spades -y  
mamba install -c bioconda shovill -y  
mamba install -c bioconda unicycler -y
mamba install -c bioconda samtools -y
mamba install -c bioconda trim-galore -y
mamba install -c bioconda prodigal -y
mamba install -c bioconda seqkit -y
mamba install -c bioconda clustalo -y
mamba install -c bioconda java-jdk -y
mamba install -c bioconda blast -y
mamba install -c bioconda ncbi-genome-download -y
mamaba install -c bioconda parallel-fastq-dump -y
mamba install -c r r -y
```
igv: bamファイルの可視化  
bwa: fastqファイルのマッピング  
spades: De novo assembly  
unicycler: De novo assembly  
shovill: De novo assembly  
samtools: bam、samファイル操作  
trim-galore: リードデータからアダプタ配列を除去  
prodigal: ゲノム配列から遺伝子領域を予測   
seqkit: fastaファイルの操作  
clustalo: 塩基・アミノ酸のアライメント  
java-jdk: javaを実行するためのパッケージ  
blast: 塩基・アミノ酸のアライメント  
ncbi-genome-download: NCBIからゲノムデータを取得  
parallel-fastq-dump: SRAファイルの高速ダウンロード
r: R言語 
