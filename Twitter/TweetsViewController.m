//
//  TweetsViewController.m
//  Twitter
//
//  Created by Alex Lester on 11/9/15.
//  Copyright © 2015 Alex Lester. All rights reserved.
//

#import "TweetsViewController.h"
#import "User.h"
#import "Tweet.h"
#import "TwitterClient.h"
#import "TweetTableViewCell.h"
#import "UIImageView+AFNetworking.h"
#import "ComposeViewController.h"
#import "IndividualTweetViewController.h"
#import "ProfileViewController.h"
#import "HamburgerViewController.h"
#import "ProfileButton.h"

@interface TweetsViewController ()<UITableViewDataSource>

@property (strong, nonatomic) NSArray *tweets;

@end

@implementation TweetsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	
	UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
	refreshControl.attributedTitle = [[NSAttributedString alloc] initWithString:@"Please Wait..."]; //to give the attributedTitle
	[refreshControl addTarget:self action:@selector(refresh:) forControlEvents:UIControlEventValueChanged];
	[self.tableView addSubview:refreshControl];
	
	[[TwitterClient sharedInstance] homeTimeLineWithParams:nil completion:^(NSArray *tweets, NSError *error) {
		self.tweets = tweets;
		[self.tableView reloadData];
	}];
	
    // Do any additional setup after loading the view from its nib.
	
	self.tableView.delegate = self;
	self.tableView.dataSource = self;
	self.tableView.estimatedRowHeight = 100;
	self.tableView.rowHeight = UITableViewAutomaticDimension;
	

	[self.tableView registerNib:[UINib nibWithNibName:@"TweetTableViewCell" bundle:nil] forCellReuseIdentifier:@"TweetCell"];
	
	self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Sign Out" style:UIBarButtonItemStylePlain target:self action:@selector(onLogout)];
	self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"New" style:UIBarButtonItemStylePlain target:self action:@selector(onNew)];
	
	
	UILabel * titleView = [[UILabel alloc] initWithFrame:CGRectZero];
	titleView.backgroundColor = [UIColor clearColor];
	titleView.font = [UIFont boldSystemFontOfSize:16];
	titleView.shadowColor = [UIColor colorWithWhite:1.0 alpha:1.0];
	titleView.shadowOffset = CGSizeMake(0.0f, 1.0f);
	titleView.textColor = [UIColor whiteColor];
	titleView.text = @"Home";
	self.navigationItem.titleView = titleView;
	[titleView sizeToFit];
	
	
	UIColor *twitterBlue = [UIColor colorWithRed:(85/255.0) green:(172/255.0) blue:(238/255.0) alpha:1] ;
	self.navigationController.navigationBar.barTintColor = twitterBlue;
	self.navigationController.navigationBar.translucent = NO;
	self.navigationItem.leftBarButtonItem.tintColor = [UIColor whiteColor];
	self.navigationItem.rightBarButtonItem.tintColor = [UIColor whiteColor];
	

	
	[self.tableView reloadData];
}

- (void)refreshTableData{
	[[TwitterClient sharedInstance] homeTimeLineWithParams:nil completion:^(NSArray *tweets, NSError *error) {
		for (Tweet *tweet in tweets){
			NSLog(@"text: %@", tweet.text);
		}
		self.tweets = tweets;
		[self.tableView reloadData];
	}];

}

- (void)refresh:(UIRefreshControl *)refreshControl
{
	[self refreshTableData]; //call method
	[refreshControl endRefreshing];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
	static NSString *CellIdentifier = @"TweetCell";
		TweetTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TweetCell"];
	if (!cell) {
		cell = [[TweetTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"TweetCell"];
	}
	
	Tweet *tweet = self.tweets[indexPath.row];
	cell.TweetTextLabel.text = tweet.text;
	cell.userNameLabel.text = tweet.user.name;
	NSString *userHandle = [NSString stringWithFormat:@"@%@",(tweet.user.screename)];
	cell.userHandleLabel.text = userHandle;
	NSURL *profileImageUrl = [[NSURL alloc] initWithString:tweet.user.profileImageUrl];
	[cell.profileImageView setImageWithURL:profileImageUrl];
	
	NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
	[dateFormatter setDateFormat:@"dd/MM/yyyy"];
	NSString *convertedString = [dateFormatter stringFromDate:tweet.createdAt];
	
	cell.dateTimeLabel.text = convertedString;
	//cell.delegate = self;
	
	
	//Click profile picture
	ProfileButton *showProfileButton = [[ProfileButton alloc] initWithFrame:cell.profileImageView.frame];
	showProfileButton.user = tweet.user;
	[showProfileButton addTarget:self action:@selector(showProfile:) forControlEvents:UIControlEventAllTouchEvents];
	[cell addSubview:showProfileButton];
	
	
	
	return cell;
}

- (void)showProfile:(id)sender {
	ProfileButton *buttonClicked = (ProfileButton *)sender;
	ProfileViewController *vc = [[ProfileViewController alloc] init];
	[vc setUser:buttonClicked.user];
	UINavigationController *nvc = [[UINavigationController alloc] initWithRootViewController:vc];
	[self presentViewController:nvc animated:YES completion:nil];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return [self.tweets count];
}

- (void)onNew{
	ComposeViewController *vc = [[ComposeViewController alloc] init];
	UINavigationController *nvc = [[UINavigationController alloc] initWithRootViewController:vc];
	[self presentViewController:nvc animated:YES completion:nil];
}

- (void)onLogout {
	[User logout];
}

// This method is run when the user taps the row in the tableview
-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	IndividualTweetViewController *vc = [[IndividualTweetViewController alloc] init];

	UINavigationController *nvc = [[UINavigationController alloc] initWithRootViewController:vc];
	[self presentViewController:nvc animated:YES completion:nil];
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
	[vc setTweet:self.tweets[indexPath.row]];
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
