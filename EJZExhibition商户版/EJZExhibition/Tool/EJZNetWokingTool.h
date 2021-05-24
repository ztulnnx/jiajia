//
//  EJZNetWokingTool.h
//  EJZExhibition
//
//  Created by 黄传家 on 2018/3/14.
//  Copyright © 2018年 黄传家. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EJZNetWokingTool : NSObject
+(NSString*)hashwithstring:(NSString *)string;

+(NSString *)getCurrentTime;

+(NSString *)getUUID;
@end
