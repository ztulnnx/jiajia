//
//  EJZRootViewController.h
//  EJZExhibition
//
//  Created by 黄传家 on 2018/3/14.
//  Copyright © 2018年 黄传家. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EJZRootViewController : UIViewController
- (void)getRootData:(NSDictionary*)dataDiction andState:(NETSTATE)state;
- (void)requestError;
- (void)creatRequestWithUrl:(NSString*)url andJsonString:(NSDictionary *)dict andState:(NETSTATE)state withWay:(int)way;
- (void)creatRequestWithUrl:(NSString*)url andphotos:(NSArray *)arrPhotos andState:(NETSTATE)state withWay:(int)way;
- (void)getPhotoData:(NSArray*)idArr andState:(NETSTATE)state;
@end
