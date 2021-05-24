//
//  EJZNetWokingTool.m
//  EJZExhibition
//
//  Created by 黄传家 on 2018/3/14.
//  Copyright © 2018年 黄传家. All rights reserved.
//

#import "EJZNetWokingTool.h"
#import <CommonCrypto/CommonDigest.h>
#import <AdSupport/AdSupport.h>
@implementation EJZNetWokingTool
+(NSString*)hashwithstring:(NSString *)string{
    
    //    NSLog(@"md5-----------string === %@",string);
    const char *original_str = [string UTF8String];//string为摘要内容，转成char
    /****系统api~~~~*****/
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(original_str, (int)strlen(original_str) , result);//调通系统md5编译
    
    NSMutableString *hash = [NSMutableString string];
    for (int i = 0; i < 16; i++)
        [hash appendFormat:@"%02X", result[i]];
    return hash ;//校验码
    
}

+(NSString *)getCurrentTime{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设定时间格式,这里可以设置成自己需要的格式
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    //用[NSDate date]可以获取系统当前时间
    NSString *currentDateStr = [dateFormatter stringFromDate:[NSDate date]];
    return currentDateStr;
}
+(NSString *)getUUID{
    NSString *idfa = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
    return idfa;
}
@end
