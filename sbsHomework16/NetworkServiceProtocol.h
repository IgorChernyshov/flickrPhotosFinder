//
//  NetworkServiceProtocol.h
//  sbsHomework16
//
//  Created by Igor Chernyshov on 23/06/2019.
//  Copyright © 2019 Igor Chernyshov. All rights reserved.
//

@import UIKit;


@protocol NetworkServiceOutputProtocol <NSObject>

- (void)downloadFinishedWithImage:(UIImage *)image;

@end


@protocol NetworkServiceInputProtocol <NSObject>

- (void)findFlickrPhotosWithSearchString:(NSString *)searchString;

@end
