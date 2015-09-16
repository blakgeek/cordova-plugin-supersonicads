#import <Foundation/Foundation.h>
#import <Cordova/CDV.h>
#import <Supersonic/Supersonic.h>

@interface SupersonicAdsPlugin : CDVPlugin <SupersonicRVDelegate, SupersonicISDelegate, SupersonicOWDelegate>

- (void)init:(CDVInvokedUrlCommand *)command;

- (void)showRewardedAd:(CDVInvokedUrlCommand *)command;

- (void)showInterstitial:(CDVInvokedUrlCommand *)command;

- (void)showOfferwall:(CDVInvokedUrlCommand *)command;
    
@end