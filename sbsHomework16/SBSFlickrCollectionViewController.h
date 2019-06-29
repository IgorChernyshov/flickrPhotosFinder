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
@class NetworkService;
@class LocalNotificationsService;


@interface SBSFlickrCollectionViewController : UIViewController <NetworkServiceOutputProtocol, LocalNotificationsOutputProtocol>

- (instancetype)initWithNetworkService:(NetworkService *)networkService
				   notificationService:(LocalNotificationsService *)notificationService;

@end

