# fastANI_tutorialの内容
**De novo assemblyで得たゲノム配列と肺炎球菌参照ゲノムの比較**  

## fastANI
[github](https://github.com/ParBLiSS/FastANI)  
[参考サイト](https://kazumaxneo.hatenablog.com/entry/2018/09/14/141442)  

## 下準備
**fastANIの実行ファイルのダウンロード**  
```
wget -c https://github.com/ParBLiSS/FastANI/releases/download/v1.33/fastANI-Linux64-v1.33.zip
unzip fastANI-Linux64-v1.33.zip
```
**Rの準備** 
```
# Rを起動後下記のコマンドを実行
# 実行後ctrl+DでRを抜ける
install.packages("genoPlotR", repos="http://R-Forge.R-project.org")

```
**assembly済みファイル(02_unicycler_tutorialで作成)**  
```
assembly.fasta
```

## 肺炎球菌参照ゲノムの取得
[参考サイト](https://www.ncbi.nlm.nih.gov/genome/176)  
ダウンロードと解凍  
```
wget -c https://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/002/076/835/GCF_002076835.1_ASM207683v1/GCF_002076835.1_ASM207683v1_genomic.fna.gz
gunzip -c GCF_002076835.1_ASM207683v1_genomic.fna.gz > sp.ref.fna
```

## fastANIでゲノム比較を実行  
De novo assemblyで決定したassembly.fastaと肺炎球菌参照ゲノムのsp.ref.fnaをfastANIで比較

fastANIの実行コマンド: 結果の出力ファイルはresult/のディレクトリに保存される  
```
./fastANI -r sp.ref.fna -q assembly.fasta --visualize -o result/comp_result
```
## fastANIの出力ファイルを使い、比較結果を可視化

**visulaize.R**  
fastANIの出力ファイルcomp_result.visualをvisualize.Rのスクリプトで可視化する

**visualize.Rの入手サイト**  
[visualize.R](https://github.com/ParBLiSS/FastANI/blob/master/scripts/visualize.R)

**実行コマンド**  
```
Rscript visualize.R assembly.fasta sp.ref.fna result/comp_result.visual
```
結果ファイルはcomp_result.visual.pdfとして出力される
