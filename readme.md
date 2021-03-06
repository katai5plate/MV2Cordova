# MV 2 Cordova
Version 1.1.0<br>

# これは何？
ツクールMVゲームをAndroid対応Cordovaアプリに「しやすくする」ツールです。<br>
一々コマンド入力したり、手順を覚えるのが超面倒くさいので作りました。<br>
あくまで自分用に作ったので、動作は保障しません。<br>

# 使う前の準備
## １．インスコしておくべきものを全部そろえておく
ツクールMV公式によって用意されている必要なものをすべてインスコしておく<br>
・Cordovaコマンドをコマンドプロンプトから入力できるようにしておく<br>
・keytoolコマンドをコマンドプロンプトから入力できるようにしておく<br>
・jarsignerコマンドをコマンドプロンプトから入力できるようにしておく<br>
・Android SDKとそれのアプリ制作や広告に必要なものをインスコしておく<br>
・Android SDK内にZipalignがある環境にしておく

## ２．バッチをメモ帳で開いて初期設定を書き換える
・Android SDKのディレクトリ<br>
・Android SDKのバージョン<br>
・Zipalignの場所<br>
を入力。<br>

## ３．必要に応じて自分が使いやすいようメモファイルを書き換える
・keystore_memo：キーストア設定をする時に出てくる説明文<br>
・03_info：config.xml を書き換える時に出てくる説明文<br>
・06_info：index.html を書き換える時に出てくる説明文<br>

## ４．XMLファイルとHTMLファイルをテキストエディタに関連付けする
XMLファイルとHTMLファイルが自動で開いたりするので、<br>
そこからすぐに編集して保存できるようにしておく。<br>


# モードの説明
## new
新規プロジェクトを生成します。<br>
・cordova create<br>
・cordova platform add<br>
・cordova plugin add cordova-plugin-admobpro<br>
・cordova prepare<br>

## gmr
プロジェクトのゲーム内容を更新します。<br>
・cordova plugin add cordova-plugin-admobpro<br>
・cordova prepare<br>

## ref
Cordovaプロジェクトを更新します。<br>
・cordova prepare<br>

## tes
PCにUSBデバッグ接続されたAndroid端末でテストプレイします。<br>
・cordova run android<br>

## rtes
Cordovaプロジェクトを更新後、PCにUSBデバッグ接続されたAndroid端末でテストプレイします。<br>
・cordova prepare<br>
・cordova run android<br>

## key
新規キーストアを生成します。<br>
・keytool<br>

## dep
Google Playにアップ可能なAPKを生成します。<br>
※正常な動作にはキーストアが必要です。<br>
・cordova build android<br>
・jarsigner<br>
・zipalign<br>

## plg
プロジェクトにインストールされているプラグインを一覧表示する。<br>
・cordova plugin ls<br>

## apd
キーストアが出力されるフォルダを開く。<br>

## ksd
Google Playにアップ可能なAPKが出力されるフォルダを開く。<br>

## www
プロジェクトの www フォルダを開く。<br>

## con
プロジェクトがカレントディレクトリに設定されたコマンドプロンプトを開く。<br>

## end
バッチを終了する。<br>


# 手順の概略
## 新規にアプリを作る場合
１．newモードで新規プロジェクトを生成<br>
２．必要ならtesモードでテストプレイ<br>
３．keyモードで新規キーストアを生成<br>
４．depモードでAPKを生成<br>
５．そのAPKをリリースする<br>

## アプリを更新する場合
１．gmrモードでプロジェクトを更新<br>
２．必要ならtesモードでテストプレイ<br>
３．depモードでAPKを生成<br>
４．そのAPKをリリースする<br>

## 上級者向けの手っ取り早いテストプレイ方法
１．更新が必要なファイルだけを上書き・変更<br>
２．rtesモードでテストプレイ<br>


# ツクールMVで作ったゲームをGooglePlayにリリースできるようにするまで
１．バッチを起動する<br>
## スタート画面
２．アプリのプロジェクト名を入力する<br>
## モード選択画面
３．「new」と入力する<br>
## newモード
４．識別子とアプリ名を入力する<br>
５．config.xml が開くので指示通りに編集・保存してから「yes」<br>
６．www フォルダが開く<br>
７．ツクールMVでゲームを「Android / iOS」デプロイメントする<br>
８．ツクールMVから出力された www フォルダの中身を、６で開いた www フォルダに上書きし「yes」<br>
９．「txt」を入力すると index.html が開くので指示通りに編集・保存してから「yes」<br>
10．AdMobを使うなら「yes」、使わないなら「yes以外の適当な文字列」を入力<br>
### AdMobを使う場合：
#### admob.js を使う場合：
　js フォルダが開き、<br>
　[この記事](http://presentcall.com/rpg%E3%83%84%E3%82%AF%E3%83%BC%E3%83%ABmv%E3%81%A7admob%E5%BA%83%E5%91%8A%E3%82%92%E8%A1%A8%E7%A4%BA/)の「制御スクリプトの作成」のコードを「admob.js」としてそこに保存。<br>
　「Android用広告ユニットID」と「MyAdmobWindow()」の中を書き換えて保存してから「yes」を入力<br>
#### H2A_AdMob_Android.js を使う場合：
　そのまま何もせず「yes」を入力。<br>
### AdMobを使わない場合：
　そのまま次へ進む。<br>
## モード選択画面
11．「key」を入力<br>
## keyモード
12．キーストアの出力ファイル名とエイリアス名と有効日数を入力<br>
13．指示通りに情報を入力していき、確認が出てきたら「y」で確定する<br>
## モード選択画面
14．「dep」を入力<br>
## depモード
15．12で設定したキーストアのファイル名・エイリアスとAPKの出力ファイル名を入力<br>
16．うまくいけば開いたフォルダの中にAPKが生成されている<br>
## モード選択画面
17．「end」を入力すると閉じる<br>
## Google Play側での作業
18．このAPKをGooglePlayDeveloperでリリース処理をする<br>
19．リリース完了！<br>

# H2A_AdMob_Android.js について
admob.jsを導入する代わりにこのプラグインをツクールMV側で設定することで、<br>
バナー広告とインタースティシャル広告を設定することができます。<br>

# 注意
・環境によっては正常に動きません。動作保障しませんので自己責任でお取り扱いください。<br>
・depにより出力されたAPK置き場にすでに同じ名前のAPKがあると、上書きされないことがあります。<br>
・MITライセンスです。作者は「Had2Apps」です。<br>
