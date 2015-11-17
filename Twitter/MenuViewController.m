//
//  MenuViewController.m
//  Twitter
//
//  Created by Alex Lester on 11/16/15.
//  Copyright © 2015 Alex Lester. All rights reserved.
//

#import "MenuViewController.h"
#import "TweetsViewController.h"
#import "ProfileViewController.h"
#import "MentionsViewController.h"


@interface MenuViewController () <UITableViewDataSource, UITableViewDelegate>
@property UINavigationController *tweets;
@property UIViewController *profileViewController;
@property UIViewController *pinkNavigationController;
@property NSMutableArray *viewControllers;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation MenuViewController

- (void) setHamburgerViewController:(HamburgerViewController *)hamburgerViewController {
	_hamburgerViewController = hamburgerViewController;
}


- (void)viewDidLoad {
	[super viewDidLoad];
	self.tableView.dataSource = self;
	self.tableView.delegate = self;
	// Do any additional setup after loading the view.
	UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
	
	TweetsViewController *vc = [[TweetsViewController alloc] init];
	UINavigationController *nvc = [[UINavigationController alloc] initWithRootViewController:vc];
	self.tweets = nvc;
	
	ProfileViewController *pvc = [[ProfileViewController alloc] init];
	UINavigationController *pnvc = [[UINavigationController alloc] initWithRootViewController:pvc];
	self.profileViewController = pnvc;
	
	MentionsViewController *mvc = [[MentionsViewController alloc] init];
		UINavigationController *mnvc = [[UINavigationController alloc] initWithRootViewController:mvc];
	self.pinkNavigationController = mnvc;
	
	self.viewControllers = [[NSMutableArray alloc] init];
	[self.viewControllers addObject:self.tweets];
	[self.viewControllers addObject:self.profileViewController];
	[self.viewControllers addObject:self.pinkNavigationController];
	NSLog(@"View controllers has size = %lu", (unsigned long)[self.viewControllers count]);
	
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return 3;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MenuCell"];
	if(!cell){
		cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MenuCell"];
	}
	NSArray *titles = @[@"Home", @"Profile", @"Mentions"];
	cell.textLabel.text = titles[indexPath.row];
	return cell;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	[tableView deselectRowAtIndexPath:indexPath animated:TRUE];
	[self.hamburgerViewController setContentViewController:_viewControllers[indexPath.row]];
		
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
