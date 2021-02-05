//
//  EkoChannelQueryBuilder.h
//  EkoChat
//
//  Created by Michael Abadi Santoso on 2/3/20.
//  Copyright © 2020 eko. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <EkoChat/EkoChannelQuery.h>
#import <EkoChat/EkoStandardChannelQuery.h>
#import <EkoChat/EkoPrivateChannelQuery.h>
#import <EkoChat/EkoByTypesChannelQuery.h>
#import <EkoChat/EkoBroadcastChannelQuery.h>
#import <EkoChat/EkoConversationChannelQuery.h>
#import <EkoChat/EkoPrivateChannelQueryBuilder.h>
#import <EkoChat/EkoStandardChannelQueryBuilder.h>
#import <EkoChat/EkoByTypesChannelQueryBuilder.h>
#import <EkoChat/EkoBroadcastChannelQueryBuilder.h>
#import <EkoChat/EkoClient.h>

@class EkoLiveChannelQuery;
@class EkoLiveChannelQueryBuilder;
@class EkoCommunityChannelQuery;
@class EkoCommunityChannelQueryBuilder;

NS_ASSUME_NONNULL_BEGIN

@interface EkoChannelQueryBuilder : NSObject

@property (strong, readonly, nonatomic) EkoClient *client;

- (instancetype)initWithClient:(EkoClient *)client NS_DESIGNATED_INITIALIZER;
- (nonnull EkoPrivateChannelQuery *)privateTypeWithBuilder:(EkoPrivateChannelQueryBuilder *)builder;
- (nonnull EkoStandardChannelQuery *)standardTypeWithBuilder:(EkoStandardChannelQueryBuilder *)builder;
- (nonnull EkoByTypesChannelQuery *)byTypesWithBuilder:(EkoByTypesChannelQueryBuilder *)builder;
- (nonnull EkoBroadcastChannelQuery *)broadcastWithBuilder:(EkoBroadcastChannelQueryBuilder *)builder;
- (nonnull EkoConversationChannelQuery *)conversationWithBuilder:(EkoConversationChannelQueryBuilder *)builder;
- (nonnull EkoLiveChannelQuery *)liveTypeWithBuilder:(EkoLiveChannelQueryBuilder *)builder;
- (nonnull EkoCommunityChannelQuery *)communityTypeWithBuilder:(EkoCommunityChannelQueryBuilder *)builder;

- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)new NS_UNAVAILABLE;
@end

NS_ASSUME_NONNULL_END
