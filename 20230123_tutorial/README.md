# 20230116_tutorialの内容
Prokaryotic Genome Annotation Pipeline(PGAP)で細菌ゲノムのアノテーション

## PGAP
[参考サイト](https://www.ncbi.nlm.nih.gov/genome/annotation_prok/)
[参考githubサイト](https://github.com/ncbi/pgap)

必要ファイルのダウンロード方法
```
wget -c https://github.com/ncbi/pgap/blob/master/scripts/pgap.py
chmod +x pgap.py
```


## 下準備
- データベースのダウンロード
15GB程度のデータを取得する必要あり
```
pgap.py --update
```
- assembly済みファイル(20221219_tutorialで作成した最長のcontigを利用) 
```
assembly.fasta
```

- input.yamlの内容
```
fasta:
  class: File
  location: assembly.fasta
submol:
  class: File
  location: submol.yaml
```

- submol.yamlの内容
```
topology: "circular"
organism:
    genus_species: 'Streptococcus pneumoniae'
```

## assembly.fastaのアノテーション

```
pgap.py --ignore-all-errors -r -o result input.yaml
```
