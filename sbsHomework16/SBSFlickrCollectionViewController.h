//
//  ViewController.h
//  sbsHomework16
//
//  Created by Igor Chernyshov on 23/06/2019.
//  Copyright © 2019 Igor Chernyshov. All rights reserved.
//

@import UIKit;
#import "NetworkServiceProtocol.h"
#import "LocalNotificationsProtocol.h"
#import "SearchHistoryProtocol.h"
#import "PhotoFiltersProtocol.h"


/**
 Главный экран приложения.
 */
@interface SBSFlickrCollectionViewController : UIViewController <NetworkServiceOutputProtocol,
																LocalNotificationsOutputProtocol,
																SearchHistoryOutputProtocol,
																PhotoFiltersOutputProtocol>

/**
 Инициализатор View Controller'а со всеми необходимыми сервисами.

 @param networkService Сетевой сервис.
 @param notificationService Сервис локальных оповещений.
 @param searchHistoryService Сервис истории поиска.
 @param photoFiltersService Сервис применения фото-фильтров.
 @return Настроенный View Controller главного экрана приложения.
 */
- (instancetype)initWithNetworkService:(id<NetworkServiceInputProtocol>)networkService
				   notificationService:(id<LocalNotificationsInputProtocol>)notificationService
				  searchHistoryService:(id<SearchHistoryInputProtocol>)searchHistoryService
				   photoFiltersService:(id<PhotoFiltersInputProtocol>)photoFiltersService;

@end

