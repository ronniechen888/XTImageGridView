XTImageGridView
===============

XTImageGridView is a very simple lib for build Grid View in iOS.


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

####After long press.

![Animation1](https://github.com/ronniechen888/XTImageGridView/blob/master/Document/gridview_after_long_press1.png)
![Animation2](https://github.com/ronniechen888/XTImageGridView/blob/master/Document/gridview_after_long_press2.png)

     `XTImageGridViewStyleDefault`
     
     `XTImageGridViewStyleCustom`
