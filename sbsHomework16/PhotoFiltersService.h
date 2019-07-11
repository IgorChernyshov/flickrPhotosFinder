//
//  PhotoFiltersService.h
//  sbsHomework16
//
//  Created by Igor Chernyshov on 30/06/2019.
//  Copyright © 2019 Igor Chernyshov. All rights reserved.
//

#import "PhotoFiltersProtocol.h"


NS_ASSUME_NONNULL_BEGIN


/**
 Сервис фото-фильтров. Применяет фильтры к изображению и возвращает изображения делегату.
 */
@interface PhotoFiltersService : NSObject <PhotoFiltersInputProtocol>

@property (nonatomic, weak) id<PhotoFiltersOutputProtocol> output; /**< Делегат, которому передаётся обработанное изображение. */

@end

NS_ASSUME_NONNULL_END
