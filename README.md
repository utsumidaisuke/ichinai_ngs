# 次世代シーケンサー(NGS)チュートリアル 
  
### 解析のための下準備
各種ツールをインストールするための環境を構築する必要あり  
<br>

### 必要なツールの設定
(MacとWindowsは設定方法が異なる)  
<br>

**macの場合**
- [homebrew](https://brew.sh/index_ja)のインストール
```
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"	
```
- [mamba](https://github.com/conda-forge/miniforge)のインストール
```
wget -c https://github.com/conda-forge/miniforge/releases/latest/download/Mambaforge-MacOSX-x86_64.sh
/bin/bash -c Mambaforge-MacOSX-x86_64.sh
```

必要なツールのインストールをbrewとmambaで行う
**brew**
```
brew install sratoolkit
brew install wget
```
- sratoolkit: fastqファイルをダウンロード
- wget: コマンドラインでファイルをダウンロード  
<br>  

**Windows Linuxの場合**
(WindowsではWSLをインストールした後、Ubuntu20.04をインストールしている前提)
- [mamba](https://github.com/conda-forge/miniforge)のインストール
```
wget -c https://github.com/conda-forge/miniforge/releases/latest/download/Mambaforge-Linux-x86_64.sh
/bin/bash https://github.com/conda-forge/miniforge/releases/latest/download/Mambaforge-Linux-x86_64.sh
```
必要なツールのインストールをatpで行う
```
sudo apt update
sudo apt install sra-toolkit
```

### 仮想環境の構築
mambaで仮想環境を設定し立ち上げる
```
mamba create -n strP python=3.10
mamba activate strP
```

**mamba**
```
mamba install -c bioconda igv -y
mamba install -c bioconda bwa -y
mamba install -c bioconda spades -y
mamba install -c bioconda unicycler -y
mamba install -c bioconda samtools -y
mamba install -c bioconda trim-galore -y
mamba install -c bioconda prodigal -y
mamba install -c bioconda sra-tools -y
```
- igv: bamファイルの可視化
- bwa: fastqファイルのマッピング
- spades: De novo assembly
- unicycler: De novo assembly
- samtools: bam、samファイル操作
- trim-galore: リードデータからアダプタ配列を除去
- prodigal: ゲノム配列から遺伝子領域を予測
