# fastANIで２つのゲノムを比較

### fastANIでゲノム比較
De novo assemblyで決定したassembly.fastaと肺炎球菌参照ゲノムのsp.ref.fnaをfastANIで比較

### fastANIコマンド
```
./fastANI -r sp.ref.fna -q assembly.fasta --visualize -o result/comp_result
```
