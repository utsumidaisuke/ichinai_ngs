# MRSAの参照配列を取得
mkdir ../gbk
efetch -db nuccore -id NC_007793 -format gbwithparts > ../gbk/NC_007793.gb
efetch -db nuccore -id NZ_CP007659 -format gbwithparts > ../gbk/NZ_CP007659.gb
efetch -db nuccore -id NZ_CP009361 -format gbwithparts > ../gbk/NZ_CP009361.gb
efetch -db nuccore -id CP003166 -format gbwithparts > ../gbk/CP003166.gb