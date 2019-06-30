//
//  PhotoFiltersService.m
//  sbsHomework16
//
//  Created by Igor Chernyshov on 30/06/2019.
//  Copyright © 2019 Igor Chernyshov. All rights reserved.
//

#import "PhotoFiltersService.h"


@implementation PhotoFiltersService


#pragma mark - PhotoFiltersInputProtocol

- (void)applyRandomFilterToImages:(NSArray<UIImage *> *)images
{
	NSMutableArray *imagesWithFilter = [NSMutableArray new];
	CIFilter *randomFilter = [self createRandomFilter];
	
	__weak typeof(self)weakSelf = self;
	dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
		__strong typeof(self)self = weakSelf;
		for (UIImage *image in images) {
			[imagesWithFilter addObject:[self imageAfterApplyingFilter:randomFilter toImage:image]];
		}
		dispatch_async(dispatch_get_main_queue(), ^{
			[self.output appliedFiltersToImages:imagesWithFilter];
		});
	});
}

- (UIImage *)imageAfterApplyingFilter:(CIFilter *)filter toImage:(UIImage *)image
{
	CIImage *ciimage = [CIImage imageWithCGImage:image.CGImage];
	[filter setValue:ciimage forKey:kCIInputImageKey];
	ciimage = [filter outputImage];
	UIImage *imageWithFilter = [UIImage imageWithCIImage:ciimage];
	
	return imageWithFilter;
}


#pragma mark - Private

- (CIFilter *)createRandomFilter
{
	NSUInteger randomIndex = arc4random() % [self filterNames].count;
	NSString *randomFilterName = [self filterNames][randomIndex];
	CIFilter *filter = [CIFilter filterWithName:randomFilterName];
	
	return filter;
}


#pragma mark - Helpers

- (NSArray *)filterNames
{
	static NSArray<NSString *> *filterNames;
	static dispatch_once_t onceToken;
	
	dispatch_once(&onceToken, ^{
		filterNames = @[
						@"CIPhotoEffectChrome",
						@"CIPhotoEffectFade",
						@"CIPhotoEffectInstant",
						@"CIPhotoEffectMono",
						@"CIPhotoEffectNoir",
						@"CIPhotoEffectProcess",
						@"CIPhotoEffectTonal",
						@"CIPhotoEffectTransfer",
						@"CISepiaTone",
						@"CIVignette",
						@"CIComicEffect",
						@"CIPixellate"
						];
	});
	return filterNames;
}

@end
