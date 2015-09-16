//
//  Copyright (c) 2015 Supersonic. All rights reserved.
//

#ifndef SUPERSONIC_OW_DELEGATE_H
#define SUPERSONIC_OW_DELEGATE_H

#import <Foundation/Foundation.h>

@protocol SupersonicOWDelegate <NSObject>

@required

- (void)supersonicOWInitSuccess;
- (void)supersonicOWShowSuccess;
- (void)supersonicOWInitFailedWithError:(NSError *)error;
- (void)supersonicOWShowFailedWithError:(NSError *)error;
- (void)supersonicOWAdClosed;
- (BOOL)supersonicOWDidReceiveCredit:(NSDictionary *)creditInfo;
- (void)supersonicOWFailGettingCreditWithError:(NSError *)error;

@end

#endif