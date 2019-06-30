//
//  SBSFlickrModuleFactory.m
//  sbsHomework16
//
//  Created by Igor Chernyshov on 29/06/2019.
//  Copyright © 2019 Igor Chernyshov. All rights reserved.
//

#import "SBSFlickrModuleFactory.h"
#import "NetworkService.h"
#import "LocalNotificationsService.h"
#import "SearchHistoryService.h"
#import "PhotoFiltersService.h"


@implementation SBSFlickrModuleFactory

+ (SBSFlickrCollectionViewController *)buildFlickrModule
{
	NetworkService *networkService = [NetworkService new];
	LocalNotificationsService *notificationService = [LocalNotificationsService new];
	SearchHistoryService *searchHistoryService = [SearchHistoryService new];
	PhotoFiltersService *photoFiltersService = [PhotoFiltersService new];
	SBSFlickrCollectionViewController *flickrViewController;
	
	flickrViewController = [[SBSFlickrCollectionViewController alloc] initWithNetworkService:networkService
																		 notificationService:notificationService
																		searchHistoryService:searchHistoryService
																		 photoFiltersService:photoFiltersService];
	networkService.output = flickrViewController;
	notificationService.output = flickrViewController;
	searchHistoryService.output = flickrViewController;
	photoFiltersService.output = flickrViewController;
	
	return flickrViewController;
}

@end
