//
//  EJZStoreViewController.m
//  EJZExhibition
//
//  Created by 黄传家 on 2018/4/12.
//  Copyright © 2018年 黄传家. All rights reserved.
//

#import "EJZStoreViewController.h"
#import "EJZStoreTableViewCell.h"
//#import "EJZAddStoreViewController.h"
#import "EJZLoginViewController.h"
#import "EJZStoreWriteViewController.h"
@interface EJZStoreViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)UIView *noThingView;
@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)NSMutableArray *dataSource;
@end

@implementation EJZStoreViewController
- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:YES];
    self.navigationController.navigationBar.barStyle = UIBarStyleDefault;
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1];
    self.dataSource = [NSMutableArray array];
//    NSDictionary *dict = @{@"":@"",@"":@"",@"":@[]};
    [self setNavView];
    UILabel *topLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, TabbarSafeNavMargin, WIDTH, 60*WRATIO)];
    topLabel.backgroundColor = [UIColor grayColor];
    topLabel.text = @"运营内容";
    topLabel.textAlignment = NSTextAlignmentCenter;
    topLabel.textColor = [UIColor whiteColor];
    topLabel.font = [UIFont systemFontOfSize:16*WRATIO];
    [self.view addSubview:topLabel];

    [self initNoThingView];
//    [self initStroeView];
}
-(void)initNoThingView{
    self.noThingView = [[UIView alloc] initWithFrame:CGRectMake(0, (HEIGHT-200*WRATIO)/2, WIDTH, 200*WRATIO)];
//    self.noThingView.backgroundColor = [UIColor redColor];
    [self.view addSubview:self.noThingView];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake((WIDTH-80*WRATIO)/2, 10*WRATIO, 80*WRATIO, 80*WRATIO)];
    imageView.backgroundColor = [UIColor grayColor];
    imageView.layer.masksToBounds = YES;
    imageView.layer.cornerRadius = 40*WRATIO;
    [self.noThingView addSubview:imageView];
    
    UILabel *hintLabel1 = [[UILabel alloc] initWithFrame:CGRectMake((WIDTH-220*WRATIO)/2, 100*WRATIO, 220*WRATIO, 20*WRATIO)];
//    hintLabel1.numberOfLines = 2;
    hintLabel1.font = [UIFont systemFontOfSize:14*WRATIO];
    hintLabel1.textAlignment = NSTextAlignmentCenter;
    hintLabel1.textColor = [UIColor blackColor];
    hintLabel1.text = @"您目前没有店铺信息";
    [self.noThingView addSubview:hintLabel1];
    UILabel *hintLabel2 = [[UILabel alloc] initWithFrame:CGRectMake((WIDTH-220*WRATIO)/2, 120*WRATIO, 220*WRATIO, 20*WRATIO)];
    //    hintLabel1.numberOfLines = 2;
    hintLabel2.font = [UIFont systemFontOfSize:14*WRATIO];
    hintLabel2.textColor = [UIColor blackColor];
    hintLabel2.text = @"创建店铺后可以对店铺进行管理";
    hintLabel2.textAlignment = NSTextAlignmentCenter;
    [self.noThingView addSubview:hintLabel2];
    
    UIButton *toCreatBtn = [[UIButton alloc] initWithFrame:CGRectMake((WIDTH-220*WRATIO)/2, 150*WRATIO, 220*WRATIO, 40*WRATIO)];
    toCreatBtn.backgroundColor = [UIColor grayColor];
    toCreatBtn.titleLabel.font = [UIFont systemFontOfSize:16*WRATIO];
    [toCreatBtn setTitle:@"立即创建" forState:UIControlStateNormal];
    [toCreatBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.noThingView addSubview:toCreatBtn];
    [toCreatBtn addTarget:self action:@selector(toaddStoreView) forControlEvents:UIControlEventTouchUpInside];

}
-(void)toaddStoreView{
//    NSLog(@"添加店铺");
//    NSString *token = [NSString stringWithFormat:@"%@",[KeyChainStore load:KEY_USERTOKEN]];
//    if ([token isEqualToString:@"(null)"]) {
//        NSLog(@"跳转到登录页面");
//        EJZLoginViewController *loginVC = [[EJZLoginViewController alloc] init];
//        [self.navigationController pushViewController:loginVC animated:YES];
//    }else{
        EJZStoreWriteViewController *addStoreVC = [[EJZStoreWriteViewController alloc] init];
        addStoreVC.titleName = @"开店";
        [self.navigationController pushViewController:addStoreVC animated:YES];
//    }
   
}
-(void)initStroeView{
    
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, TabbarSafeNavMargin+60*WRATIO, WIDTH, HEIGHT - TabbarSafeNavMargin - TabbarSafeBottomMargin - 60*WRATIO - 44)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    
}
-(void)setNavView{
    //导航栏标题
    UILabel *titleLabel = [[UILabel alloc]init];
    titleLabel.frame = CGRectMake(0, 0, 120, 44);
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.textColor = [UIColor blackColor];
    titleLabel.text = @"首页";
    titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:18*WRATIO];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    self.navigationItem.titleView = titleLabel;
    // Do any additional setup after loading the view.
    UIButton *rightBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
    rightBtn.frame = CGRectMake(0, 0, 44, 44);
    rightBtn.titleLabel.font = [UIFont systemFontOfSize:16*WRATIO];
    [rightBtn setTitle:@"设置" forState:UIControlStateNormal];
    [rightBtn setTitleColor:[UIColor colorWithRed:0.3 green:0.3 blue:0.3 alpha:1] forState:UIControlStateNormal];
    UIBarButtonItem * navRightBar = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = navRightBar;
    [rightBtn addTarget:self action:@selector(rightBtnClick:) forControlEvents:UIControlEventTouchUpInside];
}
- (void)rightBtnClick:(UIButton *)sender{
    NSLog(@"设置按钮");
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    return nil;
}


@end
