//
//  JFImageGroupTableViewController.m
//  JFImagePickerController
//
//  Created by Johnil on 15-7-3.
//  Copyright (c) 2015年 Johnil. All rights reserved.
//

#import "JFImageGroupTableViewController.h"
#import "JFImageCollectionViewController.h"
#import "JFImagePickerController.h"
#import "JFAssetHelper.h"

@interface JFImageGroupTableViewController ()

@end

@implementation JFImageGroupTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated{
//	self.navigationItem.title = @"相册";
    UILabel *label = [[UILabel alloc] init];
    label.textColor = [UIColor blackColor];
    label.text = @"相册列表";
    label.font = [UIFont systemFontOfSize:17];
    [label sizeToFit];
    self.navigationItem.titleView = label;
//    UIBarButtonItem *cancel = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStylePlain target:self action:@selector(cancel)];
    UIButton *rightBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
    rightBtn.frame = CGRectMake(0, 0, 44, 44);
    rightBtn.titleLabel.font = [UIFont systemFontOfSize:16*WRATIO];
    [rightBtn setTitle:@"取消" forState:UIControlStateNormal];
    [rightBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    UIBarButtonItem * navRightBar = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = navRightBar;
    [rightBtn addTarget:self action:@selector(cancel) forControlEvents:UIControlEventTouchUpInside];
}

- (void)cancel{
	[(JFImagePickerController *)self.navigationController cancel];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	self.navigationController.navigationBar.translucent = YES;
	self.navigationController.navigationBar.barStyle = UIBarStyleDefault;
//    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.tableView.tableFooterView = [UIView new];
    ASSETHELPER.bReverse = YES;
	[ASSETHELPER getGroupList:^(NSArray *a) {
		[self.tableView reloadData];
		ASSETHELPER.currentGroupIndex = 0;
		JFImageCollectionViewController *picker = [[JFImageCollectionViewController alloc] initWithNibName:nil bundle:nil];
		[self.navigationController pushViewController:picker animated:NO];
	}];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[JFAssetHelper sharedAssetHelper] getGroupCount];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuseIdentifier"];
	if (cell==nil) {
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"reuseIdentifier"];
	}
	ALAssetsGroup *group = [ASSETHELPER getGroupAtIndex:indexPath.row];
	cell.imageView.image = [UIImage imageWithCGImage:[group posterImage]];
	cell.textLabel.text = [group valueForProperty:ALAssetsGroupPropertyName];
	cell.detailTextLabel.text = [NSString stringWithFormat:@"%ld", (long)[group numberOfAssets]];
	cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
	return 80;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
	ASSETHELPER.currentGroupIndex = indexPath.row;
	JFImageCollectionViewController *picker = [[JFImageCollectionViewController alloc] initWithNibName:nil bundle:nil];
	[self.navigationController pushViewController:picker animated:YES];
}

@end
