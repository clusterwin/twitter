//
//  IndividualTweetViewController.h
//  Twitter
//
//  Created by Alex Lester on 11/10/15.
//  Copyright © 2015 Alex Lester. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Tweet.h"

@interface IndividualTweetViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *tweeterImageView;
@property (weak, nonatomic) IBOutlet UILabel *tweeterNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *tweeterHandelLabel;
@property (weak, nonatomic) IBOutlet UILabel *tweetContentLabel;
@property (weak, nonatomic) IBOutlet UIImageView *tweetReplyLabel;
@property (weak, nonatomic) IBOutlet UIImageView *tweetRetweetLabel;
@property (weak, nonatomic) IBOutlet UIImageView *tweetHeartLabel;


- (void)setTweet:(Tweet *)tweet;

@end
