//
//  NetworkService.m
//  sbsHomework16
//
//  Created by Igor Chernyshov on 23/06/2019.
//  Copyright © 2019 Igor Chernyshov. All rights reserved.
//

#import "NetworkService.h"
#import "NetworkHelper.h"


@implementation NetworkService


#pragma mark - NetworkServiceInputProtocol

- (void)findFlickrPhotosWithSearchString:(NSString *)searchString
{
	NSString *restrictedCharacters = @"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890";
	NSCharacterSet *charactersToFilter = [[NSCharacterSet characterSetWithCharactersInString:restrictedCharacters] invertedSet];
	NSString *filteredString = [[searchString componentsSeparatedByCharactersInSet:charactersToFilter] componentsJoinedByString:@""];
	NSString *urlString = [NetworkHelper URLForSearchString:filteredString];
	
	NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
	[request setURL:[NSURL URLWithString: urlString]];
	[request setHTTPMethod:@"GET"];
	[request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
	[request setTimeoutInterval:15];
	
	NSURLSession *session;
	session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
	
	NSURLSessionDataTask *sessionDataTask = [session dataTaskWithRequest:request
													   completionHandler:^(NSData * _Nullable data,
																		   NSURLResponse * _Nullable response,
																		   NSError * _Nullable error) {
														   if (!data)
														   {
															   return;
														   }
														   NSDictionary *temp = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
														   NSArray<NSURL *> *urls = [self photoURLWithData:temp];
														   [self.output searchFinishedWithNumberOfImages:urls.count];
														   [self downloadImagesWithURLs:urls];
													   }];
	[sessionDataTask resume];
}


#pragma mark - Private

- (NSArray<NSURL *> *)photoURLWithData:(NSDictionary *)data
{
	NSDictionary *photos = data[@"photos"][@"photo"];
	NSMutableArray<NSURL *> *urls = [NSMutableArray new];
	for (NSDictionary *photo in photos) {
		NSString *urlString = [NSString stringWithFormat: @"https://farm%@.staticflickr.com/%@/%@_%@_m.jpg",
							   photo[@"farm"],
							   photo[@"server"],
							   photo[@"id"],
							   photo[@"secret"]];
		NSURL *url = [NSURL URLWithString:urlString];
		[urls addObject:url];
	}
	return [urls copy];
}

- (void)downloadImagesWithURLs:(NSArray<NSURL *> *)urls
{
	for (NSURL *url in urls) {
		NSURLSessionConfiguration *sessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
		NSURLSession *urlSession = [NSURLSession sessionWithConfiguration:sessionConfiguration delegate:self delegateQueue:nil];
		NSURLSessionDownloadTask *downloadTask = [urlSession downloadTaskWithURL:url completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
			if (error)
			{
				return;
			}
			NSData *downloadedData = [NSData dataWithContentsOfURL:location];
			UIImage *image = [UIImage imageWithData:downloadedData];
			dispatch_async(dispatch_get_main_queue(), ^{
				[self.output downloadFinishedWithImage:image];
			});
		}];
		[downloadTask resume];
	}
}

@end
