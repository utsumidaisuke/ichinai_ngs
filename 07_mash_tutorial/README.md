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
tar -xvf mash-OSX64-v2.3.tar
```
**Linux: mash-Linux64-v2.3.tarのダウンロード**
```
wget -c https://github.com/marbl/Mash/releases/download/v2.3/mash-Linux64-v2.3.tar
tar -xvf mash-Linux64-v2.3.tar
```

## 解凍したディレクトリに移動
```
# Linuxの場合
# cd mash-Linux64-v2.3
# Macの場合
cd mash-OSX64-v2.3
```

## サンプルファイルのダウンロード
```
wget https://gembox.cbcb.umd.edu/mash/genome1.fna
wget https://gembox.cbcb.umd.edu/mash/genome2.fna
```

### mashによる近似距離の計算
mashの実行
```
# mashの直前に"./"を入力する
./mash dist genome1.fna genome2.fna
```
  
下記の表示がされれば成功  
```
Sketching genome1.fna (provide sketch file made with "mash sketch" to skip)...done.
genome1.fna	genome2.fna	0.0222766	0	456/1000
```

