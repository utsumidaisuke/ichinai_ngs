import pandas as pd
import numpy as np
import seaborn as sns
import matplotlib.pyplot as plt
import glob

# ２つのサンプルの異なる塩基配列の数をカウント
def comp(x,y):
    count = 0
    for i, j  in zip(dic[x], dic[y]):
        if i != j:
            count += 1
    return count

with open('results/snippy-core/core.full.noref.clean.final.aln', 'r') as f:
    t = f.readlines()
keys = []
values = []
seq = ""
for i in t:
    if i.startswith(">"):
        keys.append(i.strip().replace(">", ""))
        values.append(seq)
        seq = ""
    else:
        seq = seq+i.strip()
values.append(seq)

dic = {}
for k,v in zip(keys, values[1:]):
    dic[k] = v

# サンプルリストの取得
samples = [i.replace("results/","") for i in glob.glob('results/*') if not 'snippy-core' in i]

ls = list(dic.keys())
# データフレームの作成
n = len(samples)
df = pd.DataFrame(np.zeros(n*n).reshape(n,n)).applymap(int)
for i in range(n):
    for j in range(n):
        df.iloc[i,j] = comp(ls[i], ls[j])

# インデックスとカラム名の変更および並び替え
df.columns = list(dic.keys())
df.index = list(dic.keys())
df = df.loc[samples,samples]
sns.set()
sns.heatmap(df, annot=True, cmap='RdYlGn_r', fmt='.0f')
plt.savefig('results/snippy-core/heatmap.png')       
df.to_csv('results/snippy-core/heatmap_df.csv')
