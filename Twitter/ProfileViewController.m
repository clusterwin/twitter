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
	self.userNameLabel.text = sender.name;
	self.userHandleLabel.text = [NSString stringWithFormat:@"@%@", (sender.screename)];
	NSURL *profileImageUrl = [[NSURL alloc] initWithString:sender.profileImageUrl];
	[self.profileImage setImageWithURL:profileImageUrl];
	self.followersCountLabel.text = sender.followersCount;
	self.followingCountLabel.text = sender.followingCount;
	self.tweetsCountLabel.text = sender.tweetsCount;
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
