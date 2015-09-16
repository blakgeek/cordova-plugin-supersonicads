//
//  Copyright (c) 2015 Supersonic. All rights reserved.
//

#ifndef SUPERSONIC_IS_DELEGATE_H
#define SUPERSONIC_IS_DELEGATE_H

#import <Foundation/Foundation.h>

@protocol SupersonicISDelegate <NSObject>

@required

- (void)supersonicISInitSuccess;
- (void)supersonicISInitFailedWithError:(NSError *)error;
- (void)supersonicISShowSuccess;
- (void)supersonicISShowFailWithError:(NSError *)error;
- (void)supersonicISAdAvailable:(BOOL)available;
- (void)supersonicISAdClicked;
- (void)supersonicISAdClosed;

@end

#endif