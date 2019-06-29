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
#import "LocalNotificationsService.h"
#import "SearchHistoryService.h"
@import UserNotifications;


static NSString * const SBSImagesCollectionReuseID = @"flickrCellReuseID";
static NSString * const SBSSearchHistoryReuseID = @"searchHistoryReuseID";
static const CGFloat cellInsets = 16.f;
static const CGFloat cellHeight = 40.f;


@interface SBSFlickrCollectionViewController () <UISearchBarDelegate, UICollectionViewDataSource, UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UISearchBar *searchBar;
@property (nonatomic, strong) UIActivityIndicatorView *spinner;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UITableView *searchHistoryTableView;

@property (nonatomic, strong) NSArray<NSString *> *searchSuggestions;
@property (nonatomic, strong) NSMutableArray<UIImage *> *images;
@property (nonatomic, assign) NSInteger numberOfImagesFound;
@property (nonatomic, copy) NSString *lastSearch;

@property (nonatomic, strong) NetworkService *networkService;
@property (nonatomic, strong) LocalNotificationsService *notificationService;
@property (nonatomic, strong) SearchHistoryService *searchHistoryService;

@end


@implementation SBSFlickrCollectionViewController


#pragma mark - Lifecycle

- (instancetype)initWithNetworkService:(NetworkService *)networkService
				   notificationService:(LocalNotificationsService *)notificationService
				  searchHistoryService:(SearchHistoryService *)searchHistoryService;
{
	self = [super init];
	if (self) {
		_networkService = networkService;
		_notificationService = notificationService;
		_searchHistoryService = searchHistoryService;
		_images = [NSMutableArray new];
		
		[self createUI];
		[self setupConstraints];
	}
	return self;
}

- (void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
	[self.notificationService applicationStarted];
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
	
	_searchHistoryTableView = [self createSearchHistoryTableView];
	[self.view addSubview:_searchHistoryTableView];
}

- (UISearchBar *)createSearchBar
{
	UISearchBar *searchBar = [UISearchBar new];
	searchBar.frame = CGRectMake(CGRectGetMidX(self.view.frame), CGRectGetMidY(self.view.frame), 100.f, 100.f);
	searchBar.translatesAutoresizingMaskIntoConstraints = NO;
	searchBar.delegate = self;
	searchBar.barTintColor = [UIColor blueColor];
	searchBar.placeholder = @"Search photos...";
	searchBar.autocorrectionType = UITextAutocorrectionTypeNo;
	searchBar.spellCheckingType = UITextSpellCheckingTypeNo;
	searchBar.autocapitalizationType = UITextAutocapitalizationTypeNone;
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
	[collectionView registerClass:[SBSFlickrPhotoCell class] forCellWithReuseIdentifier:SBSImagesCollectionReuseID];
	collectionView.backgroundColor = [UIColor whiteColor];
	return collectionView;
}

- (UITableView *)createSearchHistoryTableView
{
	UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
	[tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:SBSSearchHistoryReuseID];
	tableView.translatesAutoresizingMaskIntoConstraints = NO;
	tableView.delegate = self;
	tableView.dataSource = self;
	tableView.hidden = YES;
	tableView.backgroundColor = [UIColor clearColor];
	tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
	tableView.estimatedRowHeight = cellHeight;
	tableView.bounces = NO;
	return tableView;
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
								 [_collectionView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor],
								 
								 [_searchHistoryTableView.topAnchor constraintEqualToAnchor:_searchBar.bottomAnchor],
								 [_searchHistoryTableView.leftAnchor constraintEqualToAnchor:self.view.leftAnchor],
								 [_searchHistoryTableView.rightAnchor constraintEqualToAnchor:self.view.rightAnchor],
								 [_searchHistoryTableView.heightAnchor constraintLessThanOrEqualToConstant:cellHeight * 3.5]
								 ]];
}


#pragma mark - UISearchBarDelegate

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
	[self.images removeAllObjects];
	[self.collectionView reloadData];
	[self.searchBar resignFirstResponder];
	[self.spinner startAnimating];
	self.lastSearch = searchBar.text;
	self.searchHistoryTableView.hidden = YES;
	[self.networkService findFlickrPhotosWithSearchString:searchBar.text];
	[self.searchHistoryService userSearchedForText:searchBar.text];
}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
	searchBar.text = @"";
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
	[self.searchHistoryService userEditedSearchFieldWithText:searchBar.text];
}

#pragma mark - SearchHistoryOutputProtocol

- (void)showSearchSuggestions:(NSArray<NSString *> *)suggestions
{
	self.searchSuggestions = suggestions;
	self.searchHistoryTableView.hidden = NO;
	[self.searchHistoryTableView reloadData];
}


#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
	return self.images.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
	SBSFlickrPhotoCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:SBSImagesCollectionReuseID forIndexPath:indexPath];
	[cell configureCellWithImage:self.images[indexPath.row]];
	return cell;
}


#pragma mark - NetworkServiceOutputProtocol

- (void)downloadFinishedWithImage:(UIImage *)image
{
	[self.images addObject:image];
	if (self.images.count >= self.numberOfImagesFound)
	{
		[self scheduleNotification];
	}
	[self.spinner stopAnimating];
	[self.collectionView reloadData];
}

- (void)searchFinishedWithNumberOfImages:(NSUInteger)numberOfImages
{
	self.numberOfImagesFound = numberOfImages;
}


#pragma mark - LocalNotificationsOutputProtocol

- (void)scheduleNotification
{
	NSUInteger randomImageNumber = arc4random_uniform((uint32_t)self.images.count);
	[self.notificationService scheduleNotificationWithText:self.lastSearch
												  andImage:self.images[randomImageNumber]];
}

- (void)showNoPermissionsAlert
{
	UIAlertController *alert;
	alert = [UIAlertController alertControllerWithTitle:@"So sad 😢"
												message:@"U won't see our ql notifications"
										 preferredStyle:UIAlertControllerStyleAlert];
	UIAlertAction *dismiss = [UIAlertAction actionWithTitle:@"Whatever" style:UIAlertActionStyleDefault handler:nil];
	[alert addAction:dismiss];
	[self presentViewController:alert animated:YES completion:nil];
}


#pragma mark - UITableViewDataSource Protocol

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return self.searchSuggestions.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:SBSSearchHistoryReuseID];
	cell.textLabel.text = self.searchSuggestions[indexPath.row];
	cell.backgroundColor = [UIColor colorWithWhite:0.9 alpha:0.7];
	cell.selectionStyle = UITableViewCellSelectionStyleNone;
	return cell;
}


#pragma mark - UITableViewDelegate Protocol

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	self.searchBar.text = self.searchSuggestions[indexPath.row];
	[self performSelector:@selector(searchBarSearchButtonClicked:) withObject:self.searchBar];
}

@end
