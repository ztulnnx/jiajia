//
//  EJZRegisterViewController.m
//  EJZExhibition
//
//  Created by 黄传家 on 2018/4/22.
//  Copyright © 2018年 黄传家. All rights reserved.
//

#import "EJZRegisterViewController.h"
#import "EJZNetWokingTool.h"
#import "EJZTabBarViewController.h"
@interface EJZRegisterViewController ()
@property (nonatomic,strong)UITextField *phoneTF;
@property (nonatomic,strong)UITextField *codeTF;
@property (nonatomic,strong)UITextField *passWordTF;
@property (nonatomic,strong)UIButton *getCodeBtn;
@property (nonatomic,strong)UIButton *sureBtn;
@property (nonatomic,strong)NSTimer *timer;
@property (nonatomic,assign)int countdown;
@end

@implementation EJZRegisterViewController

-(NSTimer *)timer{
    if (_timer == nil) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(run) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
        _countdown = 0;
    }
    return _timer;
}
- (void)run{
    NSLog(@"self.countdown:::%d",self.countdown);
    if (self.countdown == 59) {
        
        self.getCodeBtn.userInteractionEnabled=YES;
        [self.timer invalidate];
        self.timer = nil;
        self.countdown=0;
        self.phoneTF.enabled = YES;
        [self.getCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
        
    }else{
        
        NSString *str = [NSString stringWithFormat:@"%d秒",60-self.countdown];
        [self.getCodeBtn setTitle:str forState:UIControlStateNormal];
        self.getCodeBtn.userInteractionEnabled=NO;
        //        self.phoneTF.userInteractionEnabled = NO;
        self.phoneTF.enabled = NO;
        self.countdown++;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initAddStoreView];
}
-(void)initAddStoreView{
    UILabel *topLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, TabbarSafeNavMargin, WIDTH, 70*WRATIO)];
    topLabel.backgroundColor = [UIColor grayColor];
    topLabel.text = @"加入平台开店 挣钱更方便";
    topLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:18*WRATIO];
    topLabel.textAlignment = NSTextAlignmentCenter;
    topLabel.textColor = [UIColor whiteColor];
    //    topLabel.font = [UIFont systemFontOfSize:16*WRATIO];
    [self.view addSubview:topLabel];
    
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, TabbarSafeNavMargin+70*WRATIO, WIDTH, 150*WRATIO)];
    backView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:backView];
    
    NSArray *arr = @[@"联系人手机",@"验证码",@"密码"];
    
    for (int i = 0; i<arr.count; i++) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10*WRATIO, 10*WRATIO + i*50*WRATIO, 90*WRATIO, 30*WRATIO)];
        label.text = arr[i];
        label.textColor = [UIColor blackColor];
        label.font = [UIFont fontWithName:@"Helvetica" size:16*WRATIO];
        [backView addSubview:label];
        
        UIView *prantingView = [[UIView alloc] initWithFrame:CGRectMake(0, (i+1)*50*WRATIO-1, WIDTH, 1)];
        prantingView.backgroundColor = [UIColor colorWithRed:0.80 green:0.80 blue:0.80 alpha:1];
        [backView addSubview:prantingView];
        
    }
    self.phoneTF = [[UITextField alloc] initWithFrame:CGRectMake(100*WRATIO, 10*WRATIO, 165*WRATIO, 30*WRATIO)];
    self.phoneTF.placeholder = @"请输入手机号";
    self.phoneTF.clearButtonMode = UITextFieldViewModeAlways;
    self.phoneTF.keyboardType = UIKeyboardTypeNumberPad;
    [self.phoneTF addTarget:self action:@selector(phoneTFChange:) forControlEvents:UIControlEventEditingChanged];
    [backView addSubview:self.phoneTF];
    
    self.getCodeBtn = [[UIButton alloc] initWithFrame:CGRectMake(265*WRATIO, 10*WRATIO, 100*WRATIO, 30*WRATIO)];
    self.getCodeBtn.backgroundColor = [UIColor grayColor];
    [self.getCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    [self.getCodeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.getCodeBtn.titleLabel.font = [UIFont fontWithName:@"Helvetica" size:16*WRATIO];
    self.getCodeBtn.userInteractionEnabled = NO;
    [self.getCodeBtn addTarget:self action:@selector(getCodeClick:) forControlEvents:UIControlEventTouchUpInside];
    [backView addSubview:self.getCodeBtn];
    
    self.codeTF = [[UITextField alloc] initWithFrame:CGRectMake(100*WRATIO, 60*WRATIO, WIDTH-120*WRATIO, 30*WRATIO)];
    self.codeTF.placeholder = @"请输入验证码";
    self.codeTF.clearButtonMode = UITextFieldViewModeAlways;
    self.codeTF.keyboardType = UIKeyboardTypeNumberPad;
    [self.codeTF addTarget:self action:@selector(phoneTFChange:) forControlEvents:UIControlEventEditingChanged];
    //    [backView addSubview:self.phoneTF];
    [backView addSubview:self.codeTF];
    
    self.passWordTF = [[UITextField alloc] initWithFrame:CGRectMake(100*WRATIO, 110*WRATIO, WIDTH-120*WRATIO, 30*WRATIO)];
    self.passWordTF.placeholder = @"请输入验证码";
    self.passWordTF.clearButtonMode = UITextFieldViewModeAlways;
//    self.passWordTF.keyboardType = UIKeyboardTypeNumberPad;
    [self.passWordTF addTarget:self action:@selector(phoneTFChange:) forControlEvents:UIControlEventEditingChanged];
    //    [backView addSubview:self.phoneTF];
    [backView addSubview:self.passWordTF];
    
    self.sureBtn = [[UIButton alloc] initWithFrame:CGRectMake(15*WRATIO, TabbarSafeNavMargin+240*WRATIO, WIDTH-30*WRATIO, 40*WRATIO)];
    self.sureBtn.backgroundColor = [UIColor grayColor];
    [self.sureBtn setTitle:@"确   定" forState:UIControlStateNormal];
    [self.sureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.sureBtn addTarget:self action:@selector(sureClick:) forControlEvents:UIControlEventTouchUpInside];
    //    self.sureBtn.userInteractionEnabled = NO;
    [self.view addSubview:self.sureBtn];
    
}
-(void)phoneTFChange:(UITextField *)textfield{
    if (textfield == self.phoneTF) {
        if (self.phoneTF.text.length == 11) {
            self.getCodeBtn.backgroundColor =[UIColor blueColor];
            self.getCodeBtn.userInteractionEnabled = YES;
        }
        
    }
    if (self.phoneTF.text.length == 11 && self.codeTF.text.length > 0) {
        self.sureBtn.backgroundColor = [UIColor blueColor];
        self.sureBtn.userInteractionEnabled = YES;
    }
}
-(void)getCodeClick:(UIButton *)sender{
    if (self.phoneTF.text.length == 11) {
        [self.timer fire];
        NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
        [dict setObject:self.phoneTF.text forKey:@"phone"];
        [dict setObject:[NSNumber numberWithInt:0] forKey:@"type"];
        [self creatRequestWithUrl:SendCode andJsonString:dict andState:STATEONE withWay:1];
    }else{
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"请输入正确的手机号码" preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            self.phoneTF.text = @"";
            self.getCodeBtn.userInteractionEnabled = NO;
        }]];
        [self presentViewController:alert animated:YES completion:nil];
    }
    
}
-(void)sureClick:(UIButton *)sender{
    NSLog(@"详细信息");
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    NSString *uuidStr = [EJZNetWokingTool getUUID];
    [dict setObject:uuidStr forKey:@"unique_id"];
    [dict setObject:self.phoneTF.text forKey:@"phone"];
    [dict setObject:@"123456" forKey:@"code"];
    [dict setObject:self.passWordTF.text forKey:@"password"];
    [self creatRequestWithUrl:Register andJsonString:dict andState:STATETWO withWay:1];
}
-(void)getRootData:(NSDictionary *)dataDiction andState:(NETSTATE)state{
    if (state == STATEONE) {
        NSLog(@"dataDiction injoin::::::::::%@**********msg:%@",dataDiction,dataDiction[@"message"]);
        
    }else if (STATETWO){
        NSLog(@"dataDiction injoin::::::::::%@**********msg:%@",dataDiction,dataDiction[@"message"]);
        NSString *result = dataDiction[@"code"];
        if ([result intValue] == 200) {
            [self.timer invalidate];
            NSString *token = dataDiction[@"data"][@"token"];
            NSString *userId = dataDiction[@"data"][@"user_id"];
//            NSLog(@"token::::::%@*******%@",token,userId);
            [KeyChainStore save:KEY_USERTOKEN data:token];
            [KeyChainStore save:KEY_USERID data:userId];
            
            EJZTabBarViewController *tabBarVC = [[EJZTabBarViewController alloc] init];
//            [self.navigationController pushViewController:tabBarVC animated:YES];
            [self presentViewController:tabBarVC animated:YES completion:^{
                
            }];
            
            
//            KeyChainStore save:<#(NSString *)#> data:<#(id)#>
        }
    }
}
-(void)dealloc{
    self.timer = nil;
}
@end
