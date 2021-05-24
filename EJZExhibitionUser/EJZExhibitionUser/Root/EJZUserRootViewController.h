//
//  EJZUserRootViewController.h
//  EJZExhibitionUser
//
//  Created by 黄传家 on 2018/3/22.
//  Copyright © 2018年 黄传家. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EJZUserRootViewController : UIViewController
- (void)getRootData:(NSDictionary*)dataDiction andState:(NETSTATE)state;
- (void)requestError;
- (void)creatRequestWithUrl:(NSString*)url andJsonString:(NSDictionary *)dict andState:(NETSTATE)state withWay:(int)way;
@end
