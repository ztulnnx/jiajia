//
//  KeyChainStore.h
//  大公鸡
//
//  Created by Ivan on 2017/8/28.
//  Copyright © 2017年 Ivan. All rights reserved.
//



#import <Foundation/Foundation.h>

@interface KeyChainStore : NSObject

+ (void)save:(NSString *)service data:(id)data;
+ (id)load:(NSString *)service;
+ (void)deleteKeyData:(NSString *)service;

@end

