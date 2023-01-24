# 20230130_tutorialの内容
**BRIG(BLAST Ring Image Generator)で複数の細菌ゲノムの比較**  

## BRIG
複数のfasta,fna,gbkファイル形式の最近ゲノムやプラスミドを読み込み、参照配列と比較を行う  
[参考サイト](https://brig.sourceforge.net/)    
[参考githubサイト](https://github.com/happykhan/BRIG)  


## 下準備
javaやBLASTの設定を事前に行う必要あり

**javaのインストール(Mac)**  
(サイト: https://www.oracle.com/jp/java/technologies/downloads/#jdk19-mac)  
M1,M2チップ用のインストーラのダウンロードしインストール  
```
wget -c https://download.oracle.com/java/19/latest/jdk%2D19_macos%2Daarch64_bin.dmg
```
Intel CPU用のインストーラのダウンロードしインストール   
```
wget -c https://download.oracle.com/java/19/latest/jdk-19_macos-x64_bin.dmg
```

**BLASTのインストール(Mac)**  
(サイト: ftp://ftp.ncbi.nlm.nih.gov/blast/executables/blast+/LATEST/)   
Mac(M1,M2,Intel)用のインストーラのダウンロード  
```
wget -c ftp://ftp.ncbi.nlm.nih.gov/blast/executables/blast+/LATEST//ncbi-blast-2.13.0+.dmg
```

## BRIGの実行ファイルのダウンロード
下記のサイトにアクセスすると必要なファイルが自動的にダウンロードされる
https://sourceforge.net/projects/brig/files/latest/download
ダウンロードしたファイルをデスクトップに移動し、解凍する

## BRIG.jarの実行  
-Xmx以下の数値は割り当てるメモリの大きさ
```
java -Xmx4000M -jar BRIG.jar
```
