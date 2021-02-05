//
//  EkoUser.h
//  EkoMessage
//
//  Created by eko on 1/18/18.
//  Copyright © 2018 eko. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 * User Object
 */
__attribute__((objc_subclassing_restricted))
@interface EkoUser : NSObject
/**
 *
 */
@property (nonnull, strong, readonly, nonatomic) NSString *userId;

/**
 *
 */
@property (nullable, strong, readonly, nonatomic) NSString *displayName;

/**
 *
 */
@property (nonnull, strong, nonatomic) NSDate *createdAt;

/**
 *
 */
@property (nonnull, strong, nonatomic) NSDate *updatedAt;

/**
   Roles
 */
@property (nullable, assign, readonly, nonatomic) NSArray <NSString *> *roles;

/**
   Number of people that have flagged the user
 */
@property (assign, readonly, nonatomic) NSUInteger flagCount;

/**
 * User metadata
 */
@property (nullable, strong, readonly, nonatomic) NSDictionary<NSString *, id> *metadata;

@end
