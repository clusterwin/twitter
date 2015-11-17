//
//  HamburgerViewController.h
//  Twitter
//
//  Created by Alex Lester on 11/15/15.
//  Copyright © 2015 Alex Lester. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HamburgerViewController : UIViewController

@property (strong, nonatomic) UIViewController *menuViewController;
@property (strong, nonatomic) UIViewController *contentViewController;

- (void) setMenuViewController:(UIViewController *)menuViewController;
- (void) setContentViewController:(UIViewController *)contentViewController;

@end
