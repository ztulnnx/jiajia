//
//  EJZUserSearchViewController.m
//  EJZExhibitionUser
//
//  Created by 黄传家 on 2018/4/6.
//  Copyright © 2018年 黄传家. All rights reserved.
//

#import "EJZUserSearchViewController.h"
#import "EJZUserScorllView.h"
#import "EJZUserIssueViewController.h"
@interface EJZUserSearchViewController ()<EJZScrollViewDelegate>
@property (nonatomic,strong)EJZUserScorllView *scorllView;
@end

@implementation EJZUserSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = RGBA(230, 230, 230, 1);
    [self getHomeData];
    
    [self setHomeNav];
    
    [self setHomeView];
    
}
-(void)getHomeData{
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    [dict setObject:[NSNumber numberWithInt:1] forKey:@":position"];
    [self creatRequestWithUrl:HomeTab andJsonString:dict andState:STATEONE withWay:2];
}
-(void)getRootData:(NSDictionary *)dataDiction andState:(NETSTATE)state{
    NSLog(@"dataDiction::::::::%@",dataDiction);
    NSString *result = dataDiction[@"code"];
    if ([result intValue] == 200) {
        NSArray *arr = dataDiction[@"data"];
        NSMutableArray *imgArr = [NSMutableArray array];
        for (int i = 0; i<arr.count; i++) {
            NSDictionary *dict = arr[i];
            NSString *str = [NSString stringWithFormat:@"%@%@",WEBSITE,dict[@"image_path"]];
            [imgArr addObject:str];
            
        }
        NSLog(@"%@",imgArr);
        self.scorllView = [EJZUserScorllView  initWithFrame:CGRectMake(0, TabbarSafeNavMargin, WIDTH, 175*WRATIO) withMargnPadding:0 withImgWidth:WIDTH dataArray:imgArr];
        self.scorllView.delegate = self;
        [self.view addSubview:self.scorllView];
        self.scorllView.otherPageControlColor = [UIColor colorWithWhite:1 alpha:0.3];
        self.scorllView.curPageControlColor = [UIColor whiteColor];
        self.scorllView.autoScroll = YES;
    }
    
}
-(void)setHomeView{
    
    
    
    UIView *topBackView = [[UIView alloc] initWithFrame:CGRectMake(0, TabbarSafeNavMargin+175*WRATIO, WIDTH, 150*WRATIO)];
    topBackView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:topBackView];
    
    UILabel *seachLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 10*WRATIO, WIDTH, 30*WRATIO)];
    seachLabel.text = @"——找专业找工人——";
    seachLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:15*WRATIO];
    seachLabel.textAlignment = NSTextAlignmentCenter;
    [topBackView addSubview:seachLabel];
    
    NSArray *titleArr = @[@"美工",@"木工",@"电工",@"搬运工",@"更多"];
    NSArray *imgArr = @[@"icon_index_art",@"icon_index_wood",@"icon_index_electric",@"icon_index_carry",@"icon_index_more"];
    for (int i = 0; i<titleArr.count; i++) {
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(i*WIDTH/5, 50*WRATIO, WIDTH/5, WIDTH/5)];
        
        [btn setImage:[UIImage imageNamed:imgArr[i]] forState:UIControlStateNormal];
        
        [topBackView addSubview:btn];
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(i*WIDTH/5, 35*WRATIO+WIDTH/5, WIDTH/5, 30*WRATIO)];
        
        titleLabel.text = titleArr[i];
        titleLabel.textColor = RGBA(96, 100, 108, 1);
        titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:12*WRATIO];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        [topBackView addSubview:titleLabel];
        
    }
    
    UIView *bottomBackView = [[UIView alloc] initWithFrame:CGRectMake(0, TabbarSafeNavMargin+335*WRATIO, WIDTH, 150*WRATIO)];
    bottomBackView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bottomBackView];
    
    
    UILabel *needLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 10*WRATIO, WIDTH, 30*WRATIO)];
    needLabel.text = @"——发需求，让工人找上门——";
    needLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:15*WRATIO];
    needLabel.textAlignment = NSTextAlignmentCenter;
    [bottomBackView addSubview:needLabel];
    
    UILabel *hintBottomLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 40*WRATIO, WIDTH, 30*WRATIO)];
    hintBottomLabel.text = @"已成功为10000名雇主解决缺人问题";
    hintBottomLabel.textColor = RGBA(150, 160, 167, 1);
    hintBottomLabel.font = [UIFont fontWithName:@"Helvetica" size:12*WRATIO];
    hintBottomLabel.textAlignment = NSTextAlignmentCenter;
    [bottomBackView addSubview:hintBottomLabel];
    
    UIButton *issueBtn = [[UIButton alloc]initWithFrame:CGRectMake((WIDTH-240*WRATIO)/2, 80*WRATIO, 240*WRATIO, 40*WRATIO)];
    issueBtn.backgroundColor = RGBA(58,140,252,1);
    [issueBtn setTitle:@"立即发布" forState:UIControlStateNormal];
    [issueBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    issueBtn.layer.masksToBounds = YES;
    issueBtn.layer.cornerRadius = 20*WRATIO;
    [issueBtn addTarget:self action:@selector(issueBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [bottomBackView addSubview:issueBtn];
    
}
-(void)issueBtnClick:(UIButton *)sender{
    EJZUserIssueViewController *issueVC = [[EJZUserIssueViewController alloc] init];
    issueVC.titleName = @"发布";
    [self.navigationController pushViewController:issueVC animated:YES];
}
-(void)setHomeNav{
//    UIButton *leftBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 20)];
    UILabel *titleLabel = [[UILabel alloc]init];
    titleLabel.frame = CGRectMake(0, 0, 120, 44);
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.text = @"找人";
    titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:18*WRATIO];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    self.navigationItem.titleView = titleLabel;
    
//    UIButton *leftBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
//    leftBtn.frame = CGRectMake(0, 0, 44, 44);
//    leftBtn.titleLabel.font = [UIFont systemFontOfSize:16*WRATIO];
//    [leftBtn setTitle:@"消息" forState:UIControlStateNormal];
//    [leftBtn setTitleColor:[UIColor colorWithRed:0.3 green:0.3 blue:0.3 alpha:1] forState:UIControlStateNormal];
//    UIBarButtonItem * navLeftBar = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
//    self.navigationItem.leftBarButtonItem = navLeftBar;
//    [leftBtn addTarget:self action:@selector(leftBtnClick:) forControlEvents:UIControlEventTouchUpInside];
//
//    UIButton *rightBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
//    rightBtn.frame = CGRectMake(0, 0, 44, 44);
//    rightBtn.titleLabel.font = [UIFont systemFontOfSize:16*WRATIO];
//    [rightBtn setTitle:@"发布" forState:UIControlStateNormal];
//    [rightBtn setTitleColor:[UIColor colorWithRed:0.3 green:0.3 blue:0.3 alpha:1] forState:UIControlStateNormal];
//    UIBarButtonItem * navRightBar = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
//    self.navigationItem.rightBarButtonItem = navRightBar;
//    [rightBtn addTarget:self action:@selector(rightBtnClick:) forControlEvents:UIControlEventTouchUpInside];
}
//-(void)leftBtnClick:(UIButton *)sender{
//    NSLog(@"导航栏左边");
//}
//-(void)rightBtnClick:(UIButton *)sender{
//    NSLog(@"导航栏右边");
//}


@end
