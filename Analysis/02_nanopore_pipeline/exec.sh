# 出力ファイル保存用のディレクトリを作成
if [ -d output ]; then
    :
else
    mkdir output
fi
# guppyでベースコールしfast5をfastqに変換
guppy_basecaller --flowcell FLO-MIN106 --kit SQK-RBK004 -x cuda:0 -i data -s output/guppy -r

# NanoPlotででクオリティーチェック
NanoPlot --summary output/guppy/sequencing_summary.txt --loglength -o output/nano_summary

# filtlongの出力ファイルの保存ディレクトリの作成
if [ -d output/filtered ]; then
    :
else
    mkdir output/filtered
fi
# filtlongでトリミング
for i in $(ls output/guppy/pass/*.fastq | sed -e 's/\.fastq//g' | sed -e 's/output\/guppy\/pass\///g')
do
filtlong --min_length 1000 --keep_percent 90 output/guppy/pass/$i\.fastq | gzip -> output/filtered/$i\.filtered.fastq.gz
done

# fastq.gzを統合し、idの重複を修正
cat output/filtered/*gz > output/filtered/combined.fastq.gz
seqkit rename output/filtered/combined.fastq.gz > output/filtered/combined.renamed.fastq


# flyeの出力ファイルの保存用ディレクトリの作成
if [ -d output/flye_assembly ]; then
    :
else
    mkdir output/flye_assembly
fi
# flyeでassembly
flye --nano-raw output/filtered/combined.renamed.fastq --out-dir output/flye_assembly --threads 50 --scaffold

# medakaの出力ファイルの保存用ディレクトリの作成
if [ -d output/medaka ]; then
    rm -rf output/medaka
    mkdir output/medaka
else
    mkdir output/medaka
fi

# medakaでpolishing
# assembly/00-assemblyを入力ファイルとして選択するとエラーが生ずる
medaka_consensus -i output/filtered/combined.renamed.fastq -d output/flye_assembly/assembly.fasta -o output/medaka -t 20

# kleborateの出力ファイルの保存用ディレクトリの作成
if [ -d output/kleborate ]; then
    :
else
    mkdir output/kleborate
fi

# Kleborateでアノテーション
kleborate -a output/medaka/consensus.fasta --all -o output/kleborate/kleborate_result.txt

# RAST-tkの出力ファイルの保存用ディレクトリの作成
if [ -d output/RASTtk ]; then
    :
else
    mkdir output/RASTtk
fi

# RAST-tkでアノテーション
rast-create-genome --scientific-name "Klebsiella pneumoniae" --genetic-code 11 --domain Bacteria --contigs output/medaka/consensus.fasta > output/RASTtk/K_pneumoniae.gto
rast-process-genome -i output/RASTtk/K_pneumoniae.gto -o output/RASTtk/K_pneumoniae.gto2
rast-export-genome genbank -i output/RASTtk/K_pneumoniae.gto2 -o output/RASTtk/K_pneumoniae.gbk
