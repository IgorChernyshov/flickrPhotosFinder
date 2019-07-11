//
//  NetworkService.h
//  sbsHomework16
//
//  Created by Igor Chernyshov on 23/06/2019.
//  Copyright © 2019 Igor Chernyshov. All rights reserved.
//

#import "NetworkServiceProtocol.h"


NS_ASSUME_NONNULL_BEGIN


/**
 Сетевой сервис.
 Отвечает за работу с сетью - поиск изображений по запросу и их загрузку.
 */
@interface NetworkService : NSObject <NetworkServiceInputProtocol, NSURLSessionDelegate>

@property (nonatomic, weak) id<NetworkServiceOutputProtocol> output; /**< Делегат, которому передаются загруженные изображения. */

@end

NS_ASSUME_NONNULL_END
