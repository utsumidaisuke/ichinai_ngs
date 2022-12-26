# 20221226_tutorial

### Clustaloで複数のアミノ酸配列をアライメントする

**アライメントツール**
- [clustalo](https://www.ebi.ac.uk/Tools/msa/clustalo/)
- 参考サイト
  - [macでインフォマティクス](https://kazumaxneo.hatenablog.com/entry/2020/07/30/073000)
  - [bioinformatics](https://bi.biopapyrus.jp/seq/alignment/software/clustal-omega.html)

**下準備**  
- clustaloのサイトのサンプルデータを流用  
- サンプルデータ： sample.fna  

**実行コマンド**  
- sample.fnaのアライメントを標準出力する
```
clustalo -t Protein -i sample.fna --outfmt=clu
```
- sample.fnaのアライメントをresult.txtに出力する
```
clustalo -t Protein -i sample.fna --outfmt=clu -o result.txt
```
