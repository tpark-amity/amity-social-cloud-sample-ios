//
//  EkoCommunityMembership.h
//  EkoChat
//
//  Created by Michael Abadi on 05/08/20.
//  Copyright © 2020 eko. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <EkoChat/EkoEnums.h>
#import <EkoChat/EkoObject.h>
#import <EkoChat/EkoUser.h>

@interface EkoCommunityMembership : NSObject

/**
   The channelId
 */
@property (nonnull, strong, readonly, nonatomic) NSString *channelId;

/**
   The communityId
 */
@property (nonnull, strong, readonly, nonatomic) NSString *communityId;

/**
   The userId
 */
@property (nonnull, strong, readonly, nonatomic) NSString *userId;

/**
   The user displayName
 */
@property (nonnull, strong, readonly, nonatomic) NSString *displayName;

/**
   The user live object (convenience property)
 */
@property (nullable, readonly, nonatomic) EkoObject<EkoUser *> *user;

/**
   Banned status
 */
@property (assign, readonly, nonatomic) BOOL isBanned;

/**
   The community member  metadata.
 */
@property (nonnull, assign, readonly, nonatomic) NSDictionary <NSString *, id> *metadata;

/**
 The user last activity time.
 */
@property (nonnull, strong, readonly, nonatomic) NSDate *lastActivityDate;

/**
 * When this model was created
 */
@property (nonnull, strong, nonatomic) NSDate *createdAt;

/**
 * The date when this model was last updated
 */
@property (nonnull, strong, nonatomic) NSDate *updatedAt;

/**
   The community membership status
 */
@property (readonly) EkoCommunityMembershipType membership;

/**
 Roles for this membership
 */
@property (nonnull, assign, readonly, nonatomic) NSArray <NSString *> *roles;

@end

