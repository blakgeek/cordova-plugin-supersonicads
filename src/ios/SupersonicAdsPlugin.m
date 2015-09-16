#import "SupersonicAdsPlugin.h"

static NSString *const EVENT_INTERSTITIAL_INITIALIZED = @"interstitialInitialized";
static NSString *const EVENT_INTERSTITIAL_INIT_FAILED = @"interstitialInitializationFailed";
static NSString *const EVENT_INTERSTITIAL_AVAILABILITY_CHANGED = @"interstitialAvailabilityChanged";
static NSString *const EVENT_INTERSTITIAL_SHOWN = @"interstitialShown";
static NSString *const EVENT_INTERSTITIAL_SHOW_FAILED = @"interstitialShowFailed";
static NSString *const EVENT_INTERSTITIAL_CLICKED = @"interstitialClicked";
static NSString *const EVENT_INTERSTITIAL_CLOSED = @"interstitialClosed";

static NSString *const EVENT_OFFERWALL_CLOSED = @"offerwallClosed";
static NSString *const EVENT_OFFERWALL_CREDIT_FAILED = @"offerwallCreditFailed";
static NSString *const EVENT_OFFERWALL_CREDITED = @"offerwallCreditReceived";
static NSString *const EVENT_OFFERWALL_SHOW_FAILED = @"offerwallShowFailed";
static NSString *const EVENT_OFFERWALL_OPENED = @"offerwallOpened";
static NSString *const EVENT_OFFERWALL_INIT_FAILED = @"offerwallInitializationFailed";
static NSString *const EVENT_OFFERWALL_INITIALIZED = @"offerwallInitialized";

static NSString *const EVENT_REWARDED_VIDEO_FAILED = @"rewardedVideoFailed";
static NSString *const EVENT_REWARDED_VIDEO_REWARDED = @"rewardedVideoRewardReceived";
static NSString *const EVENT_REWARDED_VIDEO_ENDED = @"rewardedVideoEnded";
static NSString *const EVENT_REWARDED_VIDEO_STARTED = @"rewardedVideoStarted";
static NSString *const EVENT_REWARDED_VIDEO_AVAILABILITY_CHANGED = @"rewardedVideoAvailabilityChanged";
static NSString *const EVENT_REWARDED_VIDEO_CLOSED = @"rewardedVideoClosed";
static NSString *const EVENT_REWARDED_VIDEO_OPENED = @"rewardedVideoOpened";
static NSString *const EVENT_REWARDED_VIDEO_INIT_FAILED = @"rewardedVideoInitializationFailed";
static NSString *const EVENT_REWARDED_VIDEO_INITIALIZED = @"rewardedVideoInitialized";

@implementation SupersonicAdsPlugin


#pragma mark - CDVPlugin

- (void)pluginInitialize {

    [Supersonic sharedInstance];
}

- (void)init:(CDVInvokedUrlCommand *)command {

    NSString *appKey = [command argumentAtIndex:0];
    NSString *userId = [command argumentAtIndex:1];

    //
    // Initialize 'Rewarded Video'
    //
    [[Supersonic sharedInstance] setRVDelegate:self];
    [[Supersonic sharedInstance] initRVWithAppKey:appKey withUserId:userId];

    //
    // Initialize 'Interstitial'
    //
    [[Supersonic sharedInstance] setISDelegate:self];
    [[Supersonic sharedInstance] initISWithAppKey:appKey withUserId:userId];

    //
    // Initialize 'Offerwall'
    //
    [[Supersonic sharedInstance] setOWDelegate:self];
    [[Supersonic sharedInstance] initOWWithAppKey:appKey withUserId:userId];

    CDVPluginResult *result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
    [self.commandDelegate sendPluginResult:result callbackId:command.callbackId];
}

- (void)showRewardedAd:(CDVInvokedUrlCommand *)command {

    NSString *placementName = [command argumentAtIndex:0];

    if (placementName == nil) {
        [[Supersonic sharedInstance] showRV];
    } else {
        [[Supersonic sharedInstance] showRVWithPlacementName:placementName];
    }
    CDVPluginResult *result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
    [self.commandDelegate sendPluginResult:result callbackId:command.callbackId];
}

- (void)showInterstitial:(CDVInvokedUrlCommand *)command {

    [[Supersonic sharedInstance] showIS];
    CDVPluginResult *result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
    [self.commandDelegate sendPluginResult:result callbackId:command.callbackId];
}

- (void)showOfferwall:(CDVInvokedUrlCommand *)command {

    [[Supersonic sharedInstance] showOW];
    CDVPluginResult *result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
    [self.commandDelegate sendPluginResult:result callbackId:command.callbackId];
}

- (void) fireEvent: (NSString *) event {
    NSString *js = [NSString stringWithFormat:@"cordova.fireWindowEvent('%@')", event];
    [self.commandDelegate evalJs:js];
}

- (void) fireEvent: (NSString *) event withData: (NSDictionary *) data {
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:data options:kNilOptions error:&error];

    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    NSString *js = [NSString stringWithFormat:@"cordova.fireWindowEvent('%@', %@)", event, jsonString];
    [self.commandDelegate evalJs:js];

}

#pragma mark - SupersonicRVDelegate

- (void)supersonicRVInitSuccess {
    [self fireEvent: EVENT_REWARDED_VIDEO_INITIALIZED];
}

- (void)supersonicRVInitFailedWithError:(NSError *)error {

    NSDictionary *data = @{
            @"error": @{
                    @"user" : @(error.code),
                    @"message" : error.description
            }
    };

    [self fireEvent:EVENT_REWARDED_VIDEO_INIT_FAILED withData: data];
};

- (void)supersonicRVAdAvailabilityChanged:(BOOL)hasAvailableAds {

    NSDictionary *data = @{
            @"available" : @(hasAvailableAds)
    };
    [self fireEvent:EVENT_REWARDED_VIDEO_AVAILABILITY_CHANGED withData:data];
}

- (void)supersonicRVAdOpened {

    [self fireEvent:EVENT_REWARDED_VIDEO_OPENED];
}

- (void)supersonicRVAdStarted {
    [self fireEvent:EVENT_REWARDED_VIDEO_STARTED];
}

- (void)supersonicRVAdEnded {
    [self fireEvent:EVENT_REWARDED_VIDEO_ENDED];
}

- (void)supersonicRVAdClosed {
    [self fireEvent:EVENT_REWARDED_VIDEO_CLOSED];
}

- (void)supersonicRVAdRewarded:(SupersonicPlacementInfo *)placementInfo {

    NSDictionary *data = @{
            @"placement": @{
                    @"name": placementInfo.placementName,
                    @"reward": placementInfo.rewardName,
                    @"amount": placementInfo.rewardAmount
            }
    };
    [self fireEvent:EVENT_REWARDED_VIDEO_REWARDED withData:data];
}

- (void)supersonicRVAdFailedWithError:(NSError *)error {

    NSDictionary *data = @{
            @"error": @{
                    @"user" : @(error.code),
                    @"message" : error.description
            }
    };

    [self fireEvent:EVENT_REWARDED_VIDEO_FAILED withData: data];
}

- (void)supersonicISInitSuccess {

    [self fireEvent:EVENT_INTERSTITIAL_INITIALIZED];
}

- (void)supersonicISInitFailedWithError:(NSError *)error {

    NSDictionary *data = @{
            @"error": @{
                    @"user" : @(error.code),
                    @"message" : error.description
            }
    };

    [self fireEvent:EVENT_INTERSTITIAL_INIT_FAILED withData: data];
}

- (void)supersonicISShowSuccess {

    [self fireEvent:EVENT_INTERSTITIAL_SHOWN];
}

- (void)supersonicISShowFailWithError:(NSError *)error {

    NSDictionary *data = @{
            @"error": @{
                    @"user" : @(error.code),
                    @"message" : error.description
            }
    };

    [self fireEvent:EVENT_INTERSTITIAL_SHOW_FAILED withData: data];
}

- (void)supersonicISAdAvailable:(BOOL)available {

    NSDictionary *data = @{
            @"available": @(available)
    };
    [self fireEvent:EVENT_INTERSTITIAL_AVAILABILITY_CHANGED withData:data];
}

- (void)supersonicISAdClicked {

    [self fireEvent:EVENT_INTERSTITIAL_CLICKED];
}

- (void)supersonicISAdClosed {

    [self fireEvent:EVENT_INTERSTITIAL_CLOSED];
}

- (void)supersonicOWInitSuccess {

    [self fireEvent:EVENT_OFFERWALL_INITIALIZED];
}

- (void)supersonicOWShowSuccess {

    [self fireEvent:EVENT_OFFERWALL_OPENED];
}

- (void)supersonicOWInitFailedWithError:(NSError *)error {

    NSDictionary *data = @{
            @"error": @{
                    @"user" : @(error.code),
                    @"message" : error.description
            }
    };

    [self fireEvent:EVENT_OFFERWALL_INIT_FAILED withData: data];
}

- (void)supersonicOWShowFailedWithError:(NSError *)error {

    NSDictionary *data = @{
            @"error": @{
                    @"user" : @(error.code),
                    @"message" : error.description
            }
    };

    [self fireEvent:EVENT_OFFERWALL_SHOW_FAILED withData: data];
}

- (void)supersonicOWAdClosed {

    [self fireEvent:EVENT_OFFERWALL_CLOSED];
}

- (BOOL)supersonicOWDidReceiveCredit:(NSDictionary *)creditInfo {

    NSDictionary *data = @{
            @"credit": @{
                    @"amount": creditInfo[@"credits"],
                    @"total": creditInfo[@"totalCredits"],
                    @"estimate": creditInfo[@"totalCreditsFlag"]
            }
    };
    [self fireEvent:EVENT_OFFERWALL_CREDITED withData:data];
    return YES;
}

- (void)supersonicOWFailGettingCreditWithError:(NSError *)error {

    NSDictionary *data = @{
            @"error": @{
                    @"user" : @(error.code),
                    @"message" : error.description
            }
    };

    [self fireEvent:EVENT_OFFERWALL_CREDIT_FAILED withData: data];
}
@end