# clustalo_tutorialの内容
**Clustaloで複数のアミノ酸配列をアライメントする** 

## clastalo
複数配列のアラインメント（MSA）を作成するためのパッケージ
  
[参考サイト](https://www.ebi.ac.uk/Tools/msa/clustalo/)
[macでインフォマティクス](https://kazumaxneo.hatenablog.com/entry/2020/07/30/073000)  
[bioinformatics](https://bi.biopapyrus.jp/seq/alignment/software/clustal-omega.html)

## 下準備  
clustaloのサイトのサンプルデータを流用   
サンプルデータ： sample.fnaとして保存  

## アミノ酸配列のアライメント
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

