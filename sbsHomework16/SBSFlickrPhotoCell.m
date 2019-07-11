//
//  SBSFlickrPhotoCell.m
//  sbsHomework16
//
//  Created by Igor Chernyshov on 23/06/2019.
//  Copyright © 2019 Igor Chernyshov. All rights reserved.
//

#import "SBSFlickrPhotoCell.h"


@implementation SBSFlickrPhotoCell


#pragma mark - Lifecycle

- (instancetype)initWithFrame:(CGRect)frame
{
	self = [super initWithFrame:frame];
	if (self) {
		_imageView = [self createImageView];
		[self.contentView addSubview:_imageView];
		[self setupConstraints];
	}
	return self;
}

- (void)prepareForReuse
{
	self.imageView.image = nil;
}


#pragma mark - UI Configuration

- (UIImageView *)createImageView
{
	UIImageView *imageView = [UIImageView new];
	imageView.translatesAutoresizingMaskIntoConstraints = NO;
	imageView.contentMode = UIViewContentModeScaleAspectFit;
	return imageView;
}

- (void)setupConstraints
{
	[self.contentView addConstraints:@[
									   [_imageView.topAnchor constraintEqualToAnchor:self.contentView.topAnchor],
									   [_imageView.leftAnchor constraintEqualToAnchor:self.contentView.leftAnchor],
									   [_imageView.bottomAnchor constraintEqualToAnchor:self.contentView.bottomAnchor],
									   [_imageView.rightAnchor constraintEqualToAnchor:self.contentView.rightAnchor]
									   ]];
}

@end
