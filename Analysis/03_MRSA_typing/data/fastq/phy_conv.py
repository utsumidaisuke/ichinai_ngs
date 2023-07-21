import sys

arg = sys.argv

with open('list.txt') as f:
    a = [i.strip() for i in f.readlines()]

with open(arg[1]) as f:
    t = f.readline()

for i,j in zip(range(len(a)), a):
    t = t.replace(f'Sample{str(i+1)}:',f'{j}:')

filename = arg[1].replace('_tree.txt','_tree_conv.txt')

with open(filename, 'w') as f:
    f.write(t)
