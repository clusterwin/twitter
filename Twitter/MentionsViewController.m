//
//  MentionsViewController.m
//  Twitter
//
//  Created by Alex Lester on 11/16/15.
//  Copyright © 2015 Alex Lester. All rights reserved.
//

#import "MentionsViewController.h"
#import "TwitterClient.h"
#import "TweetTableViewCell.h"
#import "Tweet.h"
#import "UIImageView+AFNetworking.h"

@interface MentionsViewController ()<UITableViewDataSource>

@property (strong, nonatomic) NSArray *tweets;

@end

@implementation MentionsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
	
	[[TwitterClient sharedInstance] mentionsWithParams:nil completion:^(NSArray *tweets, NSError *error) {
		self.tweets = tweets;
		[self.tableView reloadData];
	}];
	

	self.tableView.delegate = self;
	self.tableView.dataSource = self;
	self.tableView.estimatedRowHeight = 100;
	self.tableView.rowHeight = UITableViewAutomaticDimension;
	
	[self.tableView registerNib:[UINib nibWithNibName:@"TweetTableViewCell" bundle:nil] forCellReuseIdentifier:@"TweetCell"];
	
	//Nav
	UILabel * titleView = [[UILabel alloc] initWithFrame:CGRectZero];
	titleView.backgroundColor = [UIColor clearColor];
	titleView.font = [UIFont boldSystemFontOfSize:16];
	titleView.shadowColor = [UIColor colorWithWhite:1.0 alpha:1.0];
	titleView.shadowOffset = CGSizeMake(0.0f, 1.0f);
	titleView.textColor = [UIColor whiteColor];
	titleView.text = @"Mentioned";
	self.navigationItem.titleView = titleView;
	[titleView sizeToFit];
	
	
	UIColor *twitterBlue = [UIColor colorWithRed:(85/255.0) green:(172/255.0) blue:(238/255.0) alpha:1] ;
	self.navigationItem.leftBarButtonItem.tintColor = twitterBlue;
	self.navigationController.navigationBar.barTintColor = twitterBlue;
	self.navigationController.navigationBar.translucent = NO;
	
	
	[self.tableView reloadData];
	
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
	static NSString *cellIdentifier = @"TweetCell";
	TweetTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
	if (!cell) {
		cell = [[TweetTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
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
	return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return [self.tweets count];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
