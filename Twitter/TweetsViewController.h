//
//  TweetsViewController.h
//  Twitter
//
//  Created by Alex Lester on 11/9/15.
//  Copyright © 2015 Alex Lester. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TweetsViewController;

@protocol TweetsViewController <NSObject>

@end

@interface TweetsViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITableView *tableView;



@end
