//
//  EJZNaVRootViewController.h
//  EJZExhibition
//
//  Created by 黄传家 on 2018/4/16.
//  Copyright © 2018年 黄传家. All rights reserved.
//

#import "EJZRootViewController.h"
#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
@interface EJZNaVRootViewController : EJZRootViewController<UIGestureRecognizerDelegate,UITextFieldDelegate>
@property (nonatomic, copy) NSString *titleName;
//@property (nonatomic,strong) UITableView * table;
@end
