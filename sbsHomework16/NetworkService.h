//
//  NetworkService.h
//  sbsHomework16
//
//  Created by Igor Chernyshov on 23/06/2019.
//  Copyright © 2019 Igor Chernyshov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NetworkServiceProtocol.h"


NS_ASSUME_NONNULL_BEGIN


@interface NetworkService : NSObject <NetworkServiceInputProtocol, NSURLSessionDelegate>

@property (nonatomic, weak) id<NetworkServiceOutputProtocol> output;

@end

NS_ASSUME_NONNULL_END
