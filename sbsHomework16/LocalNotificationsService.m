//
//  LocalNotificationsService.m
//  sbsHomework16
//
//  Created by Igor Chernyshov on 26/06/2019.
//  Copyright © 2019 Igor Chernyshov. All rights reserved.
//

#import "LocalNotificationsService.h"
@import UserNotifications;


static NSString * const categoryID = @"notificationCategoryID";
static NSString * const notificationID = @"localNotificationID";
static NSString * const askedForPermissionsSetting = @"askedForPermissions";


@interface LocalNotificationsService()

@property (nonatomic, strong) UNUserNotificationCenter *center;

@end


@implementation LocalNotificationsService


#pragma mark - Lifecycle

- (instancetype)init
{
	self = [super init];
	if (self) {
		_center = [UNUserNotificationCenter currentNotificationCenter];
	}
	return self;
}


#pragma mark - LocalNotificationsProtocol

- (void)applicationStarted
{
	[self resetBadgeCounter];
	NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
	BOOL alreadyRequestedPermissions = [userDefaults boolForKey:askedForPermissionsSetting];
	if (!alreadyRequestedPermissions)
	{
		[self requestNotificationsPermissions];
	}
}

- (void)scheduleNotificationWithText:(NSString *)text andImage:(UIImage *)foundImage
{
	__weak typeof(self)weakSelf = self;
	[self.center getNotificationSettingsWithCompletionHandler:^(UNNotificationSettings * _Nonnull settings) {
		if (settings.authorizationStatus != UNAuthorizationStatusAuthorized) {
			return;
		}
		__strong typeof(self)self = weakSelf;
		dispatch_async(dispatch_get_main_queue(), ^{
			UNNotificationRequest *request = [self createLocalNotificationWithText:text image:foundImage];
			[self scheduleLocalNotificationWithRequest:request];
		});
	}];
}

- (void)requestNotificationsPermissions
{
	UNAuthorizationOptions options = UNAuthorizationOptionSound | UNAuthorizationOptionAlert | UNAuthorizationOptionBadge;
	[self.center requestAuthorizationWithOptions:options
							   completionHandler:^(BOOL granted, NSError * _Nullable error) {
								   if (!granted)
								   {
									   dispatch_async(dispatch_get_main_queue(), ^{
										   [self.output showNoPermissionsAlert];
									   });
								   }
								   NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
								   [userDefaults setBool:YES forKey:askedForPermissionsSetting];
							   }];
}

#pragma mark - Private

- (void)resetBadgeCounter
{
	UIApplication.sharedApplication.applicationIconBadgeNumber = 0;
}

- (UNNotificationRequest *)createLocalNotificationWithText:(NSString *)text image:(UIImage *)image
{
	UNMutableNotificationContent *content = [UNMutableNotificationContent new];
	content.title = @"We miss you!";
	content.body = [NSString stringWithFormat:@"Come back and search for more cool %@ photos right now", text];
	content.sound = [UNNotificationSound defaultSound];
	content.badge = @([self currentBadgeNumber] + 1);
	content.categoryIdentifier = categoryID;
	
	UNNotificationAttachment *attachment = [self attachmentWithImage:image];
	if (attachment)
	{
		content.attachments = @[attachment];
	}
	
	UNNotificationTrigger *trigger = [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:5 repeats:NO];
	
	UNNotificationRequest *request = [UNNotificationRequest requestWithIdentifier:notificationID
																		  content:content
																		  trigger:trigger];
	
	return request;
}

- (void)scheduleLocalNotificationWithRequest:(UNNotificationRequest *)request
{
	UNUserNotificationCenter *notificationCenter = [UNUserNotificationCenter currentNotificationCenter];
	[notificationCenter addNotificationRequest:request withCompletionHandler:^(NSError * _Nullable error) {
		if (error)
		{
			NSLog(@"%@", error.localizedDescription);
		}
	}];
}


#pragma mark - Helpers

- (NSInteger)currentBadgeNumber
{
	return UIApplication.sharedApplication.applicationIconBadgeNumber;
}

- (UNNotificationAttachment *)attachmentWithImage:(UIImage *)image
{
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *filePath = [[paths objectAtIndex:0] stringByAppendingPathComponent:@"notificationImage.png"];
	[UIImagePNGRepresentation(image) writeToFile:filePath atomically:YES];
	
	NSURL *url = [NSURL fileURLWithPath:filePath];
	NSError *attachmentError;
	UNNotificationAttachment *attachment = [UNNotificationAttachment attachmentWithIdentifier:@"notificationImage"
																						  URL:url
																					  options:nil
																						error:&attachmentError];
	return attachment;
}

@end
