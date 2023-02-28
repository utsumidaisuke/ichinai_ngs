# Kleborate_tutorialの内容
**Klebsiella pneumoniaeのMLSTタイプ、種の決定、薬剤耐性遺伝子の同定を行う**  

## Kleborate
アセンブリされたKlebsiella pneumoniaeのタイピングツール    
[github](https://github.com/katholt/Kleborate)  
[参考サイト](https://docs.google.com/document/d/19iz_bLGBj2yE3xAOTp_VIlJu0jMlzlAJlPzyfLMDYGo/edit)

## Kleborateのインストール
Kleborateが依存する複数のパッケージを含む仮想環境を構築する  
[参考サイト](https://docs.google.com/document/d/19iz_bLGBj2yE3xAOTp_VIlJu0jMlzlAJlPzyfLMDYGo/edit#heading=h.3ricigmky4x5)  
```
mamba create -n klebsiella_analysis python=3.9 biopython blast mash gsl=2.5 -y
mamba activate klebsiella_analysis
```
githubから必要なデータを取得しインストール
```
git clone --recursive https://github.com/katholt/Kleborate.git
cd Kleborate/kaptive
git pull https://github.com/katholt/Kaptive master
cd ../
python3 setup.py install
kleborate -h
```
## Kleborateの使用方法の概略

## 具体的な使用方法
**Klebsiella pneumoniaeのゲノムのタイピング**
```
kleborate -a K_pneumoniae.contig --all -o K_pneumoniae_result.txt
```
