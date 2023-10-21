# snippy-coreでコアゲノムを検出
snippy-core  --ref gbk/CP003166.gb --prefix results/snippy-core/core $(for i in $@; do echo "results/$i/$i " | tr -d '\n'; done)

# seqkitでアライメントデータから参照配列を除外
seqkit grep -i -v -p Reference results/snippy-core/core.full.aln > results/snippy-core/core.full.noref.aln

# snippy-clean_full_alnでアライメントデータのクリーニング
snippy-clean_full_aln results/snippy-core/core.full.noref.aln > results/snippy-core/core.full.noref.clean.aln

# run_gubbins.pyで組み換え領域を除外
run_gubbins.py --threads 16 --prefix results/snippy-core/gubbins/gubbins results/snippy-core/core.full.noref.clean.aln

# snp-sitesでSNPサイトを検出
snp-sites -c results/snippy-core/gubbins/gubbins.filtered_polymorphic_sites.fasta > results/snippy-core/core.full.noref.clean.final.aln

# FastTreeで系統樹の作成
FastTree -gtr -nt results/snippy-core/core.full.noref.clean.final.aln  > results/snippy-core/core.full.noref.clean.final.newick

# ヒートマップの作成
python heatmap.py
