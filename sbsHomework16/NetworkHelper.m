//
//  NetworkHelper.m
//  sbsHomework16
//
//  Created by Igor Chernyshov on 23/06/2019.
//  Copyright © 2019 Igor Chernyshov. All rights reserved.
//

#import "NetworkHelper.h"


@implementation NetworkHelper


+ (NSString *)URLForSearchString:(NSString *)searchString
{
	NSString *APIKey = @"d7845523c70024fedd164176f120d051";
	return [NSString stringWithFormat:@"https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=%@&tags=%@&per_page=25&format=json&nojsoncallback=1", APIKey, searchString];
}

@end
