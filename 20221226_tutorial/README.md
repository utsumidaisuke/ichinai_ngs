# 20221226_tutorialの内容
**Clustaloで複数のアミノ酸配列をアライメントする** 

## アライメントツール
[clustalo](https://www.ebi.ac.uk/Tools/msa/clustalo/)

## 参考サイト
[macでインフォマティクス](https://kazumaxneo.hatenablog.com/entry/2020/07/30/073000)  
[bioinformatics](https://bi.biopapyrus.jp/seq/alignment/software/clustal-omega.html)

## 下準備  
clustaloのサイトのサンプルデータを流用   
サンプルデータ： sample.fnaとして保存  

## 実行コマンド
sample.fnaのアライメントを標準出力する
```
clustalo -t Protein -i sample.fna --outfmt=clu --resno
```
sample.fnaのアライメントをresult.txtに出力する
```
clustalo -t Protein -i sample.fna --outfmt=clu -o alignment.txt --resno
```
sample.fnaのアライメントをalignment.txtに、一致率をidentity.txtに出力する
```
clustalo -t Protein -i sample.fna --outfmt=clu -o alignment.txt --percent-id --full --distmat-out identity.txt --resno
```

