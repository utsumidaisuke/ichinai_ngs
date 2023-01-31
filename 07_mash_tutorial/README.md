# mash_tutorialの内容
**mashでゲノム配列の近似距離を測定**  

## mash
ゲノム配列の突然変異割合をもとにサンプル間の近似距離を測定する  

[github](https://github.com/marbl/Mash)  
[マニュアル](https://mash.readthedocs.io/en/latest/)  
[参考サイト](https://kazumaxneo.hatenablog.com/entry/2018/05/11/180244)  

## mashのインストール
condaでインストールを行うと、実行の際にエラーが生じる  
実行ファイルを[github](https://github.com/marbl/Mash/releases)からダウンロードする  
**Mac: mash-OSX64-v2.3.tarのダウンロードと解凍**
```
wget -c https://github.com/marbl/Mash/releases/download/v2.3/mash-OSX64-v2.3.tar
tar -xvf mash-OSX64-v2.3.tar_
```
**Linux: mash-Linux64-v2.3.tarのダウンロード**
```
wget -c https://github.com/marbl/Mash/releases/download/v2.3/mash-Linux64-v2.3.tar
tar -xvf mash-Linux64-v2.3.tar
```

## サンプルファイルのダウンロード
```
wget -c https://github.com/marbl/Mash/blob/master/test/genome1.fna
wget -c https://github.com/marbl/Mash/blob/master/test/genome2.fna
wget -c https://github.com/marbl/Mash/blob/master/test/genome3.fna
```

### mashによる近似距離の計算
```
mash dist genome1.fna genome2.fna
```
