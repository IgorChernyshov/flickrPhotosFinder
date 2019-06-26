//
//  AppDelegate.m
//  sbsHomework16
//
//  Created by Igor Chernyshov on 23/06/2019.
//  Copyright © 2019 Igor Chernyshov. All rights reserved.
//

#import "AppDelegate.h"
#import "SBSFlickrCollectionViewController.h"


@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
	CGRect screenFrame = [[UIScreen mainScreen] bounds];
	UIViewController *viewController = [SBSFlickrCollectionViewController new];
	self.window = [[UIWindow alloc] initWithFrame:screenFrame];
	self.window.rootViewController = viewController;
	
	[self.window makeKeyAndVisible];
	return YES;
}

@end
