//
//  EkoStreamNotificationsManager.h
//  EkoChat
//
//  Created by Nutchaphon Rewik on 10/11/2563 BE.
//  Copyright © 2563 eko. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**
  @abstract Responsible to manage the stream push notification settings.
*/
@interface EkoStreamNotificationsManager : NSObject

/**
   @abstract The completion block type.
   @discussion The requests will go through the backend.

   @param success The outcome of the callback.
   @param error (optional) The error from the backend.
 */
    typedef void (^EkoRequestCompletion)(BOOL success, NSError * _Nullable error);

/**
   @abstract Updates the stream push notification setting.
   @note This setting will take effect on all devices.

   @param isAllowed Whether or not the user would like to receive any push notifications.
   @param completion A block executed when the request has completed.
 */
- (void)setIsAllowed:(BOOL)isAllowed completion:(nullable EkoRequestCompletion)completion;

/**
   @abstract Retrieve the current stream push notification state.
   @note This setting is for all users.

   @param completion A block executed when the request has completed.
 */
- (void)isAllowedWithCompletion:(void(^ _Nonnull)(BOOL isAllowed, NSError * _Nullable))completion;

/**
   Block call of `init` and `new` because this object cannot be created directly
 **/
- (nonnull instancetype)init NS_UNAVAILABLE;
+ (nonnull instancetype)new NS_UNAVAILABLE;

@end

NS_ASSUME_NONNULL_END
