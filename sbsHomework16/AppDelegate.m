//
//  AppDelegate.m
//  sbsHomework16
//
//  Created by Igor Chernyshov on 23/06/2019.
//  Copyright © 2019 Igor Chernyshov. All rights reserved.
//

#import "AppDelegate.h"
#import "SBSFlickrModuleFactory.h"


@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
	CGRect screenFrame = [[UIScreen mainScreen] bounds];
	self.window = [[UIWindow alloc] initWithFrame:screenFrame];
	self.window.rootViewController = [SBSFlickrModuleFactory buildFlickrModule];
	
	[self.window makeKeyAndVisible];
	return YES;
}

@end
