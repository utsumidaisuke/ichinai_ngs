# nanopore_pipelineの内容
minionから出力されたfast5ファイルをもとにした解析パイプラインの実行  

## 解析のフロー
1. guppyでベースコールし、fast5からfastqファイルへの変換
2. NanoPlotでクオリティーチェック
3. filtlongでトリミング
4. fastqファイルの統合および、重複の修正
5. flyeでassembly
6. medakaでpolishing
7. kleborateで菌種のアノテーション
8. RAST-tkで遺伝子領域のアノテーション

## 各種ツールの下準備と関連情報
### guppy (GPUの設定が必要)   
[サイト](https://community.nanoporetech.com/downloads): 環境にあったインストーラーをダウンロード  
