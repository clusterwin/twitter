//
//  ProfileViewController.m
//  Twitter
//
//  Created by Alex Lester on 11/14/15.
//  Copyright © 2015 Alex Lester. All rights reserved.
//

#import "ProfileViewController.h"
#import "User.h"
#import "UIImageView+AFNetworking.h"

@interface ProfileViewController ()
@property (weak, nonatomic) IBOutlet UIView *profileView;

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
	User *sender = [User currentUser];
	if(self.user){
		sender = self.user;
	}
	self.userNameLabel.text = sender.name;
	self.userHandleLabel.text = [NSString stringWithFormat:@"@%@", (sender.screename)];
	NSURL *profileImageUrl = [[NSURL alloc] initWithString:sender.profileImageUrl];
	[self.profileImage setImageWithURL:profileImageUrl];
	self.followersCountLabel.text = sender.followersCount;
	self.followingCountLabel.text = sender.followingCount;
	self.tweetsCountLabel.text = sender.tweetsCount;
	
	UILabel * titleView = [[UILabel alloc] initWithFrame:CGRectZero];
	titleView.backgroundColor = [UIColor clearColor];
	titleView.font = [UIFont boldSystemFontOfSize:16];
	titleView.shadowColor = [UIColor colorWithWhite:1.0 alpha:1.0];
	titleView.shadowOffset = CGSizeMake(0.0f, 1.0f);
	titleView.textColor = [UIColor whiteColor];
	titleView.text = @"Profile";
	self.navigationItem.titleView = titleView;
	[titleView sizeToFit];
	
	
	UIColor *twitterBlue = [UIColor colorWithRed:(85/255.0) green:(172/255.0) blue:(238/255.0) alpha:1] ;
	self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStylePlain target:self action:@selector(onCancel)];
	self.navigationController.navigationBar.barTintColor = twitterBlue;
	self.navigationItem.leftBarButtonItem.tintColor = [UIColor whiteColor];
	self.navigationController.navigationBar.translucent = NO;
	
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)onCancel{
	[self dismissViewControllerAnimated:YES completion:nil];
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
