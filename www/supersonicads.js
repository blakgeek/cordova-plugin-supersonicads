function SupersonicAds(appKey, userId, config) {

	config = config || {};

	cordova.exec(null, null, 'SupersonicAdsPlugin', 'init', [appKey, userId]);

	this.showRewardedAd = function(placementName, claimSpace, successCallback, failureCallback) {
		cordova.exec(successCallback, failureCallback, 'SupersonicAdsPlugin', 'showRewardedAd', [placementName]);
	};

	this.showInterstitial = function(placementName, successCallback, failureCallback) {
		cordova.exec(successCallback, failureCallback, 'SupersonicAdsPlugin', 'showInterstitial', [placementName]);
	};

	this.showOfferWall = function(placementName, successCallback, failureCallback) {
		cordova.exec(successCallback, failureCallback, 'SupersonicAdsPlugin', 'showOfferWall', [placementName]);
	};

}

if(typeof module !== undefined && module.exports) {

	module.exports = SupersonicAds;
}