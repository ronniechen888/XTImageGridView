//
//  XTGridView.m
//
//  Created by Ronnie Chen on 2016/9/19.
//  Copyright © 2016年 Ronnie. All rights reserved.
//

#import "XTImageGridView.h"
#import "UIImageView+WebCache.h"

#define DEFAULT_NUMBER_OF_IMAGE_VIEWS 0
#define DEFAULT_GAP_BETWEEN_TWO_VIEWS 10
#define DEFAULT_MAX_NUM_IN_ROW 4
#define DEFAULT_SINGLE_VIEW_SIZE CGSizeMake(60.0, 60.0)
#define DEFAULT_EDGE_INSETS UIEdgeInsetsMake(45, 20, 20, 20)

#define TAG_DELETE_BUTTON 100

@interface XTImageGridView ()

@property (nonatomic,weak) UIButton *addBtn;
@property (nonatomic,strong) NSMutableArray *viewArray;
@property (nonatomic,assign) int numOfCols;

@end

@implementation XTImageGridView

-(instancetype)initWithFrame:(CGRect)frame
{
	self = [super initWithFrame:frame];
	
	if (self) {
		self.backgroundColor = [UIColor clearColor];
		self.showAddBtn = YES;
		self.showDeleteBtn = YES;
		self.showShakeAnimationWhenShowDeleteBtn = YES;
		self.gridViewStyle = XTImageGridViewStyleDefault;
		self.numOfImageViews = DEFAULT_NUMBER_OF_IMAGE_VIEWS;
		self.maxNumInRow = DEFAULT_MAX_NUM_IN_ROW;
		self.gapOfTwoViewInCol = DEFAULT_GAP_BETWEEN_TWO_VIEWS;
		self.gapOfTwoViewInRow = DEFAULT_GAP_BETWEEN_TWO_VIEWS;
		self.singleViewSize = DEFAULT_SINGLE_VIEW_SIZE;
		self.edgeInsets = DEFAULT_EDGE_INSETS;
		
		UIButton *lastBtn = [UIButton buttonWithType:UIButtonTypeCustom];
		lastBtn.backgroundColor = [UIColor clearColor];
		[lastBtn addTarget:self action:@selector(addButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
		[self addSubview:lastBtn];
		self.addBtn = lastBtn;
		
		self.viewArray = [[NSMutableArray alloc] init];
		
		[self reloadViews];
	}
	
	return self;
}

-(void)layoutSubviews
{
	[super layoutSubviews];
	if (self.frame.size.width < self.singleViewSize.width+_edgeInsets.left+_edgeInsets.right) {
		NSLog(@"Frame Width is Not Enough!");
	}
	if (self.frame.size.height < self.singleViewSize.height+_edgeInsets.top+_edgeInsets.bottom) {
		NSLog(@"Frame Height is Not Enough!");
	}
	
}


-(void)reloadViews
{
	for (UIView *curView in self.viewArray) {
		for (UIView *subView in [curView subviews]) {
			[subView removeFromSuperview];
		}
		[curView removeFromSuperview];
	}
	[self.viewArray removeAllObjects];
	
	int numOfViews = _numOfImageViews+1;
	
	self.numOfCols = _maxNumInRow;
	
	[self adjustScrollViewContentSize];

	for (int i = 0; i < numOfViews; i++) {
		int rowIndex = i/_numOfCols;
		int colIndex = i%_numOfCols;
		
		if (i == self.numOfImageViews) {
			_addBtn.frame = CGRectMake(_edgeInsets.left+colIndex*(_gapOfTwoViewInCol+_singleViewSize.width), _edgeInsets.top+rowIndex*(_gapOfTwoViewInRow+_singleViewSize.height), _singleViewSize.width, _singleViewSize.height); 
			UIImageView *addImage = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, _addBtn.frame.size.width-10, _addBtn.frame.size.height-10)];
			addImage.layer.cornerRadius = 5.0;
			addImage.layer.borderWidth = 0.5;
			addImage.layer.borderColor = [UIColor colorWithRed:247/255.0 green:247/255.0 blue:247/255.0 alpha:1.0].CGColor;
			addImage.clipsToBounds = YES;
			addImage.image = [UIImage imageNamed:@"add_attach"];
			
			[_addBtn addSubview:addImage];
		}else
		{
			UIView *singleView = [[UIView alloc] initWithFrame:CGRectMake(_edgeInsets.left+colIndex*(_gapOfTwoViewInCol+_singleViewSize.width), _edgeInsets.top+rowIndex*(_gapOfTwoViewInRow+_singleViewSize.height), _singleViewSize.width, _singleViewSize.height)];
			singleView.backgroundColor = [UIColor clearColor];
			[self addSubview:singleView];
			
			[self.viewArray addObject:singleView];
			
			[self configureSingleViewAtIndex:i];
		}
		
	}
}



#pragma mark - ADD && REMOVE

-(void)addOneMoreView
{
	UIView *singleView = [[UIView alloc] initWithFrame:self.addBtn.frame];
	[self addSubview:singleView];
	
	self.numOfImageViews++;
	[self.viewArray addObject:singleView];
	
	[self configureSingleViewAtIndex:_numOfImageViews-1];
	
	{
	
		int addBtnRowIndex = _numOfImageViews/_numOfCols;
		int addBtnColIndex = _numOfImageViews%_numOfCols;
		
		[UIView animateWithDuration:0.2 animations:^{
			
			[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
			
			[self adjustScrollViewContentSize];
			
			_addBtn.frame = CGRectMake(_edgeInsets.left+addBtnColIndex*(_gapOfTwoViewInCol+_singleViewSize.width), _edgeInsets.top+addBtnRowIndex*(_gapOfTwoViewInRow+_singleViewSize.height), _singleViewSize.width, _singleViewSize.height);
			
		}completion:^(BOOL finished) {
			
		}];
	}
	 
}

-(void)addMoreViews:(NSInteger)viewCount
{
	int beforeViewNum = _numOfImageViews;
	_numOfImageViews += viewCount;
	
	
	for (int i = beforeViewNum; i < _numOfImageViews+1; i++) {
		int rowIndex = i/_numOfCols;
		int colIndex = i%_numOfCols;
		
		if (i == self.numOfImageViews) {
			[UIView animateWithDuration:0.2 animations:^{
				
				[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
				
				[self adjustScrollViewContentSize];
				
				_addBtn.frame = CGRectMake(_edgeInsets.left+colIndex*(_gapOfTwoViewInCol+_singleViewSize.width), _edgeInsets.top+rowIndex*(_gapOfTwoViewInRow+_singleViewSize.height), _singleViewSize.width, _singleViewSize.height); 
				
			}completion:^(BOOL finished) {
				
			}];
			
		}else
		{
			UIView *singleView = [[UIView alloc] initWithFrame:CGRectMake(_edgeInsets.left+colIndex*(_gapOfTwoViewInCol+_singleViewSize.width), _edgeInsets.top+rowIndex*(_gapOfTwoViewInRow+_singleViewSize.height), _singleViewSize.width, _singleViewSize.height)];
			singleView.backgroundColor = [UIColor clearColor];
			[self addSubview:singleView];
			
			[self.viewArray addObject:singleView];
			
			[self configureSingleViewAtIndex:i];
		}

	}
	
}

-(void)removeViewAtIndex:(int)index
{
	UIView *deleteView = [self.viewArray objectAtIndex:index];
	
	UIView *lastView = [self.viewArray lastObject];
	[UIView animateWithDuration:0.2 animations:^{
		
		[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
		
		_addBtn.frame = lastView.frame;
		
	}completion:^(BOOL finished) {
		
	}];
	
	
	for (int i = _numOfImageViews-1; i > index; i--) {
		UIView *curView = [self.viewArray objectAtIndex:i];
		UIView *beforeView = [self.viewArray objectAtIndex:i-1];
		
		curView.frame = beforeView.frame;
		
	}
	
	[self.viewArray removeObject:deleteView];
	[deleteView removeFromSuperview];
	
	_numOfImageViews--;

	[self adjustScrollViewContentSize];
}

-(void)adjustScrollViewContentSize
{
	if (_maxNumInRow == 0) {
		return;
	}
	int numOfViews;
	if (_showAddBtn) {
		numOfViews = _numOfImageViews+1;
	}else
	{
		numOfViews = _numOfImageViews;
	}
	
	int numOfRows = numOfViews < _maxNumInRow ? 1 : (numOfViews%_maxNumInRow == 0 ? numOfViews/_maxNumInRow : (numOfViews/_maxNumInRow)+1);
	
	self.contentSize = CGSizeMake(_numOfCols*_singleViewSize.width+(_numOfCols-1)*_gapOfTwoViewInCol+_edgeInsets.left+_edgeInsets.right, numOfRows*_singleViewSize.height+(numOfRows-1)*_gapOfTwoViewInRow+_edgeInsets.top+_edgeInsets.bottom);
}

#pragma mark - EVENT

-(void)addButtonClicked:(id)sender
{
	for (UIView *view in _viewArray) {
		UIButton *deleteBtn = (UIButton *)[view viewWithTag:TAG_DELETE_BUTTON];
		if (_showDeleteBtn) {
			if (_showShakeAnimationWhenShowDeleteBtn) {
				deleteBtn.hidden = YES;
			}else
			{
				deleteBtn.hidden = NO;
				[view bringSubviewToFront:deleteBtn];
			}
		}else
		{
			deleteBtn.hidden = YES;
		}
		
		[view.layer removeAllAnimations];
	}
	
	if(self.gridViewDelegate && [self.gridViewDelegate respondsToSelector:@selector(addBtnClickedInGridView:)])
	{
		[self.gridViewDelegate addBtnClickedInGridView:self];
	}
}

-(void)deleteBtnClicked:(id)sender
{
	NSInteger index = [_viewArray indexOfObject:[(UIButton *)sender superview]];
	NSLog(@"%ld",index);
	[self removeViewAtIndex:(int)index];
	
	if(self.gridViewDelegate && [self.gridViewDelegate respondsToSelector:@selector(deleteBtnClickedAtIndex:InGridView:)])
	{
		[self.gridViewDelegate deleteBtnClickedAtIndex:(int)index InGridView:self];
	}
}

-(void)longPress:(UILongPressGestureRecognizer *)recognizer
{
	if (!_showDeleteBtn || !_showShakeAnimationWhenShowDeleteBtn) {
		return;
	}
	
	
	for (UIView *view in _viewArray) {
		UIButton *deleteBtn = (UIButton *)[view viewWithTag:TAG_DELETE_BUTTON];
		deleteBtn.hidden = NO;
		[view bringSubviewToFront:deleteBtn];
		
		CABasicAnimation *animation = (CABasicAnimation *)[view.layer animationForKey:@"rotation"];
		if (animation == nil) {
			[self shakeView:view];
		}else {
			[self resume:view];
		}
	}
}

-(void)shortTap:(UITapGestureRecognizer *)recognizer
{
	for (UIView *view in _viewArray) {
		UIButton *deleteBtn = (UIButton *)[view viewWithTag:TAG_DELETE_BUTTON];
		if (_showDeleteBtn) {
			if (_showShakeAnimationWhenShowDeleteBtn) {
				deleteBtn.hidden = YES;
			}else
			{
				deleteBtn.hidden = NO;
				[view bringSubviewToFront:deleteBtn];
			}
		}else
		{
			deleteBtn.hidden = YES;
		}
		
//		[self pause:view];
		[view.layer removeAllAnimations];
	}
	
	if(self.gridViewDelegate && [self.gridViewDelegate respondsToSelector:@selector(viewClickedAtindex:InGridView:)])
	{
		int index = (int)[self.viewArray indexOfObject:recognizer.view];
		[self.gridViewDelegate viewClickedAtindex:index InGridView:self];
	}
}

#pragma mark - Shake Animation
- (void)pause:(UIView *)sender {
	sender.layer.speed = 0.0;
}

- (void)resume:(UIView *)sender {
	sender.layer.speed = 1.0;
}

- (void)shakeView:(UIView *)sender {
	//创建动画对象,绕Z轴旋转
	CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
	
	//设置属性，周期时长
	[animation setDuration:0.08];
	
	//抖动角度
	animation.fromValue = @(-M_1_PI/4);
	animation.toValue = @(M_1_PI/4);
	//重复次数，无限大
	animation.repeatCount = HUGE_VAL;
	//恢复原样
	animation.autoreverses = YES;
	//锚点设置为图片中心，绕中心抖动
	sender.layer.anchorPoint = CGPointMake(0.5, 0.5);
	
	[sender.layer addAnimation:animation forKey:@"rotation"];
}

#pragma mark - CUSTOME SINGLE VIEW

-(void)configureSingleViewAtIndex:(int)index
{
	UIView *curView = [_viewArray objectAtIndex:index];
	if(self.gridViewStyle == XTImageGridViewStyleDefault)
	{
		
		UIImageView *iconView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, _singleViewSize.width-10, _singleViewSize.height-10)];
		iconView.layer.cornerRadius = 5.0;
		iconView.clipsToBounds = YES;
		iconView.backgroundColor = [UIColor colorWithRed:254/255.0 green:212/255.0 blue:91/255.0 alpha:1.0];
		[curView addSubview:iconView];
		
		if (self.gridViewDelegate && [self.gridViewDelegate respondsToSelector:@selector(imageSourcesAtIndex:InGridView:)]) {
			NSDictionary *sourceDic = [self.gridViewDelegate imageSourcesAtIndex:index InGridView:self];
			if ([[sourceDic objectForKey:@"isURL"] boolValue]) {
				[iconView sd_setImageWithURL:[NSURL URLWithString:[sourceDic objectForKey:@"name"]] placeholderImage:[UIImage imageNamed:@""]];
			}else
			{
				iconView.image = [sourceDic objectForKey:@"name"];
			}
		}
		
		UIButton *deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
		deleteBtn.tag = TAG_DELETE_BUTTON;
		deleteBtn.frame = CGRectMake(_singleViewSize.width-20, 0, 20, 20);
		[deleteBtn setBackgroundImage:[UIImage imageNamed:@"delete_image"] forState:UIControlStateNormal];
		[deleteBtn addTarget:self action:@selector(deleteBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
		[curView addSubview:deleteBtn];
		
		if (_showDeleteBtn) {
			if (_showShakeAnimationWhenShowDeleteBtn) {
				deleteBtn.hidden = YES;
			}else
			{
				deleteBtn.hidden = NO;
			  [curView bringSubviewToFront:deleteBtn];
			}
		}else
		{
			deleteBtn.hidden = YES;
		}
		
		//添加长按手势
		UILongPressGestureRecognizer *longRecognize = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPress:)];
		//长按响应时间
		longRecognize.minimumPressDuration = 1;
		[curView addGestureRecognizer:longRecognize];
		
		UITapGestureRecognizer *shortRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(shortTap:)];
		[curView addGestureRecognizer:shortRecognizer];
	}else
	{
		if (self.gridViewDelegate && [self.gridViewDelegate respondsToSelector:@selector(customViewAtIndex:CurrentView:InGridView:)]) {
			[self.gridViewDelegate customViewAtIndex:index CurrentView:curView InGridView:self];
		}
	}
	
	
}

#pragma mark - Property Values
-(void)setShowAddBtn:(BOOL)showAddBtn
{
	_showAddBtn = showAddBtn;
	self.addBtn.hidden = !_showAddBtn;
	
	[self adjustScrollViewContentSize];
}

-(void)setShowDeleteBtn:(BOOL)showDeleteBtn
{
	_showDeleteBtn = showDeleteBtn;
	for (UIView *view in _viewArray) {
		UIButton *deleteBtn = (UIButton *)[view viewWithTag:TAG_DELETE_BUTTON];
		if (_showDeleteBtn) {
			if (_showShakeAnimationWhenShowDeleteBtn) {
				deleteBtn.hidden = YES;
			}else
			{
				deleteBtn.hidden = NO;
				[view bringSubviewToFront:deleteBtn];
			}
		}else
		{
			deleteBtn.hidden = YES;
		}
		
		[view.layer removeAllAnimations];
	}
}

-(void)setShowShakeAnimationWhenShowDeleteBtn:(BOOL)showShakeAnimationWhenShowDeleteBtn
{
	_showShakeAnimationWhenShowDeleteBtn = showShakeAnimationWhenShowDeleteBtn;
}

-(void)setNumOfImageViews:(int)numOfImageViews
{
	_numOfImageViews = numOfImageViews;
	
}

-(void)setMaxNumInRow:(int)maxNumInRow
{
	_maxNumInRow = maxNumInRow;
	

}

-(void)setGapOfTwoViewInCol:(CGFloat)gapOfTwoViewInCol
{
	_gapOfTwoViewInCol = gapOfTwoViewInCol;
	

}

-(void)setGapOfTwoViewInRow:(CGFloat)gapOfTwoViewInRow
{
	_gapOfTwoViewInRow = gapOfTwoViewInRow;
	
}

-(void)setSingleViewSize:(CGSize)singleViewSize
{
	_singleViewSize = singleViewSize;
	
}

-(void)setEdgeInsets:(UIEdgeInsets)edgeInsets
{
	
	_edgeInsets = edgeInsets;

}

-(void)reloadData
{
	[self reloadViews];
}
@end
