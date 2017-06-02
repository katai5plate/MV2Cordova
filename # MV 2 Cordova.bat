@echo off
set C_ROOT=%CD%

rem ===== �o�b�`�ݒ� ============================================

rem +++ Android SDK�̃f�B���N�g�� +++
set A_DIR=C:\Program Files\Android-sdk

rem +++ Android SDK�̃o�[�W���� +++
set A_VER=22.0.1

rem +++ Zipalign�̏ꏊ +++
set A_ZIP=%A_DIR%\build-tools\%A_VER%\zipalign.exe

rem +++ ���k��APK�̕ۑ��ꏊ +++
set Z_APK=#apk

rem +++ ��ƃf�B���N�g������APK�̏o�͏ꏊ +++
set S_APK=platforms\android\build\outputs\apk

rem +++ keystore�̕ۑ��ꏊ +++
set K_SAVE=#keystore

rem +++ keystore�����t�@�C���̏ꏊ +++
set K_MEMO=%C_ROOT%\keystore_memo.txt



rem ===== ���C�� ============================================

echo.
echo ������ MV 2 Cordova ������ v1.0.1 by Had2Apps
echo.

echo �� �f�B���N�g��������͂��Ă�������
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
echo ���[�g          �F%C_ROOT%
echo ���            �F%C_DIRECT%
echo Android SDK�ꏊ �F%A_DIR%
echo Android SDK��Ver�F%A_VER%
echo ���k�c�[���̏ꏊ�F%A_ZIP%
echo keystore�ۑ��ꏊ�F%K_SAVE%
echo ���kAPK�ۑ��ꏊ �F%Z_APK%
echo keystore�����ꏊ�F%K_MEMO%
echo APK�̕ۊǏꏊ   �F%C_APK%
:msel2
echo.
echo �� ���[�h��I�����Ă�������
echo new : �V�K�v���W�F�N�g
echo gmr : �Q�[���̍X�V
echo ref : �v���W�F�N�g�̍X�V�̂�
echo tes : ���@�e�X�g�v���C�i�K�{�FAndroid��USB�f�o�b�O�ڑ��j
echo key : �V�K�L�[�X�g�A
echo dep : �ؖ��t�� APK �̃r���h
echo plg : �v���O�C���̊m�F
echo apd : APK�̕ۊǏꏊ���J���i�����ꍇ�͊J���܂���j
echo ksd : �L�[�X�g�A�̕ۊǏꏊ���J���i�����ꍇ�͊J���܂���j
echo con : �R���\�[�����J��
echo end : �I��
echo.
echo �� HINT�F�V�K�̏ꍇ�̎菇�@new �� (tes) �� key �� dep
echo �� HINT�F�X�V�̏ꍇ�̎菇�@gmr �� (tes) �� dep
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
echo �� ����������͂��Ă�������

set /p C_IDENT=  "���ʎq(xx.xxxx.xx): "
set /p C_APPNAME="�A�v����          : "
set C_DEVICE=android

rem ----- 1 -----

echo.
echo �� ���O �� cordova create ��
call cordova create %C_DIRECT% %C_IDENT% %C_APPNAME% -d
echo.

rem ----- 2 -----

cd %C_DIRECT%

echo.
echo �� ���O �� cordova platform add %C_DEVICE% ��
call cordova platform add %C_DEVICE%
echo.

rem ----- 3 -----

explorer config.xml

echo.
echo -----------------------------------------------------------
echo �� �ȉ��̕ύX�������Ă��������B

echo.
type %C_ROOT%\03_info.txt
echo.
echo.

:wait3
set C_YES=err
echo.
echo �� �I������Ȃ�uyes�v�Ɠ��͂��Ă�������
set /p C_YES= "INPUT : "
IF NOT %C_YES%==yes goto wait3

rem ----- 5 -----
:gmr
cd %C_DIRECT%

explorer "www"

echo.
echo -----------------------------------------------------------
echo �� www ��MV�ɂ���ăf�v���C�����g���ꂽ www �Ə㏑�����Ă��������B

:wait5
set C_YES=err
echo.
echo �� �I������Ȃ�uyes�v�Ɠ��͂��Ă�������
set /p C_YES= "INPUT : "
IF NOT %C_YES%==yes goto wait5

rem ----- 6 -----

echo.
echo -----------------------------------------------------------
echo �� www �t�H���_�ɂ��� index.html �Ɉȉ��̕ύX�������Ă�������

echo.
type %C_ROOT%\06_info.txt
echo.
echo.

:wait6
set C_YES=err
echo.
echo �� �I������Ȃ�uyes�v�Ɠ��͂��Ă�������
echo yes : ���s
echo www : www�t�H���_���J��
echo txt : index.html���J���i�����F�e�L�X�g�G�f�B�^�Ƃ̊֘A�t���j
set /p C_YES= "INPUT : "
IF %C_YES%==www explorer "www"
IF %C_YES%==txt explorer "www\index.html"
IF NOT %C_YES%==yes goto wait6

rem ----- admob -----

set C_YES=err
echo.
echo �� AdMob��K�p���܂����H
echo yes     : �K�p����
echo yes�ȊO : �K�p���Ȃ�
set /p C_YES= "INPUT : "
IF NOT %C_YES%==yes goto step7

echo.
echo �� ���O �� call cordova plugin add cordova-plugin-admobpro ��
call cordova plugin add cordova-plugin-admobpro
echo.

echo.
echo -----------------------------------------------------------
echo �� js �̒��� admob.js �����A�ݒ�����������Ă�������

explorer "www\js"

:ad1
set C_YES=err
echo.
echo �� �I������Ȃ�uyes�v�Ɠ��͂��Ă�������
set /p C_YES= "INPUT : "
IF NOT %C_YES%==yes goto ad1

rem ----- 7 -----
:step7

echo.
echo �� ���O �� cordova prepare ��
call cordova prepare
echo.

goto finish


rem ===== �X�V ============================================
:ref

cd %C_DIRECT%

echo.
echo �� ���O �� cordova prepare ��
call cordova prepare
echo.

goto finish


rem ===== �e�X�g�v���C ============================================
:tes

cd %C_DIRECT%

echo.
echo �� ���O �� cordova run android  -d ��
call cordova run android  -d
echo.

goto finish


rem ===== �V�K�L�[�X�g�A ============================================
:key

cd %K_SAVE%

echo �� ������͂��Ă�������

set /p K_FNAME="�o�̓t�@�C����         : "
set /p K_ALIAS="�G�C���A�X��           : "
echo �� HINT�F100�N��36500���ł��B
set /p K_VALID="�L������(10000�ȏ㐄��): "

echo.
echo �� �L�[�c�[�����J���܂�
echo �� HINT�F�g�D�P�ʖ��L����jpersonal, android...
echo �� HINT�F���{�̍��R�[�h��81�ł��B
echo �� HINT�F����
type %K_MEMO%
echo.

echo.
echo �� ���O �� keytool -genkey -v -keystore %K_FNAME%.keystore -alias %K_ALIAS% -validity %K_VALID% -keyalg RSA -keysize 2048 ��
call keytool -genkey -v -keystore %K_FNAME%.keystore -alias %K_ALIAS% -validity %K_VALID% -keyalg RSA -keysize 2048
echo.

goto finish


rem ===== �ؖ��t��APK�r���h ============================================
:dep

rem ----- 9 -----

cd %C_DIRECT%

echo.
echo �� ���O �� cordova build android --release ��
call cordova build android --release
echo.

rem ----- 12 -----

cd %C_APK%

echo �� ������͂��Ă�������

set /p K_FNAME="keystore�t�@�C����     : "
set /p Z_FNAME="�o��APK�t�@�C����      : "
set /p K_ALIAS="�G�C���A�X��           : "

cd %C_APK%

echo.
echo �� ���O �� call jarsigner -verbose -sigalg SHA1withRSA -digestalg SHA1 -keystore %K_SAVE%\%K_FNAME%.keystore android-release-unsigned.apk %K_ALIAS% ��
call jarsigner -verbose -sigalg SHA1withRSA -digestalg SHA1 -keystore %K_SAVE%\%K_FNAME%.keystore android-release-unsigned.apk %K_ALIAS%
echo.

rem ----- 13 -----

echo.
echo �� ���k�c�[�����J���܂�
echo.

echo.
echo �� ���O �� "%A_ZIP%" -v 4 android-release-unsigned.apk %Z_APK%\%Z_FNAME%.apk ��
call "%A_ZIP%" -v 4 android-release-unsigned.apk %Z_APK%\%Z_FNAME%.apk
echo.

explorer %Z_APK%

goto finish


rem ===== APK�ۊǏꏊ ============================================
:apd

if exist %Z_APK% explorer %Z_APK%

goto finish


rem ===== �L�[�X�g�A�ۊǏꏊ ============================================
:ksd

if exist %K_SAVE% explorer %K_SAVE%

goto finish


rem ===== �v���O�C���m�F ============================================
:plg

cd %C_DIRECT%

echo.
echo �� ���O �� call cordova plugin ls ��
call call cordova plugin ls
echo.

goto finish


rem ===== �R���\�[�� ============================================
:con

start cd %C_DIRECT%

goto finish


rem ===== ���� ============================================
:finish
echo.
echo �� �������I�����܂����B
echo �� ���O�ɃG���[������ꍇ�A�Ώ����邩��蒼���Ă�������
echo.
goto msel

rem ===== �I�� ============================================
:endbat