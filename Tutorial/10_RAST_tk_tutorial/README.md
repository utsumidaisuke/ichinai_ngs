# RAST_tk_tutorialの内容
**バクテリアゲノムの配列情報をもとにアノテーションを行う**  

## RAST-tk
バクテリアゲノムアノテーションツール    
[参考サイト](https://www.bv-brc.org/docs//cli_tutorial/rasttk_getting_started.html)  

## BV-BRCのインストール
RAST-tkはBV-BRCパッケージに含まれている  
[参考サイト](https://www.bv-brc.org/docs//cli_tutorial/cli_installation.html)  
Linux:  
gdebi-coreのインストール(必要な依存関係を解決し、パッケージをインストール)  
```
sudo apt update
sudo apt-get install gdebi-core
```
BV-BRCのインストール  
```
sudo gdebi bvbrc-cli-1.040.deb

```
## RAST-tkの使用方法の概略
[参考サイト](https://www.bv-brc.org/docs//cli_tutorial/rasttk_getting_started.html)  
解析の流れは下記の通り
1. contigファイルのフォーマット  
2. ゲノムのアノテーテョン
3. 形式を指定し出力

## 具体的な使用方法
**Klebsiella pneumoniaeのゲノムをアノテーション**
1. contigファイルのフォーマット
```
rast-create-genome --scientific-name "Klebsiella pneumoniae" --genetic-code 11 --domain Bacteria --contigs K_pneumoniae.contig > K_pneumoniae.gto
```
2. ゲノムのアノテーテョン
```
rast-process-genome -i K_pneumoniae.gto -o K_pneumoniae.gto2
```
3. 形式を指定し出力
```
rast-export-genome genbank -i K_pneumoniae.gto2 -o K_pneumoniae.gbk
```
