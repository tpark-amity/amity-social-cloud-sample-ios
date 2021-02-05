//
//  EkoChannelFeedServicable.h
//  EkoChat
//
//  Created by Michael Abadi Santoso on 4/13/20.
//  Copyright © 2020 eko. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EkoCollection.h"
#import "EkoObject.h"
#import "EkoChannel.h"

@protocol EkoChannelFeedServicable <NSObject>

@required
- (nonnull EkoCollection<EkoChannel *> *)searchChannel:(nonnull NSString *)displayName;
- (nonnull EkoCollection<EkoChannel *> *)suggestedChannelCollection;

@end
