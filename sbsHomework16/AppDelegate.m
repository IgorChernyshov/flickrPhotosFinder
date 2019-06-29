//
//  AppDelegate.m
//  sbsHomework16
//
//  Created by Igor Chernyshov on 23/06/2019.
//  Copyright © 2019 Igor Chernyshov. All rights reserved.
//

#import "AppDelegate.h"
#import "SBSFlickrCollectionViewController.h"
#import "NetworkService.h"
#import "LocalNotificationsService.h"


@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
	
	CGRect screenFrame = [[UIScreen mainScreen] bounds];
	NetworkService *networkService = [NetworkService new];
	LocalNotificationsService *notificationService = [LocalNotificationsService new];
	
	SBSFlickrCollectionViewController *viewController;
	viewController = [[SBSFlickrCollectionViewController alloc] initWithNetworkService:networkService
																   notificationService:notificationService];
	networkService.output = viewController;
	notificationService.output = viewController;
	
	self.window = [[UIWindow alloc] initWithFrame:screenFrame];
	self.window.rootViewController = viewController;
	
	[self.window makeKeyAndVisible];
	return YES;
}

@end
