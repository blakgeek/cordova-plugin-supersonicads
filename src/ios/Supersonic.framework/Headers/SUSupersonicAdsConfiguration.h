//
//  Copyright (c) 2015 Supersonic. All rights reserved.
//

#import <Supersonic/SupersonicConfiguration.h>

#define GENDER_MALE @"male"
#define GENDER_FEMALE @"female"

@interface SUSupersonicAdsConfiguration : SupersonicConfiguration

@property (nonatomic, strong)   NSString *  applicationKey;

@property (nonatomic, assign)   NSNumber *  useClientSideCallbacks;
@property (nonatomic, strong)   NSString *  applicationUserGender;
@property (nonatomic, strong)   NSString *  language;
@property (nonatomic, strong)   NSString *  applicationUserAgeGroup;
@property (nonatomic, strong)   NSString *  minimumOfferCommission;
@property (nonatomic, strong)   NSString *  campaignId;

@property (nonatomic, strong)   NSString *  itemName;
@property (strong)              NSNumber *  itemCount;
@property (strong)              NSNumber *  maxVideoLength;

@property (nonatomic, strong)   NSString *  privateKey;
@property (nonatomic)           BOOL        debugMode;

@end
