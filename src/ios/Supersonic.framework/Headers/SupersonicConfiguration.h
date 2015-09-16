//
//  Copyright (c) 2015 Supersonic. All rights reserved.
//

#ifndef SUPERSONIC_CONFIGURATION_H
#define SUPERSONIC_CONFIGURATION_H

#import <Foundation/Foundation.h>
#import "SupersonicConfigurationProtocol.h"
#import "SupersonicGender.h"

@interface SupersonicConfiguration : NSObject<SupersonicConfigurationProtocol>

@property (nonatomic, strong)   NSString *  userId;
@property (nonatomic, strong)   NSString *  appKey;
@property (nonatomic, strong)   NSDictionary *  rewardedVideoCustomParameters;
@property (nonatomic, strong)   NSDictionary *  offerwallCustomParameters;
@property (nonatomic,strong)    NSString*  version;
@property (nonatomic,strong)    NSNumber*  adapterTimeOutInSeconds;
@property (nonatomic,strong)    NSNumber*  maxNumOfAdaptersToLoadOnStart;
@property (nonatomic, strong)   NSString * plugin;
@property (nonatomic, strong)   NSString * pluginVersion;

+ (SupersonicConfiguration *)getConfiguration;

- (void)setAge:(int)age;
- (void)setGender:(SupersonicGender)gender;

@end

#endif