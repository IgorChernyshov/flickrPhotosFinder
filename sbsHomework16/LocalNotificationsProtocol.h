//
//  LocalNotificationsProtocol.h
//  sbsHomework16
//
//  Created by Igor Chernyshov on 29/06/2019.
//  Copyright © 2019 Igor Chernyshov. All rights reserved.
//

@import Foundation;


NS_ASSUME_NONNULL_BEGIN


/**
 Протокол input'а сервиса локальный оповещений.
 */
@protocol LocalNotificationsInputProtocol <NSObject>

/**
 Метод будет вызван при старте приложения. Используется для настройки сервиса оповещений.
 */
- (void)applicationStarted;

/**
 Метод для запроса прав на отображение оповещений.
 */
- (void)requestNotificationsPermissions;

/**
 Метод для создания локального оповещения.

 @param text Текст оповещения.
 @param image Картинка оповещения.
 */
- (void)scheduleNotificationWithText:(NSString *)text andImage:(UIImage *)image;

@end


/**
 Протокол делегата сервиса локальный оповещений.
 */
@protocol LocalNotificationsOutputProtocol <NSObject>

/**
 Показывает алерт об отсутствии прав на отображение оповещений.
 */
- (void)showNoPermissionsAlert;

@end

NS_ASSUME_NONNULL_END
