//
//  PhotoFiltersProtocol.h
//  sbsHomework16
//
//  Created by Igor Chernyshov on 30/06/2019.
//  Copyright © 2019 Igor Chernyshov. All rights reserved.
//

@import UIKit;


NS_ASSUME_NONNULL_BEGIN


@protocol PhotoFiltersInputProtocol <NSObject>

- (void)applyRandomFilterToImages:(NSArray<UIImage *> *)images;

@end

@protocol PhotoFiltersOutputProtocol <NSObject>

- (void)appliedFiltersToImages:(NSArray<UIImage *> *)images;

@end

NS_ASSUME_NONNULL_END
