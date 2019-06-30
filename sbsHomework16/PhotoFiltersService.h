//
//  PhotoFiltersService.h
//  sbsHomework16
//
//  Created by Igor Chernyshov on 30/06/2019.
//  Copyright © 2019 Igor Chernyshov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PhotoFiltersProtocol.h"


NS_ASSUME_NONNULL_BEGIN


@interface PhotoFiltersService : NSObject <PhotoFiltersInputProtocol>

@property (nonatomic, weak) id<PhotoFiltersOutputProtocol> output;

@end

NS_ASSUME_NONNULL_END
