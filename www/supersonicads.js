function SupersonicAds(appKey, userId) {

	cordova.exec(null, null, 'SupersonicAdsPlugin', 'init', [appKey, userId]);

	this.showRewardedAd = function(placementName, claimSpace, successCallback, failureCallback) {
		cordova.exec(successCallback, failureCallback, 'SupersonicAdsPlugin', 'showRewardedAd', [placementName]);
	};

	this.showInterstitial = function(successCallback, failureCallback) {
		cordova.exec(successCallback, failureCallback, 'SupersonicAdsPlugin', 'showInterstitial', []);
	};

	this.showOfferwall = function(successCallback, failureCallback) {
		cordova.exec(successCallback, failureCallback, 'SupersonicAdsPlugin', 'showOfferwall', []);
	};

}

if(typeof module !== undefined && module.exports) {

	module.exports = SupersonicAds;
}