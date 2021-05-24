//
//  EJZStoreWriteViewController.m
//  EJZExhibition
//
//  Created by 黄传家 on 2018/4/18.
//  Copyright © 2018年 黄传家. All rights reserved.
//

#import "EJZStoreWriteViewController.h"
#import "EJZStoreWriteTableViewCell.h"
#import <QuartzCore/QuartzCore.h>
#import "UIAutoScrollView.h"
#import "WSImagePickerView.h"
#import "ValuePickerView.h"
#import "EJZValuePickerView.h"
@interface EJZStoreWriteViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)NSArray *dataSource;
@property (nonatomic,strong) UIAutoScrollView *tmpScrollView;
@property (nonatomic, weak)  UIViewController *weakSuper;
@property (nonatomic,strong) UIImagePickerController * imagePickerController;


@property (nonatomic, strong) WSImagePickerView *pickerPhotoView;
@property (weak, nonatomic)  NSLayoutConstraint *photoViewHieghtConstraint;

@property (nonatomic, strong) ValuePickerView *pickerView;
@property (nonatomic, strong) EJZValuePickerView *timePickerView;
@property (nonatomic, strong) NSMutableDictionary *submitDict;
@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) UITextField *storeNameTF;
@property (nonatomic, strong) UITextField *linkmanNameTF;
@property (nonatomic, strong) UITextField *linkmanPhoneTF;
@property (nonatomic, strong) UILabel *storeTypeLabel;
@property (nonatomic, strong) UILabel *openTimeLabel;
@property (nonatomic, strong) UITextField *storeAdrTF;
@property (nonatomic, strong) UILabel *deliveryWayLabel;
//@property (nonatomic,strong) NSMutableArray *photoArray;
//@property (nonatomic,strong) NSMutableArray *logoArr;

@end

@implementation EJZStoreWriteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSArray *arr = @[@{@"headerTitle":@"门店信息",@"arr":@[@{@"title":@"本店员工",@"imgUrl":@"btn_yuangong0"},@{@"title":@"本店会员",@"imgUrl":@"btn_huiyuan0"},@{@"title":@"预约本",@"imgUrl":@"btn_yuyueben0"},@{@"title":@"考勤汇总",@"imgUrl":@"btn_huizong"},@{@"title":@"明细单据",@"imgUrl":@"btn_danju"}]},
                     @{@"headerTitle":@"报表中心",@"arr":@[@{@"title":@"品项分析表",@"imgUrl":@"btn_fenxi"},@{@"title":@"财务分析表",@"imgUrl":@"btn_caiwu"},@{@"title":@"营业统计表",@"imgUrl":@"btn_yingye"},@{@"title":@"员工业绩表",@"imgUrl":@"btn_yeji"},@{@"title":@"会员排行表",@"imgUrl":@"btn_paihang"}]},
                     @{@"headerTitle":@"门店库存",@"arr":@[@{@"title":@"库存管理",@"imgUrl":@"btn_kucun"}]}];
    
    
    
    
    
    
    
    
    
    
    
    
    self.dataSource = @[@{@"groupTitle":@"基本信息",
                      @"groupContent":@[@{@"title":@"*店铺名称",@"content":@"请与门面照名称一致"},
                                    @{@"title":@"*联系人姓名",@"content":@"请与填写联系人姓名"},
                                    @{@"title":@"*联系人电话",@"content":@"请输入手机号码"},
                                    @{@"title":@"*店铺类型",@"content":@"选择"},
                                    @{@"title":@"*营业时间",@"content":@"选择"},
                                    @{@"title":@"店铺地址",@"content":@"详细至门牌号，请与营业执照地址一致"},
                                    @{@"title":@"配送方式",@"content":@"选择"}]},
                      @{@"groupTitle":@"店铺照片",
                       @"groupContent":@[@{@"title":@"*店铺logo",@"content":@"上传与店铺匹配的logo，能提升进店的概率"},
                                  @{@"title":@"*店铺照片",@"content":@"真实美观的店铺照片可以提高用户的信赖度（最多可上传3张）"}]}];
    self.submitDict = [[NSMutableDictionary alloc] init];
    self.view.backgroundColor = [UIColor whiteColor];
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, TabbarSafeNavMargin, WIDTH, HEIGHT-40*WRATIO-TabbarSafeNavMargin)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//    [self.view addSubview:self.tableView];
    
    
    
    self.pickerView = [[ValuePickerView alloc] init];
    self.timePickerView = [[EJZValuePickerView alloc] init];
    
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, TabbarSafeNavMargin, WIDTH, HEIGHT)];
    self.scrollView.delegate = self;
    //    _scrollview.backgroundColor = [UIColor redColor];
    self.scrollView.pagingEnabled = YES;
    self.scrollView.bounces = NO;
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.contentSize = CGSizeMake(WIDTH,790*WRATIO);
    [self.view addSubview:self.scrollView];
    
    
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 50*WRATIO)];
    topView.backgroundColor = [UIColor grayColor];
    [self.scrollView addSubview:topView];
    
    UILabel *topLabel = [[UILabel alloc] initWithFrame:CGRectMake(10*WRATIO, 10*WRATIO, 100*WRATIO, 30*WRATIO)];
    topLabel.text = @"基本信息";
    [topView addSubview:topLabel];
    
    NSArray *titleArr = @[@"*店铺名称",@"*联系人姓名",@"*联系人电话",@"*店铺类型",@"*营业时间",@"*店铺地址",@"*配送方式"];
    for (int i = 0; i<titleArr.count; i++) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10*WRATIO, 60*WRATIO+50*WRATIO*i, 100*WRATIO, 30*WRATIO)];
        label.text = titleArr[i];
        label.textColor = [UIColor blackColor];
        label.font = [UIFont fontWithName:@"Helvetica" size:14*WRATIO];
        [self.scrollView addSubview:label];
        
        if (i==6) {
            
        }else{
        UIView *prantingView = [[UIView alloc] initWithFrame:CGRectMake(0, 99*WRATIO+i*50*WRATIO, WIDTH, 1)];
        prantingView.backgroundColor = [UIColor colorWithRed:0.8 green:0.8 blue:0.8 alpha:1];
        [self.scrollView addSubview:prantingView];
        }
        
    }
    
    self.storeNameTF = [[UITextField alloc] initWithFrame:CGRectMake(110*WRATIO, 60*WRATIO, WIDTH-120*WRATIO, 30*WRATIO)];
    self.storeNameTF.placeholder = @"请输入店铺名称";
    self.storeNameTF.font = [UIFont fontWithName:@"Helvetica" size:14*WRATIO];
    self.storeNameTF.returnKeyType = UIReturnKeyDone;
    self.storeNameTF.delegate = self;
    self.storeNameTF.clearButtonMode = UITextFieldViewModeAlways;
    [self.scrollView addSubview:self.storeNameTF];
    
    
    self.linkmanNameTF = [[UITextField alloc] initWithFrame:CGRectMake(110*WRATIO, 110*WRATIO, WIDTH-120*WRATIO, 30*WRATIO)];
    self.linkmanNameTF.placeholder = @"请输入联系人姓名";
    self.linkmanNameTF.font = [UIFont fontWithName:@"Helvetica" size:14*WRATIO];
    self.linkmanNameTF.returnKeyType = UIReturnKeyDone;
    self.linkmanNameTF.delegate = self;
    self.linkmanNameTF.clearButtonMode = UITextFieldViewModeAlways;
    [self.scrollView addSubview:self.linkmanNameTF];
    
    self.linkmanPhoneTF = [[UITextField alloc] initWithFrame:CGRectMake(110*WRATIO, 160*WRATIO, WIDTH-120*WRATIO, 30*WRATIO)];
    self.linkmanPhoneTF.placeholder = @"请输入联系人电话";
    self.linkmanPhoneTF.font = [UIFont fontWithName:@"Helvetica" size:14*WRATIO];
    self.linkmanPhoneTF.returnKeyType = UIReturnKeyDone;
    self.linkmanPhoneTF.delegate = self;
    self.linkmanPhoneTF.clearButtonMode = UITextFieldViewModeAlways;
    [self.scrollView addSubview:self.linkmanPhoneTF];
    
    self.storeTypeLabel = [[UILabel alloc] initWithFrame:CGRectMake(110*WRATIO, 210*WRATIO, WIDTH-130*WRATIO, 30*WRATIO)];
    self.storeTypeLabel.textColor = [UIColor colorWithRed:0.8 green:0.8 blue:0.8 alpha:1];
    self.storeTypeLabel.text = @"选择";
    self.storeTypeLabel.font = [UIFont fontWithName:@"Helvetica" size:14*WRATIO];
    [self.scrollView addSubview:self.storeTypeLabel];
    UIImageView *storeTypeImgView = [[UIImageView alloc] initWithFrame:CGRectMake(WIDTH-20*WRATIO, 220*WRATIO, 5*WRATIO, 10*WRATIO)];
    storeTypeImgView.image = [UIImage imageNamed:@"arrows"];
    [self.scrollView addSubview:storeTypeImgView];
    
    UIButton *storeBtn = [[UIButton alloc] initWithFrame:CGRectMake(110*WRATIO, 200*WRATIO, WIDTH-110*WRATIO, 50*WRATIO)];
    [storeBtn addTarget:self action:@selector(storeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.scrollView addSubview:storeBtn];
    
    self.openTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(110*WRATIO, 260*WRATIO, WIDTH-130*WRATIO, 30*WRATIO)];
    self.openTimeLabel.textColor = [UIColor colorWithRed:0.8 green:0.8 blue:0.8 alpha:1];
    self.openTimeLabel.text = @"选择";
    self.openTimeLabel.font = [UIFont fontWithName:@"Helvetica" size:14*WRATIO];
    [self.scrollView addSubview:self.openTimeLabel];
    
    UIImageView *openTimeImgView = [[UIImageView alloc] initWithFrame:CGRectMake(WIDTH-20*WRATIO, 270*WRATIO, 5*WRATIO, 10*WRATIO)];
    openTimeImgView.image = [UIImage imageNamed:@"arrows"];
    [self.scrollView addSubview:openTimeImgView];
    
    UIButton *openTimeBtn = [[UIButton alloc] initWithFrame:CGRectMake(110*WRATIO, 250*WRATIO, WIDTH-110*WRATIO, 50*WRATIO)];
    [openTimeBtn addTarget:self action:@selector(openTimeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.scrollView addSubview:openTimeBtn];
    
    self.storeAdrTF = [[UITextField alloc] initWithFrame:CGRectMake(110*WRATIO, 310*WRATIO, WIDTH-120*WRATIO, 30*WRATIO)];
    self.storeAdrTF.placeholder = @"请输入联系人电话";
    self.storeAdrTF.font = [UIFont fontWithName:@"Helvetica" size:14*WRATIO];
    self.storeAdrTF.returnKeyType = UIReturnKeyDone;
    self.storeAdrTF.delegate = self;
    self.storeAdrTF.clearButtonMode = UITextFieldViewModeAlways;
    [self.scrollView addSubview:self.storeAdrTF];
    
    self.deliveryWayLabel = [[UILabel alloc] initWithFrame:CGRectMake(110*WRATIO, 360*WRATIO, WIDTH-130*WRATIO, 30*WRATIO)];
    self.deliveryWayLabel.textColor = [UIColor colorWithRed:0.8 green:0.8 blue:0.8 alpha:1];
    self.deliveryWayLabel.text = @"选择";
    self.deliveryWayLabel.font = [UIFont fontWithName:@"Helvetica" size:14*WRATIO];
    [self.scrollView addSubview:self.deliveryWayLabel];
    
    UIImageView *deliveryWayeImgView = [[UIImageView alloc] initWithFrame:CGRectMake(WIDTH-20*WRATIO, 370*WRATIO, 5*WRATIO, 10*WRATIO)];
    deliveryWayeImgView.image = [UIImage imageNamed:@"arrows"];
    [self.scrollView addSubview:deliveryWayeImgView];
    
    UIButton *deliveryWayBtn = [[UIButton alloc] initWithFrame:CGRectMake(110*WRATIO, 350*WRATIO, WIDTH-110*WRATIO, 50*WRATIO)];
    [deliveryWayBtn addTarget:self action:@selector(deliveryWayBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.scrollView addSubview:deliveryWayBtn];
    
    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, 400*WRATIO, WIDTH, 50*WRATIO)];
    bottomView.backgroundColor = [UIColor grayColor];
    [self.scrollView addSubview:bottomView];
    
    UILabel *bottomLabel = [[UILabel alloc] initWithFrame:CGRectMake(10*WRATIO, 10*WRATIO, 100*WRATIO, 30*WRATIO)];
    bottomLabel.text = @"店铺照片";
    [bottomView addSubview:bottomLabel];
    
    UILabel *logoLabel = [[UILabel alloc] initWithFrame:CGRectMake(10*WRATIO, 460*WRATIO, 120*WRATIO, 30*WRATIO)];
    logoLabel.text = @"*店铺logo";
    logoLabel.textColor = [UIColor blackColor];
    logoLabel.font = [UIFont fontWithName:@"Helvetica" size:14*WRATIO];
    [self.scrollView addSubview:logoLabel];
    
    UILabel *logoHintLabel = [[UILabel alloc] initWithFrame:CGRectMake(10*WRATIO, 490*WRATIO, WIDTH-80*WRATIO, 20*WRATIO)];
    logoHintLabel.text = @"上传与店铺匹配的logo，能提升进店的效率";
    logoHintLabel.textColor = [UIColor colorWithRed:0.8 green:0.8 blue:0.8 alpha:1];
//    self.storeTypeLabel.text = @"选择";
    logoHintLabel.font = [UIFont fontWithName:@"Helvetica" size:14*WRATIO];
    [self.scrollView addSubview:logoHintLabel];
    
    WSImagePickerConfig *config = [WSImagePickerConfig new];
    config.itemSize = CGSizeMake(60*WRATIO, 60*WRATIO);
    config.photosMaxCount = 1;
    
    WSImagePickerView *pickerView = [[WSImagePickerView alloc] initWithFrame:CGRectMake(WIDTH-70*WRATIO, 460*WRATIO, 60*WRATIO, 0) config:config];
    pickerView.backgroundColor = [UIColor clearColor];
    //Height changed with photo selection
    __weak typeof(self) weakSelf = self;
    pickerView.viewHeightChanged = ^(CGFloat height) {
        weakSelf.photoViewHieghtConstraint.constant = height;
        [weakSelf.view setNeedsLayout];
        [weakSelf.view layoutIfNeeded];
    };
    pickerView.navigationController = self.navigationController;
//    self.pickerPhotoView = pickerView;
    //refresh superview height
    [pickerView refreshImagePickerViewWithPhotoArray:nil];
    [self.scrollView addSubview:pickerView];
    pickerView.getPhotosArrs = ^(NSArray *arr) {
        NSLog(@"%@",arr);
        [self creatRequestWithUrl:UpLoad andphotos:arr andState:STATEONE withWay:3];
    };
    
    UIView *logoPrantingView = [[UIView alloc] initWithFrame:CGRectMake(0, 539*WRATIO, WIDTH, 1)];
    logoPrantingView.backgroundColor = [UIColor colorWithRed:0.8 green:0.8 blue:0.8 alpha:1];
    [self.scrollView addSubview:logoPrantingView];
    
    
    UILabel *imgLabel = [[UILabel alloc] initWithFrame:CGRectMake(10*WRATIO, 540*WRATIO, 120*WRATIO, 30*WRATIO)];
    imgLabel.text = @"*店铺照片";
    imgLabel.textColor = [UIColor blackColor];
    imgLabel.font = [UIFont fontWithName:@"Helvetica" size:14*WRATIO];
    [self.scrollView addSubview:imgLabel];
    
    UILabel *imgHintLabel = [[UILabel alloc] initWithFrame:CGRectMake(10*WRATIO, 570*WRATIO, WIDTH-80*WRATIO, 40*WRATIO)];
    imgHintLabel.text = @"真实美观的店铺照片可以提高用户的信赖度（最多可上传3张）";
    imgHintLabel.textColor = [UIColor colorWithRed:0.8 green:0.8 blue:0.8 alpha:1];
    //    self.storeTypeLabel.text = @"选择";
    imgHintLabel.numberOfLines = 0;
    imgHintLabel.font = [UIFont fontWithName:@"Helvetica" size:14*WRATIO];
    [self.scrollView addSubview:imgHintLabel];
    
    WSImagePickerConfig *config1 = [WSImagePickerConfig new];
    config1.itemSize = CGSizeMake(60*WRATIO, 60*WRATIO);
    config1.photosMaxCount = 3;
    
    WSImagePickerView *pickerView1 = [[WSImagePickerView alloc] initWithFrame:CGRectMake(0, 610*WRATIO, self.view.frame.size.width, 0) config:config1];
    pickerView1.backgroundColor = [UIColor clearColor];
    //Height changed with photo selection
//    __weak typeof(self) weakSelf = self;
    pickerView1.viewHeightChanged = ^(CGFloat height) {
        weakSelf.photoViewHieghtConstraint.constant = height;
        [weakSelf.view setNeedsLayout];
        [weakSelf.view layoutIfNeeded];
    };
    pickerView1.navigationController = self.navigationController;
    //    self.pickerPhotoView = pickerView;
    //refresh superview height
    [pickerView1 refreshImagePickerViewWithPhotoArray:nil];
    [self.scrollView addSubview:pickerView1];
    pickerView1.getPhotosArrs = ^(NSArray *arr) {
        [self creatRequestWithUrl:UpLoad andphotos:arr andState:STATEONE withWay:3];
    };
    
    UIButton *sumbitBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 690*WRATIO, WIDTH, 40*WRATIO)];
    sumbitBtn.backgroundColor = [UIColor grayColor];
    [sumbitBtn setTitle:@"下一步" forState:UIControlStateNormal];
    [sumbitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [sumbitBtn addTarget:self action:@selector(sumbitClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.scrollView addSubview:sumbitBtn];
    
    
}
-(void)storeBtnClick:(UIButton *)sender{
    [self.view endEditing:YES];
    self.pickerView.dataSource = @[@"快餐店",@"便利店",@"五金店",@"建材店"];
    self.pickerView.pickerTitle = @"店铺类型";
    __weak typeof(self) weakSelf = self;
    self.pickerView.valueDidSelect = ^(NSString *value){
        NSArray * stateArr = [value componentsSeparatedByString:@"/"];
        weakSelf.storeTypeLabel.text = [NSString stringWithFormat:@"%@",stateArr[0]];
        weakSelf.storeTypeLabel.textColor = [UIColor blackColor];
    };
    self.pickerView.hidden = ^{
        
    };
    [self.pickerView show];

}
-(void)openTimeBtnClick:(UIButton *)sender{
    [self.view endEditing:YES];
    self.timePickerView.dataSource = @[@"00:00",@"01:00",@"02:00",@"03:00",@"04:00",@"05:00",@"06:00",@"07:00",@"08:00",@"09:00",@"10:00",@"11:00",@"12:00",@"13:00",@"14:00",@"15:00",@"16:00",@"17:00",@"18:00",@"19:00",@"20:00",@"21:00",@"22:00",@"23:00"];
    self.timePickerView.pickerTitle = @"选择时间";
    __weak typeof(self) weakSelf = self;
    self.timePickerView.valueDidSelect = ^(NSString *startTime, NSString *endTime) {
        NSLog(@"startTime******%@endTime********%@",startTime,endTime);
        weakSelf.openTimeLabel.text = [NSString stringWithFormat:@"%@-%@",startTime,endTime];
        weakSelf.openTimeLabel.textColor = [UIColor blackColor];
    };
    self.timePickerView.hidden = ^(){
        
        //                        [weakSelf.segement setNullSelect];
    };
    [self.timePickerView show];
}
-(void)deliveryWayBtnClick:(UIButton *)sender{
    [UIView animateWithDuration:0.1 delay:0 options:UIViewAnimationOptionAllowUserInteraction|UIViewAnimationOptionCurveLinear animations:^{
        self.scrollView.transform = CGAffineTransformMakeTranslation(0,-50*WRATIO);
    }completion:nil];
    self.pickerView.dataSource = @[@"商家配送",@"平台配送"];
    self.pickerView.pickerTitle = @"选择类型";
    __weak typeof(self) weakSelf = self;
    self.pickerView.valueDidSelect = ^(NSString *value){
        NSArray * stateArr = [value componentsSeparatedByString:@"/"];
        weakSelf.deliveryWayLabel.text = [NSString stringWithFormat:@"%@",stateArr[0]];
        weakSelf.deliveryWayLabel.textColor = [UIColor blackColor];
        NSLog(@"配送方式:::::::::%@",stateArr[1]);
        [UIView animateWithDuration:0.1 delay:0 options:UIViewAnimationOptionAllowUserInteraction|UIViewAnimationOptionCurveLinear animations:^{
            weakSelf.scrollView.transform = CGAffineTransformMakeTranslation(0,0);
        }completion:nil];
    };
    self.pickerView.hidden = ^(){
        [UIView animateWithDuration:0.1 delay:0 options:UIViewAnimationOptionAllowUserInteraction|UIViewAnimationOptionCurveLinear animations:^{
            weakSelf.scrollView.transform = CGAffineTransformMakeTranslation(0,0);
        }completion:nil];
        //                        [weakSelf.segement setNullSelect];
    };
    [self.pickerView show];
    
}
-(void)sumbitClick:(UIButton *)sender{
//    NSIndexPath *cellOneIndex = [NSIndexPath indexPathForRow:0 inSection:0];
//    EJZStoreWriteTableViewCell *cellOne = (EJZStoreWriteTableViewCell *)[self.tableView cellForRowAtIndexPath:cellOneIndex];
//    NSString *nameStr = [NSString stringWithFormat:@"%@",cellOne.msgTF.text];
//    if ([nameStr isEqualToString:@"(null)"]) {
//        NSLog(@"nameStr:::::%@",nameStr);
//        [self alertShow:@"请输入店铺名字"];
//    }else{
//        //参数加入到字典
//        [self.submitDict setObject:@"" forKey:@""];
//    }
//
//    NSIndexPath *cellTwoIndex = [NSIndexPath indexPathForRow:1 inSection:0];
//    EJZStoreWriteTableViewCell *cellTwo = (EJZStoreWriteTableViewCell *)[self.tableView cellForRowAtIndexPath:cellTwoIndex];
//    NSString *nameStore = [NSString stringWithFormat:@"%@",cellTwo.msgTF.text];
//    if ([nameStore isEqualToString:@"(null)"]) {
//        NSLog(@"nameStr:::::%@",nameStore);
//        [self alertShow:@"请输入店主名字"];
//    }else{
//        //参数加入到字典
//        [self.submitDict setObject:@"" forKey:@""];
//    }
//
//    NSIndexPath *cellThreeIndex = [NSIndexPath indexPathForRow:2 inSection:0];
//    EJZStoreWriteTableViewCell *cellThree = (EJZStoreWriteTableViewCell *)[self.tableView cellForRowAtIndexPath:cellThreeIndex];
//    NSString *phoneStr = [NSString stringWithFormat:@"%@",cellThree.msgTF.text];
//    if ([phoneStr isEqualToString:@"(null)"]) {
//        NSLog(@"nameStr:::::%@",phoneStr);
//        [self alertShow:@"请输入电话号码"];
//    }else{
//        //参数加入到字典
//        [self.submitDict setObject:@"" forKey:@""];
//    }
//
//    NSIndexPath *cellfourIndex = [NSIndexPath indexPathForRow:3 inSection:0];
//    EJZStoreWriteTableViewCell *cellFour = (EJZStoreWriteTableViewCell *)[self.tableView cellForRowAtIndexPath:cellfourIndex];
//    NSString *typeStr = [NSString stringWithFormat:@"%@",cellFour.msgLabel.text];
//    if ([typeStr isEqualToString:@"(null)"]) {
//        NSLog(@"nameStr:::::%@",typeStr);
//        [self alertShow:@"请输入电话号码"];
//    }else{
//        //参数加入到字典
//        [self.submitDict setObject:@"" forKey:@""];
//    }
    
}
-(void)alertShow:(NSString *)msgStr{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:msgStr preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
    }]];
    [self presentViewController:alert animated:YES completion:nil];
}
//多少组
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return self.dataSource.count;
    
}
//每组多少行
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSDictionary *dict = self.dataSource[section];
    NSArray *arr = dict[@"groupContent"];
    return arr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"StoreWriteCell";
//    EJZStoreWriteTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
//    EJZStoreWriteTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    EJZStoreWriteTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (nil == cell) {
      cell = [[EJZStoreWriteTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
//    EJZStoreWriteTableViewCell *cell = [[EJZStoreWriteTableViewCell alloc]init];
    NSDictionary *dict = self.dataSource[indexPath.section];
    NSArray *arr = dict[@"groupContent"];
    NSDictionary *modelDict = arr[indexPath.row];
    cell.titleLabel.text = modelDict[@"title"];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    switch (indexPath.section) {
        case 0:{
            switch (indexPath.row) {
                case 0:
                {
                    cell.msgLabel.hidden = YES;
                    cell.msgTF.placeholder = modelDict[@"content"];
                    cell.msgTF.returnKeyType = UIReturnKeyDone;
                    cell.msgTF.delegate = self;
                    cell.addBtn.hidden = YES;
                }
                    break;
                case 1:
                {
                    cell.msgLabel.hidden = YES;
                    cell.msgTF.placeholder = modelDict[@"content"];
                    cell.msgTF.returnKeyType = UIReturnKeyDone;
                    cell.msgTF.delegate = self;
                    cell.addBtn.hidden = YES;
                }
                    break;
                case 2:
                {
                    cell.msgLabel.hidden = YES;
                    cell.msgTF.placeholder = modelDict[@"content"];
                    cell.msgTF.returnKeyType = UIReturnKeyDone;
                    cell.msgTF.delegate = self;
                    cell.addBtn.hidden = YES;
                }
                    break;
                case 3:
                {
//                    cell.msgTF.userInteractionEnabled = NO;
                    cell.msgTF.hidden = YES;
                    cell.msgLabel.text = modelDict[@"content"];
                    [cell.addBtn setImage:[UIImage imageNamed:@"arrows"] forState:UIControlStateNormal];
                }
                    break;
                case 4:
                {
                    cell.msgTF.hidden = YES;
//                    cell.msgTF.hidden = YES;
                    cell.msgLabel.text = modelDict[@"content"];
                    [cell.addBtn setImage:[UIImage imageNamed:@"arrows"] forState:UIControlStateNormal];
                }
                    break;
                case 5:
                {
                    cell.msgLabel.hidden = YES;
                    cell.msgTF.placeholder = modelDict[@"content"];
                    cell.msgTF.returnKeyType = UIReturnKeyDone;
                    cell.msgTF.delegate = self;
                    cell.addBtn.hidden = YES;
                    cell.msgTF.tag = 1000;
                }
                    break;
                case 6:
                {
                    cell.msgTF.hidden = YES;
                    cell.msgLabel.text = modelDict[@"content"];
                    [cell.addBtn setImage:[UIImage imageNamed:@"arrows"] forState:UIControlStateNormal];
                }
                    break;

                    
                default:
                    break;
            }
        }
            
            break;
        case 1:
        {
            switch (indexPath.row) {
                case 0:
                {
                    cell.prantingView.frame = CGRectMake(0, 84*WRATIO-1, WIDTH, 1);
                    cell.msgTF.hidden = YES;
                    cell.msgLabel.text = modelDict[@"content"];
                    cell.msgLabel.frame = CGRectMake(10*WRATIO, 30*WRATIO, WIDTH-90*WRATIO, 30*WRATIO);
                    cell.msgLabel.font = [UIFont fontWithName:@"Helvetica" size:12*WRATIO];
                    cell.addBtn.frame = CGRectMake(WIDTH-70*WRATIO, 12*WRATIO, 60*WRATIO, 60*WRATIO);
//                    cell.addBtn.backgroundColor = [UIColor redColor];
                    
//                    self.logoArr = [NSMutableArray array];
                    
//                    if (self.pickerPhotoView == nil) {
                        WSImagePickerConfig *config = [WSImagePickerConfig new];
                        config.itemSize = CGSizeMake(60*WRATIO, 60*WRATIO);
                        config.photosMaxCount = 1;
                        
                        WSImagePickerView *pickerView = [[WSImagePickerView alloc] initWithFrame:CGRectMake(WIDTH-70*WRATIO, 2*WRATIO, 60*WRATIO, 0) config:config];
                        pickerView.backgroundColor = [UIColor clearColor];
                        //Height changed with photo selection
                        __weak typeof(self) weakSelf = self;
                        pickerView.viewHeightChanged = ^(CGFloat height) {
                            weakSelf.photoViewHieghtConstraint.constant = height;
                            [weakSelf.view setNeedsLayout];
                            [weakSelf.view layoutIfNeeded];
                        };
                        pickerView.navigationController = self.navigationController;
                         self.pickerPhotoView = pickerView;
                        //refresh superview height
                        [pickerView refreshImagePickerViewWithPhotoArray:nil];
                        [cell addSubview:pickerView];
                        pickerView.getPhotosArrs = ^(NSArray *arr) {
        
                            [self creatRequestWithUrl:UpLoad andphotos:arr andState:STATEONE withWay:3];
                        };
                }
                    break;
                case 1:
                {
                    cell.addBtn.hidden = YES;
                    cell.prantingView.frame = CGRectMake(0, 135*WRATIO-1, WIDTH, 1);
                    cell.msgTF.hidden = YES;
                    cell.msgLabel.text = modelDict[@"content"];
                    cell.msgLabel.frame = CGRectMake(10*WRATIO, 30*WRATIO, WIDTH-20*WRATIO, 30*WRATIO);
                    cell.msgLabel.font = [UIFont fontWithName:@"Helvetica" size:12*WRATIO];
                    
                    
//                    self.photoArray = [NSMutableArray array];
                    WSImagePickerConfig *config = [WSImagePickerConfig new];
                    config.itemSize = CGSizeMake(60*WRATIO, 60*WRATIO);
                    config.photosMaxCount = 3;

                    WSImagePickerView *pickerView = [[WSImagePickerView alloc] initWithFrame:CGRectMake(0, 55*WRATIO, self.view.frame.size.width, 0) config:config];
                    pickerView.backgroundColor = [UIColor clearColor];
                    //Height changed with photo selection
                    __weak typeof(self) weakSelf = self;
                    pickerView.viewHeightChanged = ^(CGFloat height) {
                        weakSelf.photoViewHieghtConstraint.constant = height;
                        [weakSelf.view setNeedsLayout];
                        [weakSelf.view layoutIfNeeded];
                    };
                    pickerView.navigationController = self.navigationController;
                    self.pickerPhotoView = pickerView;

                    //refresh superview height
                    [pickerView refreshImagePickerViewWithPhotoArray:nil];
                    [cell addSubview:self.pickerPhotoView];
                    pickerView.getPhotosArrs = ^(NSArray *arr) {
                        NSLog(@"arr:::::%@",arr);
                        [self creatRequestWithUrl:UpLoad andphotos:arr andState:STATETWO withWay:3];

                    };


                }
                    
                    break;
                    
                default:
                    break;
            }
        }
            break;

            
        default:
            break;
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    EJZStoreWriteTableViewCell *cell = (EJZStoreWriteTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    switch (indexPath.section) {
        case 0:{
            switch (indexPath.row) {
                case 0:
                {
                    
                }
                    break;
                case 1:
                {
                }
                    break;
                case 2:
                {
                }
                    break;
                case 3:
                {
                    [self.view endEditing:YES];
                    self.pickerView.dataSource = @[@"快餐店",@"便利店",@"五金店",@"建材店"];
                    self.pickerView.pickerTitle = @"店铺类型";
                    self.pickerView.valueDidSelect = ^(NSString *value){
                        NSArray * stateArr = [value componentsSeparatedByString:@"/"];
                        cell.msgLabel.text = [NSString stringWithFormat:@"%@",stateArr[0]];
                    };
                    self.pickerView.hidden = ^{
                        
                    };
                    [self.pickerView show];
                }
                    break;
                case 4:
                {
                    [self.view endEditing:YES];
                    self.timePickerView.dataSource = @[@"00:00",@"01:00",@"02:00",@"03:00",@"04:00",@"05:00",@"06:00",@"07:00",@"08:00",@"09:00",@"10:00",@"11:00",@"12:00",@"13:00",@"14:00",@"15:00",@"16:00",@"17:00",@"18:00",@"19:00",@"20:00",@"21:00",@"22:00",@"23:00"];
                    self.timePickerView.pickerTitle = @"选择时间";
                    self.timePickerView.valueDidSelect = ^(NSString *startTime, NSString *endTime) {
                        NSLog(@"startTime******%@endTime********%@",startTime,endTime);
                        cell.msgLabel.text = [NSString stringWithFormat:@"%@-%@",startTime,endTime];
                    };
                    self.timePickerView.hidden = ^(){
                        
//                        [weakSelf.segement setNullSelect];
                    };
                    [self.timePickerView show];
                }
                    break;
                case 5:
                {
                }
                    break;
                case 6:
                {
                    [self.view endEditing:YES];
                    [UIView animateWithDuration:0.1 delay:0 options:UIViewAnimationOptionAllowUserInteraction|UIViewAnimationOptionCurveLinear animations:^{
                        self.tableView.transform = CGAffineTransformMakeTranslation(0,-120*WRATIO);
                    }completion:nil];
                    self.pickerView.dataSource = @[@"商家配送",@"平台配送"];
                    self.pickerView.pickerTitle = @"选择类型";
                    self.pickerView.valueDidSelect = ^(NSString *value){
                        NSArray * stateArr = [value componentsSeparatedByString:@"/"];
                        cell.msgLabel.text = [NSString stringWithFormat:@"%@",stateArr[0]];
                        NSLog(@"配送方式:::::::::%@",stateArr[1]);
                        [UIView animateWithDuration:0.1 delay:0 options:UIViewAnimationOptionAllowUserInteraction|UIViewAnimationOptionCurveLinear animations:^{
                            tableView.transform = CGAffineTransformMakeTranslation(0,0);
                        }completion:nil];
                    };
                    self.pickerView.hidden = ^(){
                        [UIView animateWithDuration:0.1 delay:0 options:UIViewAnimationOptionAllowUserInteraction|UIViewAnimationOptionCurveLinear animations:^{
                            tableView.transform = CGAffineTransformMakeTranslation(0,0);
                        }completion:nil];
//                        [weakSelf.segement setNullSelect];
                    };
                    [self.pickerView show];
                    
                }
                    break;
                    
                default:
                    break;
            }
        }
            
            break;
        case 1:
        {
            switch (indexPath.row) {
                case 0:
                {
                }
                    break;
                case 1:
                {
                }
                    
                    break;
                    
                default:
                    break;
            }
        }
            break;
            
            
        default:
            break;
    }
}
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    if (textField.tag == 1000) {
        [UIView animateWithDuration:0.1 delay:0 options:UIViewAnimationOptionAllowUserInteraction|UIViewAnimationOptionCurveLinear animations:^{
            self.tableView.transform = CGAffineTransformMakeTranslation(0,-150*WRATIO);
        }completion:nil];
    }
    return YES;
}
-(BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    if (textField.tag == 1000) {
        [UIView animateWithDuration:0.1 delay:0 options:UIViewAnimationOptionAllowUserInteraction|UIViewAnimationOptionCurveLinear animations:^{
            self.tableView.transform = CGAffineTransformMakeTranslation(0,0);
        }completion:nil];
    }
    return YES;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *backView = [[UIView alloc] initWithFrame:CGRectZero];
    backView.backgroundColor = [UIColor grayColor];
    
    UILabel *titileLabel = [[UILabel alloc] initWithFrame:CGRectMake(10*WRATIO, 10*WRATIO, 200*WRATIO, 30*WRATIO)];
//    titileLabel.backgroundColor = [UIColor grayColor];
    NSDictionary *dict = self.dataSource[section];
    NSString *str = dict[@"groupTitle"];
    titileLabel.text = str;
    [backView addSubview:titileLabel];
    
    
    return backView;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return  nil;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        return 50*WRATIO;
    }else{
        if (indexPath.row == 0) {
            return 84*WRATIO;
        }else{
            return 135*WRATIO;
        }
    }
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0;
}
//section的header view的高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 44*WRATIO;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [textField resignFirstResponder];//取消第一响应者
    
    return YES;
}
-(void)getPhotoData:(NSArray *)idArr andState:(NETSTATE)state{
    if (STATEONE == state) {
        NSLog(@"idArr:::::::%@",idArr);
        NSString *logoPhotoNum = idArr[0];
        int logoNum = [logoPhotoNum intValue];
        [self.submitDict setValue:[NSNumber numberWithInt:logoNum] forKey:@"logo_id"];
    }else if (STATETWO){
        NSLog(@"idArrImage:::::%@",idArr);
        [self.submitDict setObject:idArr forKey:@"image_ids"];
    }
}
@end
