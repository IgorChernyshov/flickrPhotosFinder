//
//  SearchHistoryProtocol.h
//  sbsHomework16
//
//  Created by Igor Chernyshov on 29/06/2019.
//  Copyright © 2019 Igor Chernyshov. All rights reserved.
//

#import <Foundation/Foundation.h>


NS_ASSUME_NONNULL_BEGIN


@protocol SearchHistoryInputProtocol <NSObject>

- (void)userEditedSearchFieldWithText:(NSString *)text;
- (void)userSearchedForText:(NSString *)text;

@end

@protocol SearchHistoryOutputProtocol <NSObject>

- (void)showSearchSuggestions:(NSArray<NSString *> *)suggestions;

@end

NS_ASSUME_NONNULL_END
