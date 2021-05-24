//
//  EJZNaVRootViewController.m
//  EJZExhibition
//
//  Created by 黄传家 on 2018/4/16.
//  Copyright © 2018年 黄传家. All rights reserved.
//

#import "EJZNaVRootViewController.h"

@interface EJZNaVRootViewController ()
@property (nonatomic,strong) UIActivityIndicatorView * personRootActivity;
@end

@implementation EJZNaVRootViewController
@synthesize titleName;
- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:YES];
    self.navigationController.navigationBar.barStyle = UIBarStyleDefault;
//    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:1 green:0.77 blue:0 alpha:1];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    //导航栏标题属性
    [self titleView:self.titleName];
    //导航栏左侧按钮
    [self leftItem:@"back"];
    
    //    [self addActivityIndicator];
    
}

- (void)addActivityIndicator{
    
    
    self.personRootActivity = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    self.personRootActivity.frame = self.view.bounds;
    self.personRootActivity.color = [UIColor lightGrayColor];
    [self.personRootActivity startAnimating];
    [self.personRootActivity setHidesWhenStopped:YES];
    [self.view addSubview:self.personRootActivity];
    
}
//导航栏标题属性
- (void)titleView:(NSString*)titleText{
    
    UILabel * titleLabel = [[UILabel alloc]init];
    titleLabel.frame = CGRectMake(0, 0, 120, 44);
    //    titleLabel.backgroundColor = [UIColor whiteColor];
    titleLabel.textColor = [UIColor blackColor];
    titleLabel.text = titleText;
    titleLabel.font = [UIFont systemFontOfSize:18.0f];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    self.navigationItem.titleView = titleLabel;
    
}
//导航栏左侧按钮
- (void)leftItem:(NSString*)imageName{
    
    UIButton * search = [UIButton buttonWithType:UIButtonTypeCustom];
    search.frame = CGRectMake(0, 0, 44, 44);
    [search setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    //    search.backgroundColor = [UIColor greenColor];
    [search setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 20)];
    [search addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * searchBar = [[UIBarButtonItem alloc]initWithCustomView:search];
    self.navigationItem.leftBarButtonItem = searchBar;
    
    
}
- (void)backAction{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
