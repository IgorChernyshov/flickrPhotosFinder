//
//  SearchHistoryService.h
//  sbsHomework16
//
//  Created by Igor Chernyshov on 29/06/2019.
//  Copyright © 2019 Igor Chernyshov. All rights reserved.
//

#import "SearchHistoryProtocol.h"


NS_ASSUME_NONNULL_BEGIN


/**
 Сервис истории поиска. Сохраняет запросы пользователя и возвращает их делегату при изменении текста в поле поиска.
 */
@interface SearchHistoryService : NSObject <SearchHistoryInputProtocol>

@property (nonatomic, weak) id<SearchHistoryOutputProtocol> output; /**< Делегат, который получает историю поиска пользователя. */

@end

NS_ASSUME_NONNULL_END
