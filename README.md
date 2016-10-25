XTImageGridView
===============

XTImageGridView is a very simple lib for build Grid View in iOS.

##Which scenes can you use this libary?

![Scene1](https://github.com/ronniechen888/XTImageGridView/blob/master/Document/scene1.png)
![Scene2](https://github.com/ronniechen888/XTImageGridView/blob/master/Document/scene2.png)

##Configuration
#####1.Add `XTImageGirdView` `SDWebImage` to your project.
#####2.Add Code `#import "XTImageGirdView.h"`
#####3.Initial Code:
```
self.gridView = [[XTImageGridView alloc] init];
_gridView.frame = CGRectMake(0, 0, XTScreenSize.width, self.view.bounds.size.height);
_gridView.edgeInsets = UIEdgeInsetsMake(45, (XTScreenSize.width-270)*0.5, 5, (XTScreenSize.width-270)*0.5);
_gridView.gridViewDelegate = self;
[self.view addSubview:_gridView];
[self.gridView reloadData];
```
#####4.Refresh Grid View:
```
_gridView.maxNumInRow = 10;
_gridView.numOfImageViews = 10;
[self.gridView reloadData];
```
#####5.Config Single View:
######`XTImageGirdView` has two styles.
One is `XTImageGridViewStyleDefault`,in this style,grid view default has an 
add button at last.You can hide or show it.And the default single view has an image view,and has a delete button.
The default action you want delete view,you should long press on the view,then the delete button will be show and with
shaking animation.Also you can config it to show directly.

![Default](https://github.com/ronniechen888/XTImageGridView/blob/master/Document/gridview.png)

###After long press.

![Animation1](https://github.com/ronniechen888/XTImageGridView/blob/master/Document/gridview_after_long_press1.png)
![Animation2](https://github.com/ronniechen888/XTImageGridView/blob/master/Document/gridview_after_long_press2.png)

###Another style is `XTImageGridViewStyleCustom`,you can customize single view by yourself.

![Default1](https://github.com/ronniechen888/XTImageGridView/blob/master/Document/gridview_custom1.png)
![Default2](https://github.com/ronniechen888/XTImageGridView/blob/master/Document/gridview_custom2.png)
#####`XTImageGridViewStyleDefault` delegate method below can config view:
```
-(NSDictionary *)imageSourcesAtIndex:(int)index InGridView:(XTImageGridView *)gridView
{
	return @{@"name":[_attachArray objectAtIndex:index],@"isURL":@NO};
}
```
     
#####`XTImageGridViewStyleCustom` delegate method below can config view:
```
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
```
#####6.Delegate Methods:
```
/**
 *  clicked add button
 */
-(void)addBtnClickedInGridView:(XTImageGridView *)gridView;
/**
 *  clicked delete button
 */
-(void)deleteBtnClickedAtIndex:(int)index InGridView:(XTImageGridView *)gridView;
/**
 *  clicked grid view
 */
-(void)viewClickedAtindex:(int)index InGridView:(XTImageGridView *)gridView;
```

#####7.Properties:
```
/**
 *  should show or hide add button
 */
@property (nonatomic,assign) BOOL showAddBtn;
/**
 *  should show or hide delete button
 */
@property (nonatomic,assign) BOOL showDeleteBtn;
/**
 *  should use shake animation when show delete button.
 */
@property (nonatomic,assign) BOOL showShakeAnimationWhenShowDeleteBtn;
/**
 *  grid view style
 */
@property (nonatomic,assign) XTImageGridViewStyle gridViewStyle;
/**
 *  grid numbers
 */
@property (nonatomic,assign) int numOfImageViews;
/**
 *  max numbers in one row
 */
@property (nonatomic,assign) int maxNumInRow;
/**
 *  two view's gap in one column
 */
@property (nonatomic,assign) CGFloat gapOfTwoViewInCol;
/**
 *  two view's gap in one row
 */
@property (nonatomic,assign) CGFloat gapOfTwoViewInRow;
/**
 *  grid view's size
 */
@property (nonatomic,assign) CGSize singleViewSize;
/**
 *  left,top,right,bottom margin
 */
@property (nonatomic,assign) UIEdgeInsets edgeInsets;
```
