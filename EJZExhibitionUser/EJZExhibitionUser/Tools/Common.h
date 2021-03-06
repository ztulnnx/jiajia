//
//  Common.h
//  EJZExhibitionUser
//
//  Created by Karron Su on 2018/7/16.
//  Copyright © 2018年 黄传家. All rights reserved.
//

#ifndef Common_h
#define Common_h

/** 字体*/
#define kRegFont             @"PingFangSC-Regular"
#define kMedFont             @"PingFangSC-Medium"
#define kSemFont             @"PingFangSC-Semibold"
#define kHeaFont             @"PingFangSC-Heavy"

#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height
#define  iPhoneX (WIDTH == 375.f && HEIGHT == 812.f ? YES : NO)
#define  TabbarSafeBottomMargin  (iPhoneX ? 34.f : 0)
#define  TabbarSafeNavMargin  (iPhoneX ? 88.f : 64.f)
#define WRATIO WIDTH/375
#define HRATIO HEIGHT/667
#define tableViewFrame              CGRectMake(0, 0, WIDTH, HEIGHT - TabbarSafeNavMargin - TabbarSafeNavMargin)

//颜色
#define RGBA(r,g,b,a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:a]
#define SXRGB16Color(rgbValue,a) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:(a)]
//秘钥
#define APPKEY @"dedc6addbc8d8ecb73f370f6c9a2e70e"
//basic URL
#define WEBSITE @"https://soft.haojin.org/"
//#define WEBSITE @"http://192.168.0.200/"
//枚举，网络请求类型
typedef enum {
    STATEONE = 1,
    STATETWO,
    STATETHREE,
    STATEFOUR,
    STATEFIVE,
    STATESIX,
    STATEJOIN,
    STATELOGIN,
    
}NETSTATE;
//钥匙串加密数据本地持久化字段命名
#define  KEY_USERID      @"com.userexhibition.hcj.userId"
#define  KEY_USERNAME    @"com.userexhibition.hcj.userName"
#define  KEY_PHONE       @"com.userexhibition.hcj.phone"
#define  KEY_USERPWD     @"com.userexhibition.hcj.userPwd"
#define  KEY_USERTOKEN   @"com.userexhibition.hcj.userToken"
#define  KEY_UUID        @"com.userexhibition.hcj.uuid"


#endif /* Common_h */
