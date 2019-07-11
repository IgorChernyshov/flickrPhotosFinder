//
//  LocalNotificationsService.h
//  sbsHomework16
//
//  Created by Igor Chernyshov on 26/06/2019.
//  Copyright © 2019 Igor Chernyshov. All rights reserved.
//

@import UIKit;
#import "LocalNotificationsProtocol.h"


NS_ASSUME_NONNULL_BEGIN


/**
 Сервис локальных оповещений.
 Создаёт оповещения с текстом последнего запроса и случайной картинкой из результатов поиска.
 */
@interface LocalNotificationsService : NSObject <LocalNotificationsInputProtocol>

@property (nonatomic, weak) id<LocalNotificationsOutputProtocol> output; /**< Делегат, который отображает алерт об отсутствии прав на показ оповещений. */

@end

NS_ASSUME_NONNULL_END
