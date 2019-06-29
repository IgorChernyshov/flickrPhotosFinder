//
//  LocalNotificationsProtocol.h
//  sbsHomework16
//
//  Created by Igor Chernyshov on 29/06/2019.
//  Copyright © 2019 Igor Chernyshov. All rights reserved.
//

@import Foundation;


NS_ASSUME_NONNULL_BEGIN


@protocol LocalNotificationsInputProtocol <NSObject>

- (void)applicationStarted;
- (void)requestNotificationsPermissions;
- (void)scheduleNotificationWithText:(NSString *)text andImage:(UIImage *)image;

@end

@protocol LocalNotificationsOutputProtocol <NSObject>

- (void)showNoPermissionsAlert;

@end

NS_ASSUME_NONNULL_END
