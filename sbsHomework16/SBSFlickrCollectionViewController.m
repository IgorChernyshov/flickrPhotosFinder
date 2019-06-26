//
//  ViewController.m
//  sbsHomework16
//
//  Created by Igor Chernyshov on 23/06/2019.
//  Copyright © 2019 Igor Chernyshov. All rights reserved.
//

#import "SBSFlickrCollectionViewController.h"
#import "SBSFlickrPhotoCell.h"
#import "NetworkService.h"


static NSString * const reuseID = @"collectionViewCellReuseID";
static const CGFloat cellInsets = 16.f;


@interface SBSFlickrCollectionViewController () <NetworkServiceOutputProtocol, UISearchBarDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UISearchBar *searchBar;
@property (nonatomic, strong) UIActivityIndicatorView *spinner;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NetworkService *networkService;
@property (nonatomic, strong) NSMutableArray<UIImage *> *images;

@end


@implementation SBSFlickrCollectionViewController


#pragma mark - Lifecycle

- (instancetype)init
{
	self = [super init];
	if (self) {
		[self createUI];
		[self setupConstraints];
		_networkService = [NetworkService new];
		_networkService.output = self;
		_images = [NSMutableArray new];
	}
	return self;
}


#pragma mark - Configure UI

- (void)createUI
{
	self.view.backgroundColor = [UIColor blueColor];
	
	_searchBar = [self createSearchBar];
	[self.view addSubview:_searchBar];
	
	_collectionView = [self createCollectionView];
	[self.view addSubview:_collectionView];
	
	_spinner = [self createSpinner];
	[self.view addSubview:_spinner];
}

- (UISearchBar *)createSearchBar
{
	UISearchBar *searchBar = [UISearchBar new];
	searchBar.frame = CGRectMake(CGRectGetMidX(self.view.frame), CGRectGetMidY(self.view.frame), 100.f, 100.f);
	searchBar.translatesAutoresizingMaskIntoConstraints = NO;
	searchBar.delegate = self;
	searchBar.barTintColor = [UIColor blueColor];
	searchBar.placeholder = @"Search photos...";
	return searchBar;
}

- (UIActivityIndicatorView *)createSpinner
{
	UIActivityIndicatorView *spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
	spinner.translatesAutoresizingMaskIntoConstraints = NO;
	spinner.color = [UIColor blueColor];
	return spinner;
}

- (UICollectionView *)createCollectionView
{
	UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
	layout.minimumLineSpacing = cellInsets;
	layout.minimumInteritemSpacing = cellInsets;
	CGFloat itemSideSize = (CGRectGetWidth(self.view.frame) / 2) - cellInsets * 1.5;
	layout.itemSize = CGSizeMake(itemSideSize, itemSideSize);
	
	UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
	collectionView.translatesAutoresizingMaskIntoConstraints = NO;
	collectionView.contentInset = UIEdgeInsetsMake(cellInsets, cellInsets, cellInsets, cellInsets);
	collectionView.dataSource = self;
	[collectionView registerClass:[SBSFlickrPhotoCell class] forCellWithReuseIdentifier:reuseID];
	collectionView.backgroundColor = [UIColor whiteColor];
	return collectionView;
}

- (void)setupConstraints
{
	UILayoutGuide *safeAreaGuide = self.view.safeAreaLayoutGuide;
	[self.view addConstraints: @[
								 [_searchBar.leftAnchor constraintEqualToAnchor:self.view.leftAnchor],
								 [_searchBar.topAnchor constraintEqualToAnchor:safeAreaGuide.topAnchor],
								 [_searchBar.rightAnchor constraintEqualToAnchor:self.view.rightAnchor],
								 [_searchBar.heightAnchor constraintEqualToConstant:50.f],
								 
								 [_spinner.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor],
								 [_spinner.centerYAnchor constraintEqualToAnchor:self.view.centerYAnchor],
								 [_spinner.heightAnchor constraintEqualToConstant:50.f],
								 [_spinner.widthAnchor constraintEqualToConstant:50.f],
								 
								 [_collectionView.leftAnchor constraintEqualToAnchor:self.view.leftAnchor],
								 [_collectionView.topAnchor constraintEqualToAnchor:_searchBar.bottomAnchor],
								 [_collectionView.rightAnchor constraintEqualToAnchor:self.view.rightAnchor],
								 [_collectionView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor]
								 ]];
}


#pragma mark - UISearchBarDelegate

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
	[self.images removeAllObjects];
	[self.collectionView reloadData];
	[self.searchBar resignFirstResponder];
	[self.spinner startAnimating];
	[self.networkService findFlickrPhotosWithSearchString:searchBar.text];
}


#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
	return self.images.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
	SBSFlickrPhotoCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseID forIndexPath:indexPath];
	[cell configureCellWithImage:self.images[indexPath.row]];
	return cell;
}


#pragma mark - NetworkServiceOutputProtocol

- (void)downloadFinishedWithImage:(UIImage *)image
{
	[self.images addObject:image];
	[self.spinner stopAnimating];
	[self.collectionView reloadData];
}

@end
