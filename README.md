# Supersonic Ads Cordova Plugin
Add support for [Supersonic Ads](https://www.supersonic.com/) to your Cordova and Phonegap based mobile apps.

## How do I install it? ##

* If you're like me and using [CLI](http://cordova.apache.org/):
```
cordova plugin add https://github.com/blakgeek/cordova-plugin-supersonicads
```

or

```
phonegap local plugin add https://github.com/blakgeek/cordova-plugin-supersonicads
```
## How do I use it? ##

```javascript
document.addEventListener('deviceready', function() {

	var ssAds = new SupersonicAds("yo_app_key", "some_unique_userid");
	
	// show a rewarded ad
	ssAds.showRewardedAd();
    	
	// show a rewarded ad for placement RightHere
	ssAds.showRewardedAd("RightHere");
    
	// show an offerwall
    ssAds.showOfferWall();
    
    // show an interstitial
    ssAds.showInterstitial();
    
    // give em some credit
	window.addEventListener("offerwallCreditReceived", function(e) {
	    
	    var credit = e.credit;
	    
	    // The number of credits the user has earned.
	    console.log(credit.amount);
	    
	    // The total number of credits ever earned by the user.
	    console.log(credit.total):
	    
	    // estimated flag is the same as totalCreditsFlag 
	    // In some cases, we won’t be able to provide the exact
        // amount of credits since the last event (specifically if the user clears
        // the app’s data). In this case the ‘credits’ will be equal to the ‘totalCredits’,
        // and this flag will be ‘true’.
	    console.log(credit.estimated);
	    
	}, false);
	
	// reward your users
	window.addEventListener("rewardedVideoRewardedReceived", function(e) {
		
		var placement = e.placement;
		console.log(placement.id); // only available on android
		console.log(placement.name);
		console.log(placement.reward);
		console.log(placement.amount);
	}, false);
    
}, false);
```

## Can I just see a working example?
Yep.  Here you go https://github.com/blakgeek/cordova-plugin-supersonicads-demo

## What other events are supported?
###Interstitial
1. interstitialInitialized
1. interstitialInitializationFailed
1. interstitialAvailabilityChanged
1. interstitialShown
1. interstitialShowFailed
1. interstitialClicked
1. interstitialClosed

###Offerwall
1. offerwallClosed
1. offerwallCreditFailed
1. offerwallCreditReceived
1. offerwallShowFailed
1. offerwallOpened
1. offerwallInitializationFailed
1. offerwallInitialized

###Rewarded Video
1. rewardedVideoRewardReceived
1. rewardedVideoEnded
1. rewardedVideoStarted
1. rewardedVideoAvailabilityChanged
1. rewardedVideoClosed
1. rewardedVideoOpened
1. rewardedVideoInitializationFailed
1. rewardedVideoInitialized
1. rewardedVideoFailed