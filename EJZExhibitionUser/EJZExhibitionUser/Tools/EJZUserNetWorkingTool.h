//
//  EJZUserNetWorkingTool.h
//  EJZExhibitionUser
//
//  Created by 黄传家 on 2018/3/22.
//  Copyright © 2018年 黄传家. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EJZUserNetWorkingTool : NSObject
+(NSString*)hashwithstring:(NSString *)string;

+(NSString *)getCurrentTime;

+(NSString *)getUUID;
@end