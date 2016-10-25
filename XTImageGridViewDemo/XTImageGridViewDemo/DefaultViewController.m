//
//  DefaultViewController.m
//  XTImageGridViewDemo
//
//  Created by Ronnie Chen on 2016/10/24.
//  Copyright © 2016年 Ronnie Chen. All rights reserved.
//

#import "DefaultViewController.h"
#import "XTImageGridView.h"

@interface DefaultViewController ()<XTImageGridViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (nonatomic,strong) XTImageGridView *gridView;
@property (nonatomic,strong) NSMutableArray *attachArray;
@end

@implementation DefaultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
	self.title = @"XTImageGridViewStyleDefault";
	self.view.backgroundColor = [UIColor whiteColor];
	
	self.attachArray = [NSMutableArray array];
	
	self.gridView = [[XTImageGridView alloc] init];
	//	self.gridView.backgroundColor = [UIColor yellowColor];
	_gridView.frame = CGRectMake(0, 0, XTScreenSize.width, self.view.bounds.size.height);
	_gridView.edgeInsets = UIEdgeInsetsMake(45, (XTScreenSize.width-270)*0.5, 5, (XTScreenSize.width-270)*0.5);
	_gridView.gridViewDelegate = self;
	
	[self.view addSubview:_gridView];
	
	[self.gridView reloadData];
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
#pragma mark - XTImageGridViewDelegate
-(NSDictionary *)imageSourcesAtIndex:(int)index InGridView:(XTImageGridView *)gridView
{
	return @{@"name":[_attachArray objectAtIndex:index],@"isURL":@NO};
}

-(void)addBtnClickedInGridView:(XTImageGridView *)gridView
{
	[self clickedAddBtn:nil];
}

-(void)deleteBtnClickedAtIndex:(int)index InGridView:(XTImageGridView *)gridView
{
	if (gridView.numOfImageViews < 100) {
		gridView.showAddBtn = YES;
	}
	[self.attachArray removeObjectAtIndex:index];
	
}

-(void)viewClickedAtindex:(int)index InGridView:(XTImageGridView *)gridView
{
	
	// Photos

	UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Tint" message:[NSString stringWithFormat:@"Clicked View At Index %d",index] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
	[alertView show];
}

#pragma mark - clickedAddBtn
-(void)clickedAddBtn:(id)sender
{

	if( floor(NSFoundationVersionNumber) >= NSFoundationVersionNumber_iOS_8_0)
	{
		UIAlertController   *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
		[alertController addAction: [UIAlertAction actionWithTitle: NSLocalizedString(@"拍照", nil) style: UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
			//处理点击拍照
			[self openCamer];
			
		}]];
		[alertController addAction: [UIAlertAction actionWithTitle: NSLocalizedString(@"从相册选取", nil) style: UIAlertActionStyleDefault handler:^(UIAlertAction *action){
			//处理点击从相册选取
			[self openPhotoLibray];
			
		}]];
		[alertController addAction: [UIAlertAction actionWithTitle: NSLocalizedString(@"取消", nil) style: UIAlertActionStyleCancel handler:nil]];
		[self presentViewController: alertController animated: YES completion: nil];
		
	}
	else
	{
		
		UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:NSLocalizedString(@"取消", nil) destructiveButtonTitle:nil otherButtonTitles:NSLocalizedString(@"拍照", nil),NSLocalizedString(@"从相册选取", nil), nil];
		[actionSheet showInView:self.view];
		
	}
	
}
#pragma mark Camera View Delegate Methods
-(void)openCamer
{
	UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
	if (![UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera]) {
		sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
	}
	UIImagePickerController *picker = [[UIImagePickerController alloc] init];
	picker.delegate = self;
	picker.allowsEditing = NO;
	picker.sourceType = sourceType;
	[self presentViewController:picker animated:YES completion:nil];
}

-(void)openPhotoLibray
{
	UIImagePickerController *picker = [[UIImagePickerController alloc] init];
	picker.delegate = self;
	picker.allowsEditing = NO;
	picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
	[self presentViewController:picker animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker
didFinishPickingMediaWithInfo:(NSDictionary *)info {
	[picker dismissViewControllerAnimated:YES completion:^{
		UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
		
//		[self uploadImage:image];
		[_attachArray addObject:image];
		[_gridView addOneMoreView];

		if (_gridView.numOfImageViews >= 100) {
			_gridView.showAddBtn = NO;
		}
	}];
	
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
	[picker dismissViewControllerAnimated:YES completion:nil];
}

@end
