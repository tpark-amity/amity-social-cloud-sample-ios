//
//  EkoPostReactor.h
//  EkoChat
//
//  Created by Michael Abadi Santoso on 4/21/20.
//  Copyright © 2020 eko. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EkoClient.h"
#import "EkoPost.h"

@class EkoPost;

NS_ASSUME_NONNULL_BEGIN

@interface EkoPostReactor : NSObject

/**
 The client context used to create the instance
 */
@property (nonnull, strong, readonly, nonatomic) EkoClient *client;

/**
The Post object associated with this reactor instance
 */
@property (nonnull, strong, readonly, nonatomic) EkoPost *post;

/**
 Designated Initializer
 @param client A valid EkoClient instance
 @param post Post object to which reaction is to be added
 */
- (nonnull instancetype) initWithClient: (nonnull EkoClient *)client post: (nonnull EkoPost *)post;

/**
 Add reaction to the post.
 */
- (void)addReaction: (nonnull NSString *)reaction completion: (EkoRequestCompletion _Nullable)completion;

/**
 Remove reaction from the post
 */
- (void)removeReaction: (nonnull NSString *)reaction completion: (EkoRequestCompletion _Nullable)completion;

// Disable object creation
- (nonnull instancetype)init NS_UNAVAILABLE;
+ (nonnull instancetype)new NS_UNAVAILABLE;

@end

NS_ASSUME_NONNULL_END
