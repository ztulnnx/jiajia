//
//  EJZUserRootViewController.m
//  EJZExhibitionUser
//
//  Created by 黄传家 on 2018/3/22.
//  Copyright © 2018年 黄传家. All rights reserved.
//

#import "EJZUserRootViewController.h"
#import "EJZUserNetWorkingTool.h"
@interface EJZUserRootViewController ()
@property (nonatomic,strong)NSString *urlStr;
@property (nonatomic,strong)NSDictionary *netWorkDict;
@property (nonatomic,strong)NSArray *upFileArr;
@property (nonatomic,assign)NETSTATE netWorkState;
@property (nonatomic,assign)int netWorkWay;
@end

@implementation EJZUserRootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)getRootData:(NSDictionary*)dataDiction andState:(NETSTATE)state{
    
}
- (void)requestError{
    NSLog(@"请求错误");
}
- (void)creatRequestWithUrl:(NSString*)url andJsonString:(NSDictionary *)dict andState:(NETSTATE)state withWay:(int)way{
    self.urlStr = [NSString stringWithFormat:@"%@%@",WEBSITE,url];
    self.netWorkDict = dict;
    self.netWorkWay = way;
    self.netWorkState = state;
    [self AFNReachability];
}
- (void)creatRequestWithUrl:(NSString*)url andphotos:(NSArray *)arrPhotos andState:(NETSTATE)state withWay:(int)way{
    self.urlStr = [NSString stringWithFormat:@"%@%@",WEBSITE,url];
    self.upFileArr = arrPhotos;
    self.netWorkState = state;
    self.netWorkWay = way;
    [self AFNReachability];
    
}

#pragma mark    使用AFN框架来检测网络状态的改变
-(void)AFNReachability{
    //1.创建网络监听管理者
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    
    //2.监听网络状态的改变
    /*
     AFNetworkReachabilityStatusUnknown          = 未知
     AFNetworkReachabilityStatusNotReachable     = 没有网络
     AFNetworkReachabilityStatusReachableViaWWAN = 3G
     AFNetworkReachabilityStatusReachableViaWiFi = WIFI
     */
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusUnknown:
            {
                NSLog(@"未知");
                //                UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"当前无网络!" message:nil delegate:self cancelButtonTitle:@"" otherButtonTitles:nil, nil];
                //                [alert show];
                
            }
                break;
            case AFNetworkReachabilityStatusNotReachable:
            {
                NSLog(@"没有网络");
                //                [self notNetWork];
                
            }
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN:
            {
                [self requestdata];
                NSLog(@"3G");
            }
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:
            {
                [self requestdata];
                NSLog(@"WIFI");
            }
                break;
                
            default:
                break;
        }
    }];
    
    //3.开始监听
    [manager startMonitoring];
}
-(void)requestdata{
    
    if (self.netWorkWay == 1) {
        [self postrequestData];
    }else if(self.netWorkWay == 2){
        [self getrequestData];
    }
    
}
-(void)getrequestData{
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer =  [AFJSONResponseSerializer serializer];
    [manager.requestSerializer setValue:APPKEY forHTTPHeaderField:@"x-access-key"];
    NSString *idfa = [EJZUserNetWorkingTool getUUID];
    NSString *currentTime = [EJZUserNetWorkingTool getCurrentTime];
    NSString *sign = [NSString stringWithFormat:@"%@%@",currentTime,idfa];
    NSString *md5Sign = [EJZUserNetWorkingTool hashwithstring:sign];
    NSLog(@"GET   appkey:::::%@   uuidStr::::::%@   timeStr:::::::%@   md5Sign::::::::%@",APPKEY,idfa,currentTime,md5Sign);
    [manager.requestSerializer setValue:md5Sign forHTTPHeaderField:@"x-access-sign"];
    [manager.requestSerializer setValue:currentTime forHTTPHeaderField:@"x-access-timestamp"];
    NSString *token = [KeyChainStore load:KEY_USERTOKEN];
    if (token.length>0) {
        [manager.requestSerializer setValue:token forHTTPHeaderField:@"x-access-token"];
        
    }
    [manager GET:self.urlStr parameters:self.netWorkDict progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"=======%@",responseObject[@"message"]);
        NSString *result = responseObject[@"code"];
        NSLog(@"result:::::%@",result);
        if ([result intValue] == 200) {
            
            
            [self getRootData:responseObject andState:self.netWorkState];
            
            
        }
        else if ([result intValue] == 410 || [result intValue] == 403){
            //            LoginViewController *loginVC = [[LoginViewController alloc] init];
            //            //            [self]
            //            [self presentViewController:loginVC animated:YES completion:^{
            //                [KeyChainStore deleteKeyData:KEY_USERTOKEN];
            //            }];
        }else{
            [self requestError];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error+++++%@",error);
        [self requestError];
    }];
}
-(void)postrequestData{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.responseSerializer =  [AFJSONResponseSerializer serializer];
    manager.requestSerializer= [AFHTTPRequestSerializer serializer];
    [manager.requestSerializer setValue:APPKEY forHTTPHeaderField:@"x-access-key"];
    NSString *idfa = [EJZUserNetWorkingTool getUUID];
    NSString *currentTime = [EJZUserNetWorkingTool getCurrentTime];
    NSString *sign = [NSString stringWithFormat:@"%@%@",currentTime,idfa];
    NSString *md5Sign = [EJZUserNetWorkingTool hashwithstring:sign];
    NSLog(@"POST   appkey:::::%@   uuidStr::::::%@   timeStr:::::::%@   md5Sign::::::::%@",APPKEY,idfa,currentTime,md5Sign);
    [manager.requestSerializer setValue:md5Sign forHTTPHeaderField:@"x-access-sign"];
    [manager.requestSerializer setValue:currentTime forHTTPHeaderField:@"x-access-timestamp"];
    NSString *token = [KeyChainStore load:KEY_USERTOKEN];
    if (token.length>0) {
        [manager.requestSerializer setValue:token forHTTPHeaderField:@"x-access-token"];
        
    }
    
    [manager POST:self.urlStr parameters:self.netWorkDict progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"=======%@",responseObject[@"message"]);
        NSString *result = responseObject[@"code"];
        NSLog(@"result::::::::%@",result);
        if ([result intValue] == 200) {
            
            
            [self getRootData:responseObject andState:self.netWorkState];
            
        }else if ([result intValue] == 410 || [result intValue] == 403){
            
        }else{
            [self requestError];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self requestError];
        NSLog(@"error::::::%@",error);
    }];
    
}
@end
