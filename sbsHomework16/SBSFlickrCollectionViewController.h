//
//  ViewController.h
//  sbsHomework16
//
//  Created by Igor Chernyshov on 23/06/2019.
//  Copyright © 2019 Igor Chernyshov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NetworkServiceProtocol.h"
#import "LocalNotificationsProtocol.h"
#import "SearchHistoryProtocol.h"
#import "PhotoFiltersProtocol.h"
@class NetworkService;
@class LocalNotificationsService;
@class SearchHistoryService;
@class PhotoFiltersService;


@interface SBSFlickrCollectionViewController : UIViewController <NetworkServiceOutputProtocol,
																LocalNotificationsOutputProtocol,
																SearchHistoryOutputProtocol,
																PhotoFiltersOutputProtocol>

- (instancetype)initWithNetworkService:(NetworkService *)networkService
				   notificationService:(LocalNotificationsService *)notificationService
				  searchHistoryService:(SearchHistoryService *)searchHistoryService
				   photoFiltersService:(PhotoFiltersService *)photoFiltersService;

@end

