//
//  Copyright (c) 2015 Supersonic. All rights reserved.
//

#ifndef SUPERSONIC_H
#define SUPERSONIC_H

#import <Foundation/Foundation.h>

#import "SupersonicConfiguration.h"
#import "SupersonicGender.h"
#import "SupersonicRVDelegate.h"
#import "SupersonicOWDelegate.h"
#import "SupersonicISDelegate.h"
#import "SupersonicLogDelegate.h"
#import "SupersonicPlacementInfo.h"


@class UIViewController;

@interface Supersonic : NSObject

+ (Supersonic *)sharedInstance;

- (NSString*)getVersion;
- (void)setAge:(int)age;
- (void)setGender:(SupersonicGender)gender;

/*-----------------------------------------------*/
// Rewarded Video
/*-----------------------------------------------*/
- (void)initRVWithAppKey:(NSString*)appKey withUserId:(NSString *)userId;
- (void)setRVDelegate:(id<SupersonicRVDelegate>) rvDelegate;
- (void)showRV;
- (void)showRVWithPlacementName:(NSString*)placementName;
- (void)showRVWithViewController:(UIViewController*)viewController;
- (BOOL)isAdAvailable;
- (SupersonicPlacementInfo*) getRVPlacementInfo:(NSString*)placementName;

/*-----------------------------------------------*/
// Interstitial
/*-----------------------------------------------*/
- (void)initISWithAppKey:(NSString*)appKey withUserId:(NSString *)userId;
- (void)setISDelegate:(id<SupersonicISDelegate>) isDelegate;
- (void)showIS;
- (void)showISWithViewController:(UIViewController*)viewController;
- (void)forceShowIS;
- (BOOL)isISAdAvailable;

/*-----------------------------------------------*/
// Offerwall
/*-----------------------------------------------*/
- (void)initOWWithAppKey:(NSString*)appKey withUserId:(NSString *)userId;
- (void)setOWDelegate:(id<SupersonicOWDelegate>) owDelegate;
- (void)showOW;
- (void)showOWWithViewController:(UIViewController*)viewController;
- (void)getOWCredits;
- (BOOL)isOWAvailable;

/*-----------------------------------------------*/
// Logging
/*-----------------------------------------------*/
- (void)setLogDelegate:(id<SupersonicLogDelegate>) logDelegate;

@end

#endif