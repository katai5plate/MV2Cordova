/*:
 * @plugindesc Cordova+AndroidアプリでAdMob広告を表示する為のプラグイン
 * @author Had2Apps
 *
 * @help 
 * プラグインコマンド：
 * 「H2A_AdMob Inter」でインタースティシャル広告呼び出し
 * ライセンス：
 * MIT
 * 
 *
 * @param bunnerID
 * @desc バナー広告のID
 * @default xx-xxx-xxx-xxxxxxxxxxxxxxxx/xxxxxxxxxx
 * 
 * @param interID
 * @desc インタースティシャル広告のID
 * @default xx-xxx-xxx-xxxxxxxxxxxxxxxx/xxxxxxxxxx
 * 
 * @param isTesting
 * @desc テストかどうか
 * 0 - false     1 - true
 * @default 1
 * 
 * @param overlap
 * @desc バナーを被せて表示するか
 * 0 - false     1 - true
 * @default 0
 * 
 * @param offsetTopBar
 * @desc バナーのトップバーをオフセットするか
 * 0 - false     1 - true
 * @default 0
 * 
 * @param position
 * @desc バナーの位置
 * 0 - 下     1 - 上
 * @default 0
 * 
 * @param bgColor
 * @desc バナーの余白の色
 * @default black
 *
 */

var H2A_AdMob = {};
H2A_AdMob.Param = PluginManager.parameters('H2A_AdMob_Android');
H2A_AdMob.bunnerID = H2A_AdMob.Param["bunnerID"];
H2A_AdMob.interID = H2A_AdMob.Param["interID"];
H2A_AdMob.isTesting = H2A_AdMob.Param["isTesting"]=="0" ? false : true;
H2A_AdMob.overlap = H2A_AdMob.Param["overlap"]=="0" ? false : true;
H2A_AdMob.offsetTopBar = H2A_AdMob.Param["offsetTopBar"]=="0" ? false : true;
H2A_AdMob.position = H2A_AdMob.Param["position"]=="0" ? false : true;
H2A_AdMob.bgColor = H2A_AdMob.Param["bgColor"];
H2A_AdMob.test = {
	adInitIsCalled: false,
	adInitIsPassed: false,
	adInitIsFinish: false,
};

(function() {
	var _Game_Interpreter_pluginCommand = Game_Interpreter.prototype.pluginCommand;
    Game_Interpreter.prototype.pluginCommand = function (command, args) {
        _Game_Interpreter_pluginCommand.call(this, command, args);
        if (command === 'H2A_AdMob') {
            switch (args[0]) {
                case 'Inter':
                    H2A_AdMob.showInter();
                    break;
            }
        }
    };

	var _Scene_Boot_start = Scene_Boot.prototype.start;
    Scene_Boot.prototype.start = function() {
		_Scene_Boot_start.call(this);
       H2A_AdMob.adInit();
    };

	// 起動時実行
	H2A_AdMob.adInit = function()
	{
		H2A_AdMob.test.adInitIsCalled = true;

		if(/(android)/i.test(navigator.userAgent)){
			H2A_AdMob.enable = true;
		};
		
		if(!H2A_AdMob.enable || !AdMob) return;
		H2A_AdMob.test.adInitIsPassed = true;

		AdMob.createBanner({
			adId: H2A_AdMob.bunnerID, 
			isTesting: H2A_AdMob.isTesting,
			overlap: H2A_AdMob.overlap,
			offsetTopBar: H2A_AdMob.offsetTopBar,
			position: !H2A_AdMob.position ? AdMob.AD_POSITION.BOTTOM_CENTER : AdMob.AD_POSITION.TOP_CENTER,
			bgColor: H2A_AdMob.bgColor,
			autoShow: true
		});

		H2A_AdMob.test.adInitIsFinish = true;
	}

	H2A_AdMob.showInter = function()
	{
		if(!H2A_AdMob.enable || !AdMob) return;
		AdMob.prepareInterstitial({
			adId: H2A_AdMob.interID,
			autoShow: true
		});
		AdMob.isInterstitialReady(function(isready){
			if(isready) AdMob.showInterstitial();
		});
	}
})();