import sys

arg = sys.argv

with open('supple_file2.txt') as f:
    a = [i.split('\t')[1].strip() for i in f.readlines()]

with open(arg[1]) as f:
    t = f.readline()

for i,j in zip(range(len(a)), a):
    t = t.replace(f'Sample{str(i+1)}:',f'{j}:')

filename = 'converted_phy.txt'

with open(filename, 'w') as f:
    f.write(t)
