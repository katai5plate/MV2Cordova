@echo off
set C_ROOT=%CD%

rem ===== バッチ設定 ============================================

rem +++ Android SDKのディレクトリ +++
set A_DIR=C:\Program Files\Android-sdk

rem +++ Android SDKのバージョン +++
set A_VER=22.0.1

rem +++ Zipalignの場所 +++
set A_ZIP=%A_DIR%\build-tools\%A_VER%\zipalign.exe

rem +++ 圧縮済APKの保存場所 +++
set Z_APK=#apk

rem +++ 作業ディレクトリ内のAPKの出力場所 +++
set S_APK=platforms\android\build\outputs\apk

rem +++ keystoreの保存場所 +++
set K_SAVE=#keystore

rem +++ keystoreメモファイルの場所 +++
set K_MEMO=%C_ROOT%\keystore_memo.txt



rem ===== メイン ============================================

echo.
echo ■■■ MV 2 Cordova ■■■ v1.0.1 by Had2Apps
echo.

echo ▼ ディレクトリ名を入力してください
set /p S_DIRECT= "INPUT : "
echo.

set C_DIRECT=%C_ROOT%\%S_DIRECT%
set C_APK=%C_DIRECT%\%S_APK%
set K_SAVE=%C_ROOT%\%K_SAVE%
set Z_APK=%C_ROOT%\%Z_APK%

if not exist %Z_APK% mkdir %Z_APK%
if not exist %K_SAVE% mkdir %K_SAVE%

:msel
cd %C_ROOT%
set C_YES=err
echo ルート          ：%C_ROOT%
echo 作業            ：%C_DIRECT%
echo Android SDK場所 ：%A_DIR%
echo Android SDKのVer：%A_VER%
echo 圧縮ツールの場所：%A_ZIP%
echo keystore保存場所：%K_SAVE%
echo 圧縮APK保存場所 ：%Z_APK%
echo keystoreメモ場所：%K_MEMO%
echo APKの保管場所   ：%C_APK%
:msel2
echo.
echo ▼ モードを選択してください
echo new : 新規プロジェクト
echo gmr : ゲームの更新
echo ref : プロジェクトの更新のみ
echo tes : 実機テストプレイ（必須：AndroidとUSBデバッグ接続）
echo key : 新規キーストア
echo dep : 証明付き APK のビルド
echo plg : プラグインの確認
echo apd : APKの保管場所を開く（無い場合は開きません）
echo ksd : キーストアの保管場所を開く（無い場合は開きません）
echo con : コンソールを開く
echo end : 終了
echo.
echo ★ HINT：新規の場合の手順　new → (tes) → key → dep
echo ★ HINT：更新の場合の手順　gmr → (tes) → dep
echo.
set /p C_YES= "INPUT : "
IF %C_YES%==new goto new
IF %C_YES%==gmr goto gmr
IF %C_YES%==ref goto ref
IF %C_YES%==tes goto tes
IF %C_YES%==key goto key	
IF %C_YES%==dep goto dep
IF %C_YES%==plg goto plg
IF %C_YES%==apd goto apd
IF %C_YES%==ksd goto ksd
IF %C_YES%==con goto con
IF %C_YES%==end goto endbat
goto msel2

:new
echo.
echo ▼ 初期情報を入力してください

set /p C_IDENT=  "識別子(xx.xxxx.xx): "
set /p C_APPNAME="アプリ名          : "
set C_DEVICE=android

rem ----- 1 -----

echo.
echo ◇ ログ → cordova create ◇
call cordova create %C_DIRECT% %C_IDENT% %C_APPNAME% -d
echo.

rem ----- 2 -----

cd %C_DIRECT%

echo.
echo ◇ ログ → cordova platform add %C_DEVICE% ◇
call cordova platform add %C_DEVICE%
echo.

rem ----- 3 -----

explorer config.xml

echo.
echo -----------------------------------------------------------
echo ■ 以下の変更を加えてください。

echo.
type %C_ROOT%\03_info.txt
echo.
echo.

:wait3
set C_YES=err
echo.
echo ▼ 終わったなら「yes」と入力してください
set /p C_YES= "INPUT : "
IF NOT %C_YES%==yes goto wait3

rem ----- 5 -----
:gmr
cd %C_DIRECT%

explorer "www"

echo.
echo -----------------------------------------------------------
echo ■ www をMVによってデプロイメントされた www と上書きしてください。

:wait5
set C_YES=err
echo.
echo ▼ 終わったなら「yes」と入力してください
set /p C_YES= "INPUT : "
IF NOT %C_YES%==yes goto wait5

rem ----- 6 -----

echo.
echo -----------------------------------------------------------
echo ■ www フォルダにある index.html に以下の変更を加えてください

echo.
type %C_ROOT%\06_info.txt
echo.
echo.

:wait6
set C_YES=err
echo.
echo ▼ 終わったなら「yes」と入力してください
echo yes : 続行
echo www : wwwフォルダを開く
echo txt : index.htmlを開く（推奨：テキストエディタとの関連付け）
set /p C_YES= "INPUT : "
IF %C_YES%==www explorer "www"
IF %C_YES%==txt explorer "www\index.html"
IF NOT %C_YES%==yes goto wait6

rem ----- admob -----

set C_YES=err
echo.
echo ▼ AdMobを適用しますか？
echo yes     : 適用する
echo yes以外 : 適用しない
set /p C_YES= "INPUT : "
IF NOT %C_YES%==yes goto step7

echo.
echo ◇ ログ → call cordova plugin add cordova-plugin-admobpro ◇
call cordova plugin add cordova-plugin-admobpro
echo.

echo.
echo -----------------------------------------------------------
echo ■ js の中に admob.js を入れ、設定を書き換えてください

explorer "www\js"

:ad1
set C_YES=err
echo.
echo ▼ 終わったなら「yes」と入力してください
set /p C_YES= "INPUT : "
IF NOT %C_YES%==yes goto ad1

rem ----- 7 -----
:step7

echo.
echo ◇ ログ → cordova prepare ◇
call cordova prepare
echo.

goto finish


rem ===== 更新 ============================================
:ref

cd %C_DIRECT%

echo.
echo ◇ ログ → cordova prepare ◇
call cordova prepare
echo.

goto finish


rem ===== テストプレイ ============================================
:tes

cd %C_DIRECT%

echo.
echo ◇ ログ → cordova run android  -d ◇
call cordova run android  -d
echo.

goto finish


rem ===== 新規キーストア ============================================
:key

cd %K_SAVE%

echo ▼ 情報を入力してください

set /p K_FNAME="出力ファイル名         : "
set /p K_ALIAS="エイリアス名           : "
echo ★ HINT：100年で36500日です。
set /p K_VALID="有効日数(10000以上推奨): "

echo.
echo ● キーツールを開きます
echo ★ HINT：組織単位名記入例）personal, android...
echo ★ HINT：日本の国コードは81です。
echo ★ HINT：メモ
type %K_MEMO%
echo.

echo.
echo ◇ ログ → keytool -genkey -v -keystore %K_FNAME%.keystore -alias %K_ALIAS% -validity %K_VALID% -keyalg RSA -keysize 2048 ◇
call keytool -genkey -v -keystore %K_FNAME%.keystore -alias %K_ALIAS% -validity %K_VALID% -keyalg RSA -keysize 2048
echo.

goto finish


rem ===== 証明付きAPKビルド ============================================
:dep

rem ----- 9 -----

cd %C_DIRECT%

echo.
echo ◇ ログ → cordova build android --release ◇
call cordova build android --release
echo.

rem ----- 12 -----

cd %C_APK%

echo ▼ 情報を入力してください

set /p K_FNAME="keystoreファイル名     : "
set /p Z_FNAME="出力APKファイル名      : "
set /p K_ALIAS="エイリアス名           : "

cd %C_APK%

echo.
echo ◇ ログ → call jarsigner -verbose -sigalg SHA1withRSA -digestalg SHA1 -keystore %K_SAVE%\%K_FNAME%.keystore android-release-unsigned.apk %K_ALIAS% ◇
call jarsigner -verbose -sigalg SHA1withRSA -digestalg SHA1 -keystore %K_SAVE%\%K_FNAME%.keystore android-release-unsigned.apk %K_ALIAS%
echo.

rem ----- 13 -----

echo.
echo ● 圧縮ツールを開きます
echo.

echo.
echo ◇ ログ → "%A_ZIP%" -v 4 android-release-unsigned.apk %Z_APK%\%Z_FNAME%.apk ◇
call "%A_ZIP%" -v 4 android-release-unsigned.apk %Z_APK%\%Z_FNAME%.apk
echo.

explorer %Z_APK%

goto finish


rem ===== APK保管場所 ============================================
:apd

if exist %Z_APK% explorer %Z_APK%

goto finish


rem ===== キーストア保管場所 ============================================
:ksd

if exist %K_SAVE% explorer %K_SAVE%

goto finish


rem ===== プラグイン確認 ============================================
:plg

cd %C_DIRECT%

echo.
echo ◇ ログ → call cordova plugin ls ◇
call call cordova plugin ls
echo.

goto finish


rem ===== コンソール ============================================
:con

start cd %C_DIRECT%

goto finish


rem ===== 完了 ============================================
:finish
echo.
echo ● 処理が終了しました。
echo ※ ログにエラーがある場合、対処するかやり直してください
echo.
goto msel

rem ===== 終了 ============================================
:endbat