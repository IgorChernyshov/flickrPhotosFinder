//
//  NetworkServiceProtocol.h
//  sbsHomework16
//
//  Created by Igor Chernyshov on 23/06/2019.
//  Copyright © 2019 Igor Chernyshov. All rights reserved.
//

@import UIKit;


/**
 Протокол делегата сервиса сетевых операций.
 */
@protocol NetworkServiceInputProtocol <NSObject>

/**
 Метод поиска изображений по поисковому запросу.
 
 @param searchString Поисковый запрос.
 */
- (void)findFlickrPhotosWithSearchString:(NSString *)searchString;

@end


/**
 Протокол input'а сервиса сетевых операций.
 */
@protocol NetworkServiceOutputProtocol <NSObject>

/**
 Метод вызывается при окончании загрузки изображения.

 @param image Загруженное изображение.
 */
- (void)downloadFinishedWithImage:(UIImage *)image;

/**
 Метод вызывается по окончании поиска изображений.

 @param numberOfImages Количество найденных изображений.
 */
- (void)searchFinishedWithNumberOfImages:(NSUInteger)numberOfImages;

@end
