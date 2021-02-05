//
//  EkoPostCreationBuilder.h
//  EkoChat
//
//  Created by Michael Abadi Santoso on 5/12/20.
//  Copyright © 2020 eko. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface EkoPostCreationBuilder : NSObject

@property (nonnull, nonatomic, strong) NSString *text;
@property (nullable, nonatomic, strong) NSString *targetId;
@property (nullable, nonatomic, strong) NSString *targetType;

@end

NS_ASSUME_NONNULL_END
