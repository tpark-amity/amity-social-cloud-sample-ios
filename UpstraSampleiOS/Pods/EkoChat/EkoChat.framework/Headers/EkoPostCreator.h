//
//  EkoPostCreator.h
//  EkoChat
//
//  Created by Michael Abadi Santoso on 4/21/20.
//  Copyright © 2020 eko. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EkoClient.h"
#import "EkoPostCreationBuilder.h"

@class EkoPost;

/**
   A editor encapsulates methods for managing post
 */
@interface EkoPostCreator : NSObject

/**
   The context used to create the instance
 */
@property (nonnull, strong, readonly, nonatomic) EkoClient *client;

/**
   Designated intializer
   @param client A valid context instance
 */
- (nonnull instancetype)initWithClient:(nonnull EkoClient *)client NS_DESIGNATED_INITIALIZER;

/**
  Create the which need a text represented by string value
  @param text The text data want to be put
  @param builder The target builder object
*/
- (void)createPostWithBuilder:(nonnull EkoPostCreationBuilder *)builder
                   completion:(EkoRequestCompletion _Nullable)completion;

/**
   Update specific post with the updated data
   @param postId A post id represent the post object
   @param text A valid updated data represented by string value
 */
- (void)updatePostWithPostId:(nonnull NSString *)postId
                        text:(nonnull NSString *)text
                  completion:(EkoRequestCompletion _Nullable)completion;

/**
   Delete the specific post
   @param postId A post id represent the post object
 */
- (void)deletePostWithPostId:(nonnull NSString *)postId
                  completion:(EkoRequestCompletion _Nullable)completion;

/// Block call of `init` and `new` because this object cannot be created directly
- (nonnull instancetype)init NS_UNAVAILABLE;
+ (nonnull instancetype)new NS_UNAVAILABLE;

@end
