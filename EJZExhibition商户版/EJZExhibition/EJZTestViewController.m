
//
//  EJZTestViewController.m
//  EJZExhibition
//
//  Created by 黄传家 on 2018/3/17.
//  Copyright © 2018年 黄传家. All rights reserved.
//

#import "EJZTestViewController.h"
#import "EJZNetWokingTool.h"
@interface EJZTestViewController ()

@end

@implementation EJZTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    [dict setObject:@"15802009991" forKey:@"phone"];
    [dict setObject:@"a123456" forKey:@"password"];
    [dict setObject:[NSNumber numberWithInt:1] forKey:@"mode"];
    NSString *idfa = [EJZNetWokingTool getUUID];
    [dict setObject:idfa forKey:@"unique_id"];
    [self creatRequestWithUrl:Login andJsonString:dict andState:STATELOGIN withWay:1];

}
-(void)getPhotoData:(NSArray *)idArr andState:(NETSTATE)state{
    NSLog(@"idArr:::::%@",idArr);
}
-(void)getRootData:(NSDictionary *)dataDiction andState:(NETSTATE)state{
    if (STATELOGIN == state) {
        NSLog(@"statelogin:::::::%@",dataDiction);
        NSString *code = dataDiction[@"code"];
        if ([code intValue] == 200) {
            NSString *token = dataDiction[@"data"][@"token"];
            [KeyChainStore save:KEY_USERTOKEN data:token];
            NSArray *arr1 = @[@"1",@"2",@"3",@"4"];
            
            [self creatRequestWithUrl:UpLoad andphotos:arr1 andState:STATEONE withWay:3];
            
        }
        
    }else if (STATEONE == state){
        NSLog(@"stateone:::::::%@",dataDiction);
    }
}

@end
