//
//  PhotoFiltersProtocol.h
//  sbsHomework16
//
//  Created by Igor Chernyshov on 30/06/2019.
//  Copyright © 2019 Igor Chernyshov. All rights reserved.
//

@import UIKit;


NS_ASSUME_NONNULL_BEGIN


/**
 Протокол input'а сервиса фото-фильтров.
 */
@protocol PhotoFiltersInputProtocol <NSObject>

/**
 Применяет случайный фильтр к изображению.

 @param images изображение к которому применяется фильтр.
 */
- (void)applyRandomFilterToImages:(NSArray<UIImage *> *)images;

@end


/**
 Протокол делегата сервиса фото-фильтров.
 */
@protocol PhotoFiltersOutputProtocol <NSObject>

/**
 Возвращает делегату изображение с фильтром.

 @param images изображение к которому был применён фильтр.
 */
- (void)appliedFiltersToImages:(NSArray<UIImage *> *)images;

@end

NS_ASSUME_NONNULL_END
