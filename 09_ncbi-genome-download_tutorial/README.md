# ncbi-genome-download_tutorialの内容
**ncbi-genome-downloadでNCBIのゲノム関連情報を取得**  

## ncbi_genome_download
NCBIのデータベースに保存されている各種生物のゲノム情報を取得する  
[github](https://github.com/kblin/ncbi-genome-download)   
[参考サイト1](https://kazumaxneo.hatenablog.com/entry/2018/12/08/073000)  
[参考サイト2](https://diy-bioinformatics.com/ncbi-genome-download_install_usage/)  

## インストール
```
mamba install -c bioconda ncbi-genome-download 
```

## 具体的な使用方法
**どのようなファイルがダウンロードされるかをdry-runする**
```
ncbi-genome-download --assembly-level complete --format fasta bacteria --dry-run
```

**RefSeqに登録されているすべてのバクテリアゲノムのダウンロード**
```
ncbi-genome-download --assembly-level complete --format fasta bacteria -p 20
```

**特定の属のrefseqのダウンロード**
```
ncbi-genome-download -g "Escherichia coli" bacteria
```

**ウイルスゲノムのrefseqのダウンロード**
```
ncbi-genome-download --assembly-level complete --format fasta viral -p 15
```

**真菌ゲノムのrefseqのダウンロード** (—assembly-levelがcompleteだと取得できるファイル数が少ない)
```
ncbi-genome-download --assembly-level all --format fasta fungi -p 15
```

**refseqのアクセッション番号を指定してダウンロード** (GCF_018847615.1: Akkermansia muciniphila(細菌))
```
ncbi-genome-download --assembly-accessions GCF_018847615.1 --format fasta bacteria
```

