# phameの内容
**assemblyされたcontigファイルをもとに系統樹作成のためのfasttreeファイルを作成する**  

## phame
**系統樹作成支援ツール**   
[github](https://github.com/LANL-Bioinformatics/PhaME)  
[参考サイト](https://phame.readthedocs.io/en/latest/)  
下記の種類の複数のファイルから系統樹の作成に必要なデータを生成する  
1. 完全なゲノム配列  
2. contig配列  
3. 生データのfastqファイル 

1,2,3のそれぞれでも、組わせでもデータの生成は可能   
ここでは1,2からのデータ生成の説明をする  

## phameのインストール
**注意点**：  
condaでのインストールは依存関係の解消が困難  
dockerを利用するのが簡単  
dockerのインストール方法  
[参考サイト](https://kinsta.com/jp/blog/install-docker-ubuntu/)  

### dockerの準備  
dockerイメージの取得  
```
docker pull quay.io/biocontainers/phame:1.0.3--0
```  
dockerイメージのIDの確認
```
docker images
```
下記の表示がされるのでphameのIMAGAE IDを確認  
```
REPOSITORY                    TAG        IMAGE ID       CREATED       SIZE
quay.io/biocontainers/phame   1.0.3--0   e53ed3952a43   4 years ago   1.45GB
```

## phame実行の下準備
phame実行には下記のファイルの準備が必要  
拡張子を正確に記載しないとエラーが起きる  
1. referenceとなる完全長のゲノム配列  
NCBIのデータベースなどからfastaファイル形式で準備(拡張子:fasta)  
referenceファイルはrefdirディレクトリに保存
2. 比較するassemblyずみのcontig  
複数のコンティグを一つにまとめたファイル(拡張子:contig)  
contigファイルはworkdirに保存
3. phameの環境設定ファイルのXXX.ctlファイル（拡張子:ctl）  
ctlファイルの記載方法の詳細は下記のサイトを参照  
[参照サイト](https://phame.readthedocs.io/en/latest/usage/cases.html#with-complete-genomes-and-contigs)

## phameの実行  
**コンテナの起動**  
phameのイメージからコンテナを生成し、実行（現在のディレクトリをコンテナの/homeにマウント）  
コマンドの"e53ed3952a43"部分は、上記のIMAGE IDに対応
```
docker run -v $(pwd):/home --rm -it e53ed3952a43  /bin/bash
```

**phameの実行**
```
cd /home
phame Kp.ctl
```
