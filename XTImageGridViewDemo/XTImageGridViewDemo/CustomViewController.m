//
//  CustomViewController.m
//  XTImageGridViewDemo
//
//  Created by Ronnie Chen on 2016/10/24.
//  Copyright © 2016年 Ronnie Chen. All rights reserved.
//

#import "CustomViewController.h"
#import "XTImageGridView.h"

@interface CustomViewController ()<XTImageGridViewDelegate>
@property (nonatomic,strong) XTImageGridView *gridView;
@end

@implementation CustomViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
	self.title = @"XTImageGridViewStyleCustom";
	self.view.backgroundColor = [UIColor whiteColor];
	
	self.gridView = [[XTImageGridView alloc] init];
	_gridView.frame = CGRectMake(0, 0, XTScreenSize.width, 300);
	_gridView.gridViewStyle = XTImageGridViewStyleCustom;
	_gridView.gridViewDelegate = self;
	_gridView.showAddBtn = NO;
	_gridView.showDeleteBtn = NO;
	
	_gridView.edgeInsets = UIEdgeInsetsMake(40, 0, 0, 0);
	_gridView.gapOfTwoViewInCol = 0;
	
	[self.view addSubview:_gridView];
	
	/*** ***/
	_gridView.maxNumInRow = 10;
	_gridView.numOfImageViews = 10;
	
	int rateCount = 10;
	if (rateCount > 3) {
		rateCount = 3;
	}
	_gridView.singleViewSize = CGSizeMake(XTScreenSize.width/rateCount, 140);
	
	[_gridView reloadData];
	
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
-(void)customViewAtIndex:(int)index CurrentView:(UIView *)curView InGridView:(XTImageGridView *)gridView
{
	//	curView.layer.borderColor = [UIColor redColor].CGColor;
	//	curView.layer.borderWidth = 2.0;
	
	CGFloat headViewWidth = 44.0;
	CGFloat headViewHeight = 44.0;
	CGFloat headViewX = (curView.bounds.size.width-headViewWidth)*0.5;
	CGFloat headViewY = (curView.bounds.size.height-headViewHeight)*0.5-10;
	UIImageView *headView = [[UIImageView alloc] initWithFrame:CGRectMake(headViewX, headViewY, 44, 44)];
	//	headView.backgroundColor = [UIColor redColor];
	headView.layer.cornerRadius = headViewWidth*0.5;
	headView.layer.borderWidth = 5.0;
	headView.layer.borderColor = [UIColor whiteColor].CGColor;
	headView.clipsToBounds = YES;
	[curView addSubview:headView];
	
	UIView *headViewLayer = [[UIView alloc] initWithFrame:CGRectMake(headViewX, headViewY, 44, 44)];
	headViewLayer.backgroundColor = [UIColor clearColor];
	headViewLayer.layer.borderColor = [UIColor colorWithRed:82/255.0 green:145/255.0 blue:24/255.0 alpha:1.0].CGColor;
	headViewLayer.layer.cornerRadius = headViewWidth*0.5;
	headViewLayer.layer.borderWidth = 1.0;
	headViewLayer.clipsToBounds = YES;
	[curView addSubview:headViewLayer];
	
	UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, headViewY-20, curView.bounds.size.width, 20)];
	nameLabel.text = @"Lily";
	nameLabel.font = [UIFont systemFontOfSize:13.0];
	nameLabel.textColor = [UIColor colorWithRed:31/255.0 green:31/255.0 blue:31/255.0 alpha:1.0];
	nameLabel.textAlignment = NSTextAlignmentCenter;
	[curView addSubview:nameLabel];
	
	UILabel *statusLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(headView.frame)+2, curView.bounds.size.width, 20)];
	statusLabel.text = @"Agree";
	statusLabel.font = [UIFont systemFontOfSize:13.0];
	statusLabel.textColor = [UIColor colorWithRed:31/255.0 green:31/255.0 blue:31/255.0 alpha:1.0];
	statusLabel.textAlignment = NSTextAlignmentCenter;
	[curView addSubview:statusLabel];
	
	UILabel *timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(statusLabel.frame), curView.bounds.size.width, 20)];
	timeLabel.text = @"2016.07.08";
	timeLabel.font = [UIFont systemFontOfSize:13.0];
	timeLabel.textColor = [UIColor colorWithRed:111/255.0 green:111/255.0 blue:111/255.0 alpha:1.0];
	timeLabel.textAlignment = NSTextAlignmentCenter;
	[curView addSubview:timeLabel];
	
	if (index != gridView.numOfImageViews-1) {
		
		UIView *lineView1 = [[UIView alloc] initWithFrame:CGRectMake(curView.bounds.size.width-12.5, CGRectGetMidY(headView.frame)-1, 12.5, 2.0)];
		lineView1.backgroundColor = [UIColor colorWithRed:212/255.0 green:212/255.0 blue:212/255.0 alpha:1.0];
		[curView addSubview:lineView1];
	}
	
	if (index != 0) {
		
		UIView *lineView2 = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMidY(headView.frame)-1, 12.5, 2.0)];
		lineView2.backgroundColor = [UIColor colorWithRed:212/255.0 green:212/255.0 blue:212/255.0 alpha:1.0];
		[curView addSubview:lineView2];
	}
	
	
}

@end
