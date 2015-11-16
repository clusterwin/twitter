//
//  HamburgerViewController.m
//  Twitter
//
//  Created by Alex Lester on 11/15/15.
//  Copyright © 2015 Alex Lester. All rights reserved.
//

#import "HamburgerViewController.h"

@interface HamburgerViewController ()
@property (weak, nonatomic) IBOutlet UIView *menuView;
@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leftMarginConstraint;
@property (assign, nonatomic) CGFloat originalLeftMargin;


@end

@implementation HamburgerViewController

- (void)setView:(UIView *)view {
	[view layoutIfNeeded];
	[_menuView addSubview:self.menuViewController.view];
}
- (IBAction)onPanGesture:(UIPanGestureRecognizer *)sender {
	CGPoint translation = [sender translationInView: self.view];
	CGPoint velocity = [sender velocityInView:self.view];
	
	if ([sender state] == UIGestureRecognizerStateBegan) {
		self.originalLeftMargin = _leftMarginConstraint.constant;
	} else if( [sender state] == UIGestureRecognizerStateChanged) {
		self.leftMarginConstraint.constant = self.originalLeftMargin + translation.x;
	} else if ([sender state] == UIGestureRecognizerStateEnded) {
		if(velocity.x > 0){
			self.leftMarginConstraint.constant = self.view.frame.size.width -50;
		} else {
			self.leftMarginConstraint.constant = 0;
		}
		[self.view layoutIfNeeded];
	}
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
