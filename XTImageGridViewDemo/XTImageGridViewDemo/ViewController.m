//
//  ViewController.m
//  XTImageGridViewDemo
//
//  Created by Ronnie Chen on 2016/10/24.
//  Copyright © 2016年 Ronnie Chen. All rights reserved.
//

#import "ViewController.h"
#import "DefaultViewController.h"
#import "CustomViewController.h"

@interface ViewController ()
@property (nonatomic,strong) NSArray *titles;
@end

@implementation ViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
	self.title = NSLocalizedString(@"XTImageGridViewDemo", nil);
	
	self.titles = @[@"XTImageGridViewStyleDefault",@"XTImageGridViewStyleCustom"];
	
	self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
}


- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

#pragma mark - Table View
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return 2;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
	if (!cell) {
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
	}
	cell.textLabel.text = [_titles objectAtIndex:indexPath.row];
	return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
	
	if (indexPath.row == 0) {
		DefaultViewController *defaultController = [[DefaultViewController alloc] init];
		[self.navigationController pushViewController:defaultController animated:YES];
	}else
	{
		CustomViewController *customController = [[CustomViewController alloc] init];
		[self.navigationController pushViewController:customController animated:YES];
	}
	
}
@end
