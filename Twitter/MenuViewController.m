//
//  MenuViewController.m
//  Twitter
//
//  Created by Alex Lester on 11/16/15.
//  Copyright © 2015 Alex Lester. All rights reserved.
//

#import "MenuViewController.h"


@interface MenuViewController () <UITableViewDataSource, UITableViewDelegate>
@property UIViewController *greenNavigationController;
@property UIViewController *blueNavigationController;
@property UIViewController *pinkNavigationController;
@property NSMutableArray *viewControllers;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation MenuViewController



- (void)viewDidLoad {
	[super viewDidLoad];
	self.tableView.dataSource = self;
	self.tableView.delegate = self;
	// Do any additional setup after loading the view.
	UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
	self.greenNavigationController = [storyboard instantiateViewControllerWithIdentifier:@"GreenViewController"];
	self.blueNavigationController = [storyboard instantiateViewControllerWithIdentifier:@"BlueViewController"];
	self.pinkNavigationController = [storyboard instantiateViewControllerWithIdentifier:@"PinkViewController"];
	
	self.viewControllers = [[NSMutableArray alloc] init];
	[self.viewControllers addObject:self.greenNavigationController];
	[self.viewControllers addObject:self.blueNavigationController];
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
	NSArray *titles = @[@"Green", @"Blue", @"Pink"];
	cell.textLabel.text = titles[indexPath.row];
	return cell;
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
