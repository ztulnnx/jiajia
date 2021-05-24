//
//  EJZTabBarViewController.m
//  EJZExhibition
//
//  Created by 黄传家 on 2018/4/12.
//  Copyright © 2018年 黄传家. All rights reserved.
//

#import "EJZTabBarViewController.h"
#import "EJZNavViewController.h"

#import "EJZStoreViewController.h"
#import "EJZMyViewController.h"
#import "EJZMessageViewController.h"
@interface EJZTabBarViewController ()

@end

@implementation EJZTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupChildVc:[[EJZStoreViewController alloc] init] title:@"店铺" image:@"game_n" selectedImage:@"game_s" isHiddenNavgationBar:NO];
    [self setupChildVc:[[EJZMessageViewController alloc] init] title:@"消息" image:@"home_n" selectedImage:@"home_s" isHiddenNavgationBar:NO];
    [self setupChildVc:[[EJZMyViewController alloc] init] title:@"我的" image:@"person_n" selectedImage:@"person_s" isHiddenNavgationBar:NO];
    
}
- (UIImage *)imageWithColor:(UIColor *)color{
    // 一个像素
    CGRect rect = CGRectMake(0, 0, 1, 1);
    // 开启上下文
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0);
    [color setFill];
    UIRectFill(rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}
- (void)setupChildVc:(UIViewController *)vc title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage isHiddenNavgationBar:(BOOL)isHidden
{
    static NSInteger index = 0;
    vc.navigationItem.title = title;
    vc.tabBarItem.title = title;
    vc.tabBarItem.image = [[UIImage imageNamed:image] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    vc.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    vc.tabBarItem.tag = index;
    index++;
    EJZNavViewController *nav = [[EJZNavViewController alloc] initWithRootViewController:vc];
    if (isHidden) {
        nav.navigationBar.hidden = YES;
    }
    
    [self addChildViewController:nav];
}

//// 支持设备自动旋转
//- (BOOL)shouldAutorotate
//{
//    return NO;
//}
//
+ (void)initialize
{
    //设置未选中的TabBarItem的字体颜色、大小
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = [UIFont systemFontOfSize:12];
    attrs[NSForegroundColorAttributeName] = [UIColor colorWithRed:0.50 green:0.50 blue:0.50 alpha:1];
    //设置选中了的TabBarItem的字体颜色、大小
    NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
    selectedAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:12];
    selectedAttrs[NSForegroundColorAttributeName] = [UIColor colorWithRed:0.19 green:0.47 blue:0.95 alpha:1];
    
    UITabBarItem *item = [UITabBarItem appearance];
    
    [item setTitleTextAttributes:attrs forState:UIControlStateNormal];
    [item setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];
}
@end
