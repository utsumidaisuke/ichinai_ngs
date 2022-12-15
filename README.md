# 次世代シーケンサー(NGS)チュートリアル 
  
### 環境構築
各種ツールをインストールするための環境を構築する必要あり
- [homebrew](https://brew.sh/index_ja)のインストール
```
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"	
```
- [mamba](https://github.com/conda-forge/miniforge)のインストール
```
wget -c https://github.com/conda-forge/miniforge/releases/latest/download/Mambaforge-MacOSX-x86_64.sh
/bin/bash -c Mambaforge-MacOSX-x86_64.sh
```

### 仮想環境
mambaで仮想環境を設定し立ち上げる
```
mamba create -n strP python=3.10
mamba activate strP
```

### ツールのインストール
必要なツールのインストールをbrewとmambaで行う

**brew**
```
brew install sratoolkit
brew install wget
```
- sratoolkit: fastqファイルをダウンロード
- wget: コマンドラインでファイルをダウンロード

**mamba**
```
mamba install -c bioconda igv -y
mamba install -c bioconda bwa -y
mamba install -c bioconda spades -y
mamba install -c bioconda samtools -y
mamba install -c bioconda trim-galore -y
```
- igv: bamファイルの可視化
- bwa: fastqファイルのマッピング
- spades: De novo assembly
- samtools: bam、samファイル操作
- trim-galore: リードデータからアダプタ配列を除去
