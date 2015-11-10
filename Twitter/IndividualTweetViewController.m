//
//  IndividualTweetViewController.m
//  Twitter
//
//  Created by Alex Lester on 11/10/15.
//  Copyright © 2015 Alex Lester. All rights reserved.
//

#import "IndividualTweetViewController.h"
#import "UIImageView+AFNetworking.h"

@interface IndividualTweetViewController ()

@property (strong, nonatomic) Tweet *tweet;

@end

@implementation IndividualTweetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
	self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Home" style:UIBarButtonItemStylePlain target:self action:@selector(onHome)];
	self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Reply" style:UIBarButtonItemStylePlain target:self action:@selector(onReply)];
	
	
	UIColor *twitterBlue = [UIColor colorWithRed:(85/255.0) green:(172/255.0) blue:(238/255.0) alpha:1] ;
	self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
	self.navigationController.navigationBar.translucent = NO;
	self.navigationItem.leftBarButtonItem.tintColor = twitterBlue;
	self.navigationItem.rightBarButtonItem.tintColor = twitterBlue;
	
	self.tweetContentLabel.text = self.tweet.text;
	self.tweeterNameLabel.text = self.tweet.user.name;
	NSString *userHandle = [NSString stringWithFormat:@"@%@",(self.tweet.user.screename)];
	self.tweeterHandelLabel.text = userHandle;
	NSURL *profileImageUrl = [[NSURL alloc] initWithString:self.tweet.user.profileImageUrl];
	[self.tweeterImageView setImageWithURL:profileImageUrl];
	
	NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
	[dateFormatter setDateFormat:@"dd/MM/yyyy"];

}

- (void)onHome{
	[self dismissViewControllerAnimated:YES completion:nil];
}

- (void)onReply{
	[self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setTweet:(Tweet *)tweet{
	_tweet = tweet;
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
