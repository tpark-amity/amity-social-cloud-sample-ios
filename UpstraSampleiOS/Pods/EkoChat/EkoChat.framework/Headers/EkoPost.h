//
//  EkoPost.h
//  EkoChat
//
//  Created by Michael Abadi Santoso on 4/13/20.
//  Copyright © 2020 eko. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EkoEnums.h"

@class EkoPost;
@class EkoUser;

/**
 * Post
 */
__attribute__((objc_subclassing_restricted))
@interface EkoPost : NSObject

/**
 * The unique identifier for the post
 */
@property (nonnull, strong, readonly, nonatomic) NSString *postId;

/**
 * The unique identifier for the post user id
 */
@property (nonnull, strong, readonly, nonatomic) NSString *postedUserId;

/**
 * The unique identifier for the shared user id
 */
@property (nonnull, strong, readonly, nonatomic) NSString *sharedUserId;

/**
 * The data type of the post
 */
@property (nonnull, strong, readonly, nonatomic) NSString *dataType;

/**
 The post author.
 */
@property (nullable, strong, readonly, nonatomic) EkoUser *postedUser;

/**
 The shared author.
 */
@property (nullable, strong, readonly, nonatomic) EkoUser *sharedUser;

/**
   Number of share on this post
 */
@property (assign, readonly, nonatomic) NSUInteger sharedCount;

/**
 * Post data
 */
@property (nullable, strong, readonly, nonatomic) NSDictionary<NSString *, id> *data;

/**
 * Post meta data
 */
@property (nullable, strong, readonly, nonatomic) NSDictionary<NSString *, id> *metadata;

/**
 * The creation date of the post
 */
@property (nonnull, strong, nonatomic) NSDate *createdAt;


/**
   @abstract The post last edited time
   @discussion The updated time is updated for updated data on the post
 */
@property (nonnull, strong, nonatomic) NSDate *updatedAt;

/**
  Number of reaction on this post
*/
@property (assign, nonatomic, readonly) NSUInteger reactionsCount;

/**
  The list of my reactions to this message.
*/
@property (nonnull, assign, readonly, nonatomic) NSArray <NSString *> *myReactions;

/**
 The reaction data.
 */
@property (nullable, strong, readonly, nonatomic) NSDictionary *reactions;

@end
