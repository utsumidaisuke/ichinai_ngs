# phameの内容
**assemblyされたcontigファイルをもとに系統樹作成のためのfasttreeファイルを作成する**  

## phame
系統樹作成支援ツール  
[github](https://github.com/LANL-Bioinformatics/PhaME)   
[参考サイト](https://phame.readthedocs.io/en/latest/)  

## phameのインストール
**注意点**：  
condaでのインストールは依存関係の解消が困難  
dockerを利用するのが簡単  

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
phameのイメージからコンテナを生成（現在のディレクトリをコンテナの/homeにマウント）  
```
docker run -v $(pwd):/home --rm -it e53ed3952a43  /bin/bash
```





## Kleborateの使用方法の概略

## 具体的な使用方法
**Klebsiella pneumoniaeのゲノムのタイピング**
```
kleborate -a contigs.fa --all -o contigs_result.txt
```
