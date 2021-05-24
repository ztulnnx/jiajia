//
//  EJZUserNavRootViewController.h
//  EJZExhibitionUser
//
//  Created by 黄传家 on 2018/5/7.
//  Copyright © 2018年 黄传家. All rights reserved.
//

#import "EJZUserRootViewController.h"
#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
@interface EJZUserNavRootViewController : EJZUserRootViewController<UIGestureRecognizerDelegate,UITextFieldDelegate>
@property (nonatomic, copy) NSString *titleName;

@end
