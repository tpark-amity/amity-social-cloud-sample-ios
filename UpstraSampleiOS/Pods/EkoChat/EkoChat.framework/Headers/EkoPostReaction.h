//
//  EkoPostReaction.h
//  EkoChat
//
//  Created by Nishan Niraula on 5/21/20.
//  Copyright © 2020 eko. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EkoReaction.h"

NS_ASSUME_NONNULL_BEGIN

__attribute__((objc_subclassing_restricted))
@interface EkoPostReaction : EkoReaction

/**
 Unique Id for this reaction
 */
@property (nonnull, strong, readonly, nonatomic) NSString *reactionId;

/**
 Unique id for Post, which contains this reaction
 */
@property (nonnull, strong, readonly, nonatomic) NSString *postId;

/**
 Name of this reaction
 */
@property (nonnull, strong, readonly, nonatomic) NSString *reactionName;

/**
 This reaction creation time
 */
@property (nonnull, strong, readonly, nonatomic) NSDate *createdAtDate;

/**
 The reference of reaction type, This would be Post
 */
@property (readonly, nonatomic) EkoReactionReferenceType referenceType;

/**
 The user id who reacted on this Post
 */
@property (nonnull, strong, readonly, nonatomic) NSString *reactorId;

/**
 The user name for user, who reacted on this post
 */
@property (nonnull, strong, readonly, nonatomic) NSString *reactorDisplayName;

@end

NS_ASSUME_NONNULL_END
