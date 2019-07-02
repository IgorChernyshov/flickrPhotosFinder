//
//  SearchHistoryService.m
//  sbsHomework16
//
//  Created by Igor Chernyshov on 29/06/2019.
//  Copyright © 2019 Igor Chernyshov. All rights reserved.
//

#import "SearchHistoryService.h"


static NSString * const searchHistory = @"searchHistory";


@interface SearchHistoryService()

@property (nonatomic, weak) NSUserDefaults *userDefaults;

@end


@implementation SearchHistoryService


#pragma mark - Lifecycle

- (instancetype)init
{
	self = [super init];
	if (self) {
		_userDefaults = [NSUserDefaults standardUserDefaults];
	}
	return self;
}


#pragma mark - SearchHistoryInputProtocol

- (void)userEditedSearchFieldWithText:(NSString *)text
{
	NSArray<NSString *> *userSearches = [self.userDefaults arrayForKey:searchHistory];
	if (text.length == 0)
	{
		NSArray *reversedSearchHistory = [[userSearches reverseObjectEnumerator] allObjects];
		[self.output showSearchSuggestions:reversedSearchHistory];
		return;
	}
	NSMutableArray<NSString *> *searchSuggestions = [NSMutableArray new];
	for (NSString *search in userSearches) {
		if ([search.lowercaseString containsString:text.lowercaseString]) {
			[searchSuggestions addObject:search];
		}
	}
	NSArray *reversedSearchHistory = [[searchSuggestions reverseObjectEnumerator] allObjects];
	[self.output showSearchSuggestions:[reversedSearchHistory copy]];
}

- (void)userSearchedForText:(NSString *)text
{
	if (text.length == 0)
	{
		return;
	}
	NSMutableArray<NSString *> *userSearches = [NSMutableArray new];
	[userSearches addObjectsFromArray:[self.userDefaults arrayForKey:searchHistory]];
	if ([userSearches containsObject:text])
	{
		return;
	}
	[userSearches addObject:text];
	[self.userDefaults setObject:userSearches forKey:searchHistory];
}

@end
