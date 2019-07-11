//
//  SBSFlickrModuleFactory.h
//  sbsHomework16
//
//  Created by Igor Chernyshov on 29/06/2019.
//  Copyright © 2019 Igor Chernyshov. All rights reserved.
//

@import UIKit;


NS_ASSUME_NONNULL_BEGIN


/**
 Фабрика главного модуля приложения.
 */
@interface SBSFlickrModuleFactory : NSObject

/**
 Создаёт главный модуль приложения.

 @return Модуль с инжектированными зависимостями.
 */
+ (UIViewController *)buildFlickrModule;

@end

NS_ASSUME_NONNULL_END
