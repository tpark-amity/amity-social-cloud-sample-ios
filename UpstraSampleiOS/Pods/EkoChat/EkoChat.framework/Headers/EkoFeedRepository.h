//
//  EkoFeedRepository.h
//  EkoChat
//
//  Created by Michael Abadi Santoso on 4/13/20.
//  Copyright © 2020 eko. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EkoClient.h"
#import "EkoCollection.h"

@class EkoPostCreator;
@class EkoPost;
@class EkoPostReaction;

NS_ASSUME_NONNULL_BEGIN

/**
 * Repository provides access to feed and collections of feeds
 */
@interface EkoFeedRepository : NSObject

@property (strong, readonly, nonatomic) EkoClient *client;
@property (readonly, nonatomic) NSUInteger totalUnreadCount;

/**
   Designated intializer
   @param client A valid context instance
 */
- (instancetype)initWithClient:(EkoClient *)client NS_DESIGNATED_INITIALIZER;

/**
Creates a new Post Manager (convenience class for handling Post).

@return The EkoPostCreator  object.

@note This manager will handle all CUD operation of the Post Object
*/

- (nonnull EkoPostCreator *)postCreatorManager;

/**
Get the collection of own feed.
 
@param sortBy The sort option that user wish to select
@return The EkoCollection of EkoPost  object. Observe the changes for getting the result.
 
*/
- (nonnull EkoCollection<EkoPost *> *)getMyFeedSortedBy:(EkoUserFeedSortOption)sortBy;

/**
Get the collection of user feed.

@param userId The user id of selected user
@param sortBy The sort option that user wish to select
@return The EkoCollection of EkoPost  object. Observe the changes for getting the result.
 
*/
- (nonnull EkoCollection<EkoPost *> *)getUserFeed:(NSString *)userId
                                           sortBy:(EkoUserFeedSortOption)sortBy;

/**
 Get the collection of reactions for particular post for provided reaction name.
 
 @param postId: Id of the post
 @param reactionName: Name of the reaction
 @return EkoCollection of EkoPostReaction object. Observe the changes to get results.
 
 */
- (nonnull EkoCollection<EkoPostReaction *> *)getReactionsForPostWithPostId:(nonnull NSString *)postId reactionName:(NSString *)reactionName;

/**
Get all  reactions for particular post

@param postId: Id of the post
@return EkoCollection of EkoPostReaction object. Observe the changes to get results.

*/
- (nonnull EkoCollection<EkoPostReaction *> *)getAllReactionsForPostWithPostId:(nonnull NSString *)postId;

/**
   Block call of `init` and `new` because this object cannot be created directly
 **/
- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)new NS_UNAVAILABLE;

@end

NS_ASSUME_NONNULL_END
