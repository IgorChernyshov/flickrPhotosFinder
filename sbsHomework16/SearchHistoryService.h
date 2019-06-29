//
//  SearchHistoryService.h
//  sbsHomework16
//
//  Created by Igor Chernyshov on 29/06/2019.
//  Copyright © 2019 Igor Chernyshov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SearchHistoryProtocol.h"


NS_ASSUME_NONNULL_BEGIN

@interface SearchHistoryService : NSObject <SearchHistoryInputProtocol>

@property (nonatomic, weak) id<SearchHistoryOutputProtocol> output;

@end

NS_ASSUME_NONNULL_END
