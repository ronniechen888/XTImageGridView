//
//  XTGridView.h
//
//  Created by Ronnie Chen on 2016/9/19.
//  Copyright © 2016年 Ronnie. All rights reserved.
//

#import <UIKit/UIKit.h>

#define XTScreenSize   [UIScreen  mainScreen].bounds.size
#define XTNavgationBarHeight            44
#define XTAPPliacationStateBarHeight    20

@class XTImageGridView;
@protocol XTImageGridViewDelegate <NSObject>

@optional
/**
 *  添加按钮点击时，执行该回调
 */
-(void)addBtnClickedInGridView:(XTImageGridView *)gridView;
/**
 *  删除按钮点击时，执行该回调
 */
-(void)deleteBtnClickedAtIndex:(int)index InGridView:(XTImageGridView *)gridView;
/**
 *  grid区域点击时，执行该回调
 */
-(void)viewClickedAtindex:(int)index InGridView:(XTImageGridView *)gridView;

/**
 *  只有当gridViewStyle = XTImageGridViewStyleCustom时，该委托方法才有效
 */
-(void)customViewAtIndex:(int)index CurrentView:(UIView *)curView InGridView:(XTImageGridView *)gridView;

/**
 *  图片资源
 *
 *  @param index    
 *  @param gridView 
 *
 *  @return @{@"name":UIImage,@"isURL":@YES}
 */
-(NSDictionary *)imageSourcesAtIndex:(int)index InGridView:(XTImageGridView *)gridView;
@end

typedef enum : NSUInteger {
	XTImageGridViewStyleDefault,
	XTImageGridViewStyleCustom,
} XTImageGridViewStyle;

@interface XTImageGridView : UIScrollView

/**
 *  是否显示添加按钮
 */
@property (nonatomic,assign) BOOL showAddBtn;
/**
 *  是否显示删除按钮
 */
@property (nonatomic,assign) BOOL showDeleteBtn;
/**
 *  是否在显示删除按钮的时候调用摇晃动画
 */
@property (nonatomic,assign) BOOL showShakeAnimationWhenShowDeleteBtn;
/**
 *  grid view的风格
 */
@property (nonatomic,assign) XTImageGridViewStyle gridViewStyle;
/**
 *  grid的数量
 */
@property (nonatomic,assign) int numOfImageViews;
/**
 *  每一行上最多拥有grid的数量
 */
@property (nonatomic,assign) int maxNumInRow;
/**
 *  同一列上两个view的间距
 */
@property (nonatomic,assign) CGFloat gapOfTwoViewInCol;
/**
 *  同一行上两个view的间距
 */
@property (nonatomic,assign) CGFloat gapOfTwoViewInRow;
/**
 *  grid的size
 */
@property (nonatomic,assign) CGSize singleViewSize;
/**
 *  边距
 */
@property (nonatomic,assign) UIEdgeInsets edgeInsets;
/**
 *  委托对象
 */
@property (nonatomic,weak) id<XTImageGridViewDelegate> gridViewDelegate;

/**
 *  新增一个View
 */
-(void)addOneMoreView;
/**
 *  新增多个View
 */
-(void)addMoreViews:(NSInteger)viewCount;
/**
 *  移除某个view
 */
-(void)removeViewAtIndex:(int)index;
/**
 *  刷新界面
 */
-(void)reloadData;

@end
