//
//  EJZRootViewController.m
//  EJZExhibition
//
//  Created by 黄传家 on 2018/3/14.
//  Copyright © 2018年 黄传家. All rights reserved.
//

#import "EJZRootViewController.h"
#import "EJZNetWokingTool.h"
#import "EJZLoginViewController.h"
@interface EJZRootViewController ()
@property (nonatomic,strong)NSString *urlStr;
@property (nonatomic,strong)NSDictionary *netWorkDict;
@property (nonatomic,strong)NSArray *upFileArr;
@property (nonatomic,strong)NSMutableArray *photosIdArr;
@property (nonatomic,assign)NETSTATE netWorkState;
@property (nonatomic,assign)int netWorkWay;

@end

@implementation EJZRootViewController
-(NSMutableArray *)photosIdArr{
    if (_photosIdArr == nil) {
        _photosIdArr = [NSMutableArray array];
    }
    return _photosIdArr;
}
- (void)viewDidLoad {
    [super viewDidLoad];
//    self.photosIdArr = [NSMutableArray array];
    
}
- (void)getRootData:(NSDictionary*)dataDiction andState:(NETSTATE)state{
    
}
- (void)requestError{
    
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
    }else{
        [self upDateFile];
    }
    
}
-(void)getrequestData{
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer =  [AFJSONResponseSerializer serializer];
    [manager.requestSerializer setValue:APPKEY forHTTPHeaderField:@"x-access-key"];
    NSString *idfa = [EJZNetWokingTool getUUID];
    NSString *currentTime = [EJZNetWokingTool getCurrentTime];
    NSString *sign = [NSString stringWithFormat:@"%@%@",currentTime,idfa];
    NSString *md5Sign = [EJZNetWokingTool hashwithstring:sign];
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
            EJZLoginViewController *loginVC = [[EJZLoginViewController alloc] init];
            //            [self]
            [self presentViewController:loginVC animated:YES completion:^{
                [KeyChainStore deleteKeyData:KEY_USERTOKEN];
            }];
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
    NSString *idfa = [EJZNetWokingTool getUUID];
    NSString *currentTime = [EJZNetWokingTool getCurrentTime];
    NSString *sign = [NSString stringWithFormat:@"%@%@",currentTime,idfa];
    NSString *md5Sign = [EJZNetWokingTool hashwithstring:sign];
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
           
        }else if ([result intValue] == 410 || [result intValue] == 403){
            EJZLoginViewController *loginVC = [[EJZLoginViewController alloc] init];
            //            [self]
            [self presentViewController:loginVC animated:YES completion:^{
                [KeyChainStore deleteKeyData:KEY_USERTOKEN];
            }];
        }else{
            [self requestError];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self requestError];
        NSLog(@"error::::::%@",error);
    }];
    
}
-(void)upDateFile{
    NSLog(@"upFileArr:::::%@",self.upFileArr);
//    self.photosIdArr = [NSMutableArray array];
       [self.photosIdArr removeAllObjects];
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        
        manager.responseSerializer =  [AFJSONResponseSerializer serializer];
        manager.requestSerializer= [AFHTTPRequestSerializer serializer];
        [manager.requestSerializer setValue:APPKEY forHTTPHeaderField:@"x-access-key"];
        NSString *idfa = [EJZNetWokingTool getUUID];
        NSString *currentTime = [EJZNetWokingTool getCurrentTime];
        NSString *sign = [NSString stringWithFormat:@"%@%@",currentTime,idfa];
        NSString *md5Sign = [EJZNetWokingTool hashwithstring:sign];
        NSLog(@"POST   appkey:::::%@   uuidStr::::::%@   timeStr:::::::%@   md5Sign::::::::%@",APPKEY,idfa,currentTime,md5Sign);
        [manager.requestSerializer setValue:md5Sign forHTTPHeaderField:@"x-access-sign"];
        [manager.requestSerializer setValue:currentTime forHTTPHeaderField:@"x-access-timestamp"];
        NSString *token = [KeyChainStore load:KEY_USERTOKEN];
        NSLog(@"token:::::%@",token);
        if (token.length>0) {
            [manager.requestSerializer setValue:token forHTTPHeaderField:@"x-access-token"];
            
        }
        manager.requestSerializer.timeoutInterval = 20;
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain", @"multipart/form-data", @"application/json", @"text/html", @"image/jpeg", @"image/png", @"application/octet-stream", @"text/json", nil];
        
//        __block int blockI = i;
        [manager POST:self.urlStr parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
            //取出单张图片二进制数据
//            UIImage *img = [UIImage imageNamed:[NSString stringWithFormat:@"%d",blockI+1]];
//            if (img) {
            
                //                UIImage *image = headImage[i];
//                NSData *imageData = UIImageJPEGRepresentation(img, 0.5);
                
                // 在网络开发中，上传文件时，是文件不允许被覆盖，文件重名
                // 要解决此问题，
                // 可以在上传时使用当前的系统事件作为文件名
            for(int i = 0; i < self.upFileArr.count; i++)
            {
                
                NSLog(@"hfahogajgjadlgorijgioergnfdnvmdf");
                NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                // 设置时间格式
                [formatter setDateFormat:@"yyyyMMddHHmmss"];
                NSString *dateString = [formatter stringFromDate:[NSDate date]];
                NSString *fileName = [NSString  stringWithFormat:@"%@.jpg", dateString];
                /*
                 *该方法的参数
                 1. appendPartWithFileData：要上传的照片[二进制流]
                 2. name：对应网站上[upload.php中]处理文件的字段（比如upload）
                 3. fileName：要保存在服务器上的文件名
                 4. mimeType：上传的文件的类型
                 */
                UIImage *image = self.upFileArr[i];
                NSData  * imageData = UIImageJPEGRepresentation(image,0.5);
                [formData appendPartWithFileData:imageData name:@"file" fileName:fileName mimeType:@"image/jpeg"]; //
            }
        } progress:^(NSProgress * _Nonnull uploadProgress) {
        
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSString *result = responseObject[@"code"];
            if ([result intValue] == 200) {
                NSString *idStr = responseObject[@"data"][@"id"];
                [self.photosIdArr addObject:idStr];
                NSLog(@"photosIdArr********%@",self.photosIdArr);
                if (self.photosIdArr.count == self.upFileArr.count) {
                    [self getPhotoData:self.photosIdArr andState:self.netWorkState];
                }
            }else if ([result intValue] == 410 || [result intValue] == 403){
                EJZLoginViewController *loginVC = [[EJZLoginViewController alloc] init];
                [self presentViewController:loginVC animated:YES completion:^{
                    [KeyChainStore deleteKeyData:KEY_USERTOKEN];
                }];
            }else{
                [self requestError];
            }
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"error::::::::::%@",error);
            [self requestError];
        }];
    
}
-(void)getPhotoData:(NSArray *)idArr andState:(NETSTATE)state{
    
}
@end
