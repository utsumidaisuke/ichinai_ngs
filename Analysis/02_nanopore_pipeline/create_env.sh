# pythonのバージョンは3.8で構築
# mamba create -n medaka python=3.8

# guupy-gpuは下記のサイトからパッケージをダウンロードしインストール
# https://community.nanoporetech.com/downloads

# sudo apt update
# for i in bzip2 g++ zlib1g-dev libbz2-dev liblzma-dev libffi-dev libncurses5-dev libcurl4-gnutls-dev libssl-dev curl make cmake wget python3-all-dev gdebi-core
# do
# sudo apt install $i
# done

sudo apt -y install gdebi-core 
curl -O -L https://github.com/BV-BRC/BV-BRC-CLI/releases/download/1.040/bvbrc-cli-1.040.deb
sudo gdebi bvbrc-cli-1.040.deb -y
rm bvbrc-cli-1.040.deb


# NanoPlot、NanoStatのインストール
mamba install -c bioconda nanostat -y
mamba install -c bioconda nanoplot -y

# filtlongのインストール
mamba install -c bioconda filtlong -y

# flyeとgraphvizのインストール
mamba install -c bioconda graphviz -y
mamba install -c bioconda flye -y

# ont-fast5-apiのインストール
mamba install -c bioconda ont-fast5-api -y

# seqkitのインストール
mamba install -c bioconda seqkit -y

# rebalerのインストール
mamba install -c bioconda rebaler -y

# 各種ライブラリ
mamba install -c conda-forge gsl=2.5 -y

# Kleborateに必要なツールをインストール
mamba install biopython -y
mamba install blast -y
mamba install mash -y

# medakaおよび依存関係ツールのインストール
mamba install -c bioconda minimap2=2.11 -y
mamba install -c bioconda bcftools=1.11 -y
mamba install -c bioconda samtools=1.11 -y
pip install medaka

# Kleborateのインストール
cd config
git clone --recursive https://github.com/katholt/Kleborate.git
cd Kleborate/kaptive
git pull https://github.com/katholt/Kaptive master
cd ../
python3 setup.py install
cd ../
