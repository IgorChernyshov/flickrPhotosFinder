//
//  SBSFlickrModuleFactory.h
//  sbsHomework16
//
//  Created by Igor Chernyshov on 29/06/2019.
//  Copyright © 2019 Igor Chernyshov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SBSFlickrCollectionViewController.h"


NS_ASSUME_NONNULL_BEGIN


@interface SBSFlickrModuleFactory : NSObject

+ (SBSFlickrCollectionViewController *)buildFlickrModule;

@end

NS_ASSUME_NONNULL_END
