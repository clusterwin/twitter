//
//  TweetTableViewCell.m
//  Twitter
//
//  Created by Alex Lester on 11/10/15.
//  Copyright © 2015 Alex Lester. All rights reserved.
//

#import "TweetTableViewCell.h"

@implementation TweetTableViewCell

- (void)awakeFromNib {
    // Initialization code
	self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
	self.TweetTextLabel.preferredMaxLayoutWidth = self.TweetTextLabel.frame.size.width;
}

@end
