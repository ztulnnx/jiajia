//
//  EJZUserIssueViewController.m
//  EJZExhibitionUser
//
//  Created by 黄传家 on 2018/5/7.
//  Copyright © 2018年 黄传家. All rights reserved.
//

#import "EJZUserIssueViewController.h"
#import "EJZUserAddProViewController.h"
@interface EJZUserIssueViewController ()
@property (nonatomic,strong)UITextField *titleTF;
@property (nonatomic,strong)UITextView *describeJobTV;
@property (nonatomic,strong)UISwitch *urgentSwitch;
@property (nonatomic,strong)UILabel *professionLabel;
@property (nonatomic,strong)UIScrollView *scrollView;
@property (nonatomic,strong)UIView *urgentView;
@property (nonatomic,strong)UIView *middleBackView;
@end

@implementation EJZUserIssueViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setIssueView];
    // Do any additional setup after loading the view.
}
-(void)setIssueView{
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, TabbarSafeNavMargin, WIDTH, HEIGHT-TabbarSafeNavMargin)];
//    self.scrollView.delegate = self;
    //    _scrollview.backgroundColor = [UIColor redColor];
    self.scrollView.backgroundColor = RGBA(230, 230, 230, 1);
    self.scrollView.pagingEnabled = YES;
    self.scrollView.bounces = NO;
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.contentSize = CGSizeMake(WIDTH,790*WRATIO);
    [self.view addSubview:self.scrollView];
    
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 70*WRATIO)];
    titleView.backgroundColor = [UIColor whiteColor];
    [self.scrollView addSubview:titleView];
    
    self.titleTF = [[UITextField alloc] initWithFrame:CGRectMake(10*WRATIO, 15*WRATIO, WIDTH-20*WRATIO, 40*WRATIO)];
    self.titleTF.placeholder = @"请输入标题";
    self.titleTF.font = [UIFont fontWithName:@"Helvetica" size:18*WRATIO];
    [titleView addSubview:self.titleTF];
    
    self.urgentView = [[UIView alloc] initWithFrame:CGRectMake(0, 70*WRATIO+1, WIDTH, 70*WRATIO)];
    self.urgentView.backgroundColor = [UIColor whiteColor];
    [self.scrollView addSubview:self.urgentView];
    UILabel *urgentLabel = [[UILabel alloc] initWithFrame:CGRectMake(10*WRATIO, 15*WRATIO, 150*WRATIO, 20*WRATIO)];
    urgentLabel.text = @"招募加急";
    urgentLabel.font = [UIFont fontWithName:@"Helvetica" size:14*WRATIO];
    urgentLabel.textColor = RGBA(96, 100, 108, 1);
    [self.urgentView addSubview:urgentLabel];
    
    UILabel *urgentLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(10*WRATIO, 40*WRATIO, 300*WRATIO, 20*WRATIO)];
    urgentLabel1.text = @"加急提供对工人的定向短信通知功能，提高招募效率";
    urgentLabel1.font = [UIFont fontWithName:@"Helvetica" size:12*WRATIO];
    urgentLabel1.textColor = RGBA(150, 160, 167, 1);
    [self.urgentView addSubview:urgentLabel1];
    
    self.urgentSwitch = [[UISwitch alloc] initWithFrame:CGRectMake(310*WRATIO, 20*WRATIO, 60*WRATIO, 30*WRATIO)];
    self.urgentSwitch.on = NO;
    [self.urgentSwitch addTarget:self action:@selector(urgentSwitchClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.urgentView addSubview:self.urgentSwitch];
    
    self.middleBackView = [[UIView alloc] initWithFrame:CGRectMake(0, 150*WRATIO+1, WIDTH, 440*WRATIO)];
    self.middleBackView.backgroundColor = [UIColor whiteColor];
    [self.scrollView addSubview:self.middleBackView];
    
//    UIView *prantingView2 = [[UIView alloc] initWithFrame:CGRectMake(0, TabbarSafeNavMargin+140*WRATIO+1, WIDTH, 10*WRATIO)];
//    prantingView2.backgroundColor = RGBA(230, 230, 230, 1);
//    [self.view addSubview:prantingView2];
//
    self.professionLabel = [[UILabel alloc] initWithFrame:CGRectMake(10*WRATIO, 20*WRATIO+1, 150*WRATIO, 20*WRATIO)];
    self.professionLabel.text = @"招募加急";
    self.professionLabel.font = [UIFont fontWithName:@"Helvetica" size:14*WRATIO];
    self.professionLabel.textColor = RGBA(96, 100, 108, 1);
    [self.middleBackView addSubview:self.professionLabel];
//
//
    UIButton *addProfessionBtn = [[UIButton alloc] initWithFrame:CGRectMake(300*WRATIO, 10*WRATIO, 60*WRATIO, 40*WRATIO)];
    [addProfessionBtn setTitle:@"添加" forState:UIControlStateNormal];
    [addProfessionBtn setTitleColor:RGBA(58, 140, 252, 1) forState:UIControlStateNormal];
    addProfessionBtn.titleLabel.font = [UIFont fontWithName:@"Helvetica" size:14*WRATIO];
    [addProfessionBtn addTarget:self action:@selector(addProfessionBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.middleBackView addSubview:addProfessionBtn];
//
    UIView *prantingView3 = [[UIView alloc] initWithFrame:CGRectMake(0, 60*WRATIO, WIDTH, 10*WRATIO)];
    prantingView3.backgroundColor = RGBA(230, 230, 230, 1);
    [self.middleBackView addSubview:prantingView3];
    
    
//
//
//
//    UIView *prantingView4 = [[UIView alloc] initWithFrame:CGRectMake(0, TabbarSafeNavMargin+270*WRATIO+2, WIDTH, 1)];
//    prantingView4.backgroundColor = RGBA(230, 230, 230, 1);
//    [self.view addSubview:prantingView4];
//
//    UIView *prantingView5 = [[UIView alloc] initWithFrame:CGRectMake(0, TabbarSafeNavMargin+330*WRATIO+3, WIDTH, 1)];
//    prantingView5.backgroundColor = RGBA(230, 230, 230, 1);
//    [self.view addSubview:prantingView5];
//
//    UIView *prantingView6 = [[UIView alloc] initWithFrame:CGRectMake(0, TabbarSafeNavMargin+390*WRATIO+4, WIDTH, 10*WRATIO)];
//    prantingView6.backgroundColor = RGBA(230, 230, 230, 1);
//    [self.view addSubview:prantingView6];
//
//    UIView *prantingView7 = [[UIView alloc] initWithFrame:CGRectMake(0, TabbarSafeNavMargin+510*WRATIO+4, WIDTH, HEIGHT-(TabbarSafeNavMargin+450*WRATIO+4))];
//    prantingView7.backgroundColor = RGBA(230, 230, 230, 1);
//    [self.view addSubview:prantingView7];
//
//    UIButton *issueBtn = [[UIButton alloc] initWithFrame:CGRectMake(10*WRATIO, 10*WRATIO, WIDTH-20*WRATIO, 44*WRATIO)];
//    [issueBtn setTitle:@"马上发布" forState:UIControlStateNormal];
//    [issueBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    issueBtn.backgroundColor = RGBA(205, 207, 211, 1);
//    issueBtn.layer.masksToBounds = YES;
//    issueBtn.layer.cornerRadius = 4*WRATIO;
//    [prantingView7 addSubview:issueBtn];
}

-(void)urgentSwitchClick:(UISwitch *)sender{
    if (sender.on) {
        NSLog(@"lalalallalalalalallal");
        self.urgentView.frame = CGRectMake(0, 70*WRATIO+1, WIDTH, 220*WRATIO);
        NSArray *titleArr = @[@"10元套餐（定向通知10名工人）",@"20元套餐（定向通知30名工人）",@"30元套餐（定向通知100名工人）"];
        for (int i = 0; i<titleArr.count; i++) {
            UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(10*WRATIO, 85*WRATIO + i*50*WRATIO, 20*WRATIO, 20*WRATIO)];
            btn.tag = 10+i;
            [btn setImage:[UIImage imageNamed:@"tab_icon_me_nor"] forState:UIControlStateNormal];
            [self.urgentView addSubview:btn];
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(50*WRATIO, 85*WRATIO+i*50*WRATIO, 300*WRATIO, 20*WRATIO)];
            label.text = titleArr[i];
            label.tag = 20+i;
            [self.urgentView addSubview:label];
        }
        self.middleBackView.frame = CGRectMake(0, 300*WRATIO+1, WIDTH, 440*WRATIO);
    }else{
        NSLog(@"hahahahahahhahahhahah");
//        UIButton *btn = (UIButton *)[self.btnBackView viewWithTag:index+10];
        for (int i = 0; i<3; i++) {
            UIButton *btn = (UIButton *)[self.urgentView viewWithTag:i+10];
            UILabel *label = (UILabel *)[self.urgentView viewWithTag:i+20];
            [btn removeFromSuperview];
            [label removeFromSuperview];
        }
        self.urgentView.frame = CGRectMake(0, 70*WRATIO+1, WIDTH, 70*WRATIO);
        self.middleBackView.frame = CGRectMake(0, 150*WRATIO+1, WIDTH, 440*WRATIO);
    }
}
-(void)addProfessionBtnClick:(UIButton *)sender{
    EJZUserAddProViewController *addProVC = [[EJZUserAddProViewController alloc] init];
    addProVC.titleName = @"招募工作";
    [self.navigationController pushViewController:addProVC animated:YES];
}
@end
