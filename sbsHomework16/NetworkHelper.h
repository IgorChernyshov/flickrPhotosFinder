//
//  NetworkHelper.h
//  sbsHomework16
//
//  Created by Igor Chernyshov on 23/06/2019.
//  Copyright © 2019 Igor Chernyshov. All rights reserved.
//

@import Foundation;


NS_ASSUME_NONNULL_BEGIN


/**
 Хэлпер сетевого сервиса, который создаёт API-запросы.
 */
@interface NetworkHelper : NSObject

/**
 Создаёт API-запрос из поискового запроса в виде строки.

 @param searchString Поисковый запрос, который ввёл пользователь.
 @return API-запрос с необходимыми для поиска параметрами.
 */
+ (NSString *)URLForSearchString:(NSString *)searchString;

@end

NS_ASSUME_NONNULL_END
