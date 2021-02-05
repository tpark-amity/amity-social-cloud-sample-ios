//
//  EkoReaction.h
//  EkoChat
//
//  Created by Nishan Niraula on 5/21/20.
//  Copyright © 2020 eko. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, EkoReactionReferenceType) {
    EkoReactionReferenceTypeMessage,
    EkoReactionReferenceTypePost
};

NS_ASSUME_NONNULL_BEGIN

@interface EkoReaction : NSObject

+ (NSString *)valueForReferenceType:(EkoReactionReferenceType)type;
+ (EkoReactionReferenceType)referenceTypeForValue:(NSString *)value;

@end

NS_ASSUME_NONNULL_END
