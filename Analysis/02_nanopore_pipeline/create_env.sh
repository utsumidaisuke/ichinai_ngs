### 必要なライブラリのインストール
sudo apt update
for i in bzip2 g++ zlib1g-dev libbz2-dev liblzma-dev libffi-dev libncurses5-dev libcurl4-gnutls-dev libssl-dev curl make cmake wget python3-all-dev gdebi-core libgfortran4
do
sudo apt -y install $i
done

### guppyのインストール (GPUの設定が必要)
wget -c https://cdn.oxfordnanoportal.com/software/analysis/ont_guppy_6.4.6-1~focal_amd64.deb
sudo apt -y install ./ont_guppy_6.4.6-1~focal_amd64.deb

### RAST-tkのインストール
curl -O -L https://github.com/BV-BRC/BV-BRC-CLI/releases/download/1.040/bvbrc-cli-1.040.deb
sudo gdebi bvbrc-cli-1.040.deb
rm bvbrc-cli-1.040.deb

### NanoPlot、filtlong、flye、ont-fast5-api、seqkit、gslのインストール
mamba install -c bioconda nanoplot -y
mamba install -c bioconda filtlong -y
mamba install -c bioconda graphviz -y
mamba install -c bioconda flye -y
mamba install -c bioconda ont-fast5-api -y
mamba install -c bioconda seqkit -y
mamba install -c conda-forge gsl=2.5 -y

### Kleborateおよび必要なライブラリのインストール
mamba install biopython -y
mamba install blast -y
mamba install mash -y
cd config
git clone --recursive https://github.com/katholt/Kleborate.git
cd Kleborate/kaptive
git pull https://github.com/katholt/Kaptive master
cd ../
python3 setup.py install
cd ../

### medakaおよび必要なライブラリのインストール
mamba install -c bioconda minimap2=2.11 -y
mamba install -c bioconda bcftools=1.11 -y
mamba install -c bioconda samtools=1.11 -y
pip install medaka
