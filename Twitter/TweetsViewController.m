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


@interface TweetsViewController ()

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
