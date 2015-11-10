//
//  ComposeViewController.m
//  Twitter
//
//  Created by Alex Lester on 11/10/15.
//  Copyright © 2015 Alex Lester. All rights reserved.
//

#import "ComposeViewController.h"
#import "UIImageView+AFNetworking.h"
#import "User.h"
#import "IndividualTweetViewController.h"

@interface ComposeViewController ()

@end

@implementation ComposeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
	self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStylePlain target:self action:@selector(onCancel)];
	self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Send" style:UIBarButtonItemStylePlain target:self action:@selector(onSend)];
	
	
	UIColor *twitterBlue = [UIColor colorWithRed:(85/255.0) green:(172/255.0) blue:(238/255.0) alpha:1] ;
	self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
	self.navigationController.navigationBar.translucent = NO;
	self.navigationItem.leftBarButtonItem.tintColor = twitterBlue;
	self.navigationItem.rightBarButtonItem.tintColor = twitterBlue;
	
	User *sender = [User currentUser];
	self.userNameLable.text = sender.name;
	self.userHandleLabel.text = [NSString stringWithFormat:@"@%@", (sender.screename)];
	NSURL *profileImageUrl = [[NSURL alloc] initWithString:sender.profileImageUrl];
	[self.profileImageView setImageWithURL:profileImageUrl];

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

- (void)onCancel{
		[self dismissViewControllerAnimated:YES completion:nil];
}

- (void)onSend{
		[self dismissViewControllerAnimated:YES completion:nil];
}

@end
