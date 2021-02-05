//
//  EkoPostUserFeedBuilder.h
//  EkoChat
//
//  Created by Michael Abadi Santoso on 5/12/20.
//  Copyright © 2020 eko. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EkoPostCreationBuilder.h"

NS_ASSUME_NONNULL_BEGIN
@interface EkoPostUserFeedBuilder : EkoPostCreationBuilder

- (nonnull instancetype)initWithText:(nonnull NSString *)text userId:(NSString *)userId;

- (nonnull instancetype)init NS_UNAVAILABLE;
+ (nonnull instancetype)new NS_UNAVAILABLE;

@end
NS_ASSUME_NONNULL_END