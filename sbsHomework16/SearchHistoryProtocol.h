//
//  SearchHistoryProtocol.h
//  sbsHomework16
//
//  Created by Igor Chernyshov on 29/06/2019.
//  Copyright © 2019 Igor Chernyshov. All rights reserved.
//

@import Foundation;


NS_ASSUME_NONNULL_BEGIN


/**
 Протокол input'а сервиса истории поиска.
 */
@protocol SearchHistoryInputProtocol <NSObject>

/**
 Передаёт сервису текст из поля поиска при его изменении.

 @param text Текущий текст в поле поиска.
 */
- (void)userEditedSearchFieldWithText:(NSString *)text;

/**
 Передаёт сервису текст из поля поиска когда пользователь нажимает кнопку "Поиск".

 @param text Поисковый запрос.
 */
- (void)userSearchedForText:(NSString *)text;

@end


/**
 Протокол делегата сервиса истории поиска.
 */
@protocol SearchHistoryOutputProtocol <NSObject>

/**
 Метод для отображения отфильтрованной истории поисковых запросов пользователя.

 @param suggestions Отфильтрованный массив истории поиска пользователя.
 */
- (void)showSearchSuggestions:(NSArray<NSString *> *)suggestions;

@end

NS_ASSUME_NONNULL_END
