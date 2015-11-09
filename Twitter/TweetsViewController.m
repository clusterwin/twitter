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


@interface TweetsViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tweetTableVIew;
@end

@implementation TweetsViewController

- (IBAction)onLogout:(id)sender {
	[User logout];
	
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
	[[TwitterClient sharedInstance] homeTimeLineWithParams:nil completion:^(NSArray *tweets, NSError *error) {
		for (Tweet *tweet in tweets){
			NSLog(@"text: %@", tweet.text);
		}
	}];
	
	self.tableView.delegate = self;
	self.tableView.dataSource = self;
	
		[self.tableView registerNib:[UINib nibWithNibName:@"TweetTableViewCell" bundle:nil] forCellReuseIdentifier:@"TweetCell"];
	
	[self.tableView reloadData];
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
		cell.TweetTextLabel.text = @"Hi I'm a tweet";
		//cell.delegate = self;
		return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return 100;
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
