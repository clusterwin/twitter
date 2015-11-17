//
//  ProfileViewController.h
//  Twitter
//
//  Created by Alex Lester on 11/14/15.
//  Copyright © 2015 Alex Lester. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"

@interface ProfileViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *profileImage;
@property (weak, nonatomic) IBOutlet UILabel *tweetsTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *followingTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *followersTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *tweetsCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *followingCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *followersCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *userHandleLabel;

@property (strong, nonatomic) User* user;

@end
