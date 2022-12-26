# 20221226_tutorial

### De novo assemblyで得たゲノム配列と肺炎球菌参照ゲノムの比較
**肺炎球菌参照ゲノム**
- [参考サイト](https://www.ncbi.nlm.nih.gov/genome/176)
- ダウンロード方法
```
wget -c https://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/002/076/835/GCF_002076835.1_ASM207683v1/GCF_002076835.1_ASM207683v1_genomic.fna.gz
gunzip -c GCF_002076835.1_ASM207683v1_genomic.fna.gz > data/sp.ref.fna
```

**ゲノム比較ツール**
- [fastANI](https://github.com/ParBLiSS/FastANI)
- [参考サイト](https://kazumaxneo.hatenablog.com/entry/2018/09/14/141442)

**下準備**
- fastANIの実行ファイルのダウンロード (dataディレクトリに保存済み)
```
wget -c https://github.com/ParBLiSS/FastANI/releases/download/v1.33/fastANI-Linux64-v1.33.zip
unzip fastANI-Linux64-v1.33.zip
cp fastANI data/
```
- Rの準備
```
# Rを起動後下記のコマンドを実行
# 実行後ctrl+DでRを抜ける
install.packages("genoPlotR", repos="http://R-Forge.R-project.org")

```
- assembly済みファイル
```
data/assembly.fasta
```
(20221219_tutorialで作成)

**fastANIでゲノム比較**  
- De novo assemblyで決定したassembly.fastaと肺炎球菌参照ゲノムのsp.ref.fnaをfastANIで比較

**fastANIの実行コマンド**  
- 結果の出力ファイルはresult/のディレクトリに保存される
```
./fastANI -r sp.ref.fna -q assembly.fasta --visualize -o result/comp_result
```
