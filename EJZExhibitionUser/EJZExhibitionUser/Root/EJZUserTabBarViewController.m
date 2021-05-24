//
//  EJZUserTabBarViewController.m
//  EJZExhibitionUser
//
//  Created by 黄传家 on 2018/4/6.
//  Copyright © 2018年 黄传家. All rights reserved.
//

#import "EJZUserTabBarViewController.h"
#import "EJZUserNavViewController.h"
#import "EJZUserPersonViewController.h"
#import "EJZUserOrderViewController.h"
#import "EJZUserSearchViewController.h"
#import "EJZUserDiscoverViewController.h"
@interface EJZUserTabBarViewController ()

@end

@implementation EJZUserTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.view.backgroundColor = [UIColor whiteColor];
//    self.tabBarController.view.backgroundColor = [UIColor whiteColor];
    self.view.backgroundColor = [UIColor whiteColor];
    [[UITabBar appearance] setBarTintColor:[UIColor whiteColor]];
    [self setupChildVc:[[EJZUserSearchViewController alloc] init] title:@"找人" image:@"tab_icon_search_nor" selectedImage:@"tab_icon_search_sel" isHiddenNavgationBar:NO];
    [self setupChildVc:[[EJZUserDiscoverViewController alloc] init] title:@"发现" image:@"tab_icon_discover_nor" selectedImage:@"tab_icon_discover_sel" isHiddenNavgationBar:NO];
    [self setupChildVc:[[EJZUserOrderViewController alloc] init] title:@"订购" image:@"tab_icon_shop_nor" selectedImage:@"tab_icon_shop_sel" isHiddenNavgationBar:NO];
    [self setupChildVc:[[EJZUserPersonViewController alloc] init] title:@"我的" image:@"tab_icon_me_nor" selectedImage:@"tab_icon_me_sel" isHiddenNavgationBar:NO];

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
    EJZUserNavViewController *nav = [[EJZUserNavViewController alloc] initWithRootViewController:vc];
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
    attrs[NSForegroundColorAttributeName] = RGBA(127, 135, 151, 1);
    //设置选中了的TabBarItem的字体颜色、大小
    NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
    selectedAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:12];
    selectedAttrs[NSForegroundColorAttributeName] = RGBA(58, 140, 252, 1);
    
    UITabBarItem *item = [UITabBarItem appearance];
    
    [item setTitleTextAttributes:attrs forState:UIControlStateNormal];
    [item setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];
}
@end
