//
//  EkoCommunityModeration.h
//  EkoChat
//
//  Created by Michael Abadi on 31/08/20.
//  Copyright © 2020 eko. All rights reserved.
//

#import <EkoChat/EkoClient.h>
#import <Foundation/Foundation.h>
@class EkoCommunity;

NS_ASSUME_NONNULL_BEGIN

/**
   A community moderator object
 */

@interface EkoCommunityModeration : NSObject

/**
   Designated intializer.
   @param client A valid client instance.
   @param communityId The Id of the channel to update.
 */
- (nonnull instancetype)initWithClient:(nonnull EkoClient *)client
                          andCommunity:(nonnull NSString *)communityId NS_DESIGNATED_INITIALIZER;

/**
   The client used to create the instance
 */
@property (nonnull, strong, readonly, nonatomic) EkoClient *client;
/**
   The community Id associated with the instance
 */
@property (nonnull, strong, readonly, nonatomic) NSString *communityId;

/**
   Ban users
   @param userIds An array of userIds
   @param completion A block executed when this request is complete.
 */
- (void)banUsers:(nonnull NSArray<NSString *> *)userIds
      completion:(EkoRequestCompletion _Nullable)completion;

/**
   unban users
   @param userIds An array of userIds
   @param completion A block executed when this request is complete.
 */
- (void)unbanUsers:(nonnull NSArray<NSString *> *)userIds
        completion:(EkoRequestCompletion _Nullable)completion;

/**
 Assigns role to users.
 
 @param role: Role to be assigned
 @param userIds: Id of users to whom this role is to be assigned
 @param completion: A block executed when this request is complete.
 */
- (void)addRole:(nonnull NSString *)role userIds:(nonnull NSArray<NSString *> *)userIds completion:(nullable EkoRequestCompletion)completion;

/**
 Removes role assigned to users.
 
 @param role: Role to be removed
 @param userIds: Array of user ids from which this role is to be removed
 @param completion: A block executed when this request is complete.
 */
- (void)removeRole:(nonnull NSString *)role userIds:(nonnull NSArray<NSString *> *)userIds completion:(nullable EkoRequestCompletion)completion;
/**
   Block call of `init` and `new` because this object cannot be created directly
 */
- (nonnull instancetype)init NS_UNAVAILABLE;
+ (nonnull instancetype)new NS_UNAVAILABLE;

@end

NS_ASSUME_NONNULL_END
