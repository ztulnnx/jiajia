//
//  EJZValuePickerView.m
//  EJZExhibition
//
//  Created by 黄传家 on 2018/4/22.
//  Copyright © 2018年 黄传家. All rights reserved.
//

#import "EJZValuePickerView.h"
//#import "NewSkyHeader.h"
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)
#define HEIGHT_OF_POPBOX (([UIScreen mainScreen].bounds.size.width == 414)?290:280)
#define HEIGHT_PICKER HEIGHT_OF_POPBOX - 160 + self.dataSource.count * 20

#define COLOR_BACKGROUD_GRAY    [UIColor colorWithRed:238/255.0f green:238/255.0f blue:238/255.0f alpha:1]



@interface EJZValuePickerView ()<UIPickerViewDataSource, UIPickerViewDelegate>

@property (nonatomic ,strong) UIView * bottomView;       //底层视图
@property (nonatomic ,strong) UIPickerView * statePicker;//运营状态轱辘
@property (nonatomic ,strong) UIView * controllerToolBar;//控制工具栏
@property (nonatomic ,strong) UIButton * finishBtn;      //取消按钮
@property (nonatomic ,strong) UIButton * cancelBtn;      //取消按钮
@property (nonatomic ,strong) UILabel * titleLabel;      //标题
@property (nonatomic ,strong) NSString * stateStr;       //选中的运营状态
@property (nonatomic, assign) NSInteger pickerHeight;    //弹层的高度
@property (nonatomic,strong) NSString *startTime;
@property (nonatomic,strong) NSString *endTime;

@end
@implementation EJZValuePickerView

- (instancetype)init
{
    if (self = [super initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)]) {
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
        self.userInteractionEnabled = YES;
        [self addSubview:self.maskView];
        self.pickerHeight = HEIGHT_OF_POPBOX - 160;
        //初始化子视图
        [self initSubViews];
    }
    return self;
}

/**初始化子视图*/
- (void)initSubViews
{
    //初始化轱辘的位置
    self.bottomView = [[UIView alloc] init];
    self.bottomView.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.bottomView];
    
    //选择器
    self.statePicker = [[UIPickerView alloc] init];
    self.statePicker.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
    self.statePicker.backgroundColor = [UIColor whiteColor];
    self.statePicker.showsSelectionIndicator = YES;
    self.statePicker.dataSource = self;
    self.statePicker.delegate = self;
    [self.bottomView addSubview:self.statePicker];
    
    //控制栏
    self.controllerToolBar = [[UIView alloc] init];
    self.controllerToolBar.backgroundColor = COLOR_BACKGROUD_GRAY;
    [self.bottomView addSubview:_controllerToolBar];
    
    
    //完成按钮
    self.finishBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    self.finishBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.finishBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [self.finishBtn addTarget:self action:@selector(finishBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.finishBtn setTitle:@"完成" forState:UIControlStateNormal];
    [self.finishBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [self.controllerToolBar addSubview:self.finishBtn];
    
    //取消按钮
    self.cancelBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    self.cancelBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.cancelBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [self.cancelBtn addTarget:self action:@selector(canceBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [self.cancelBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [self.controllerToolBar addSubview:_cancelBtn];
    
    //标题
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.text = self.pickerTitle;
    self.titleLabel.font = [UIFont systemFontOfSize:15];
    [self.controllerToolBar addSubview:self.titleLabel];
}

- (void)layoutSelfSubviews
{
    //底层视图
    self.bottomView.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, self.pickerHeight);
    
    //选择器
    self.statePicker.frame = CGRectMake(0, 40, SCREEN_WIDTH, self.pickerHeight - 40);
    
    //控制栏
    self.controllerToolBar.frame = CGRectMake(0, 0, SCREEN_WIDTH, 40);
    
    //完成按钮
    self.finishBtn.frame = CGRectMake(SCREEN_WIDTH - 70, 5, 70, 30);
    
    //取消按钮
    self.cancelBtn.frame = CGRectMake(0, 5, 70, 30);
    
    //标题
    self.titleLabel.frame = CGRectMake(70, 5, SCREEN_WIDTH - 140, 30);
}

#pragma mark - set相关

- (void)setDataSource:(NSArray *)dataSource
{
    _dataSource = dataSource;
    self.startTime = dataSource[0];
    self.endTime = dataSource[0];
    //设置弹层高度
    if (HEIGHT_PICKER > HEIGHT_OF_POPBOX - 24) {
        self.pickerHeight = HEIGHT_OF_POPBOX - 24;
    } else {
        self.pickerHeight = HEIGHT_OF_POPBOX - 24;//HEIGHT_PICKER;
        
    }
    
    //设置返回默认值
    self.stateStr = [NSString stringWithFormat:@"%@/%@",_dataSource[0],@(1)];
    
    //刷新布局
    [self layoutSelfSubviews];
    [self.statePicker setNeedsLayout];
    
    //刷新轱辘数据
    [self.statePicker reloadAllComponents];
    [self.statePicker selectRow:0 inComponent:0 animated:NO];
}

- (void)setDefaultStr:(NSString *)defaultStr
{
    _defaultStr = defaultStr;
    
    self.stateStr = defaultStr;
    NSArray * selectArr = [defaultStr componentsSeparatedByString:@"/"];
    [self.statePicker selectRow:[selectArr[1] integerValue] - 1 inComponent:0 animated:NO];
}

- (void)setPickerTitle:(NSString *)pickerTitle
{
    _pickerTitle = pickerTitle;
    self.titleLabel.text = pickerTitle;
}

#pragma mark - UIPickerViewDataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 2;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return self.dataSource.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return self.dataSource[row];
}

#pragma mark - UIPickerViewDelegate

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    
    if (component == 0) {
        NSLog(@"0000000000:::::::::%@",self.dataSource[row]);
//        [self.statePicker ]
//        self.dataSource[row]
        self.startTime = self.dataSource[row];
        NSString *startTime = [self.startTime substringWithRange:NSMakeRange(0, 2)];
        NSString *endTime = [self.endTime substringWithRange:NSMakeRange(0, 2)];
        if ([startTime intValue]>[endTime intValue]) {
            [pickerView selectRow:row inComponent:1 animated:YES];
            
            self.endTime = self.startTime;
        }
        
        
    }else if (component == 1){
        self.endTime = self.dataSource[row];
        NSString *startTime = [self.startTime substringWithRange:NSMakeRange(0, 2)];
        NSString *endTime = [self.endTime substringWithRange:NSMakeRange(0, 2)];
        if ([startTime intValue]>[endTime intValue]) {
            [pickerView selectRow:row inComponent:0 animated:YES];
            self.startTime = self.endTime;
        }
        
        NSLog(@"11111111111::::::::%@",self.dataSource[row]);
    }
//    self.stateStr = [NSString stringWithFormat:@"%@/%@",self.dataSource[row], @(row + 1)];
    
}

#pragma mark - 按钮相关

/**点击完成按钮*/
- (void)finishBtnClicked:(UIButton *)button
{
    self.valueDidSelect(self.startTime, self.endTime);
//    self.valueDidSelect(self.stateStr);
    [self removeSelfFromSupView];
}

/**点击取消按钮*/
- (void)canceBtnClicked:(UIButton *)button
{
    [self removeSelfFromSupView];
    self.hidden();
}

/**点击背景释放界面*/
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self removeSelfFromSupView];
    self.hidden();
}

#pragma mark - 显示弹层相关

/**弹出视图*/
- (void)show
{
    [[[UIApplication sharedApplication].delegate window] addSubview:self];
    
    //动画出现
    CGRect frame = self.bottomView.frame;
    if (frame.origin.y == SCREEN_HEIGHT) {
        frame.origin.y -= self.pickerHeight;
        [UIView animateWithDuration:0.3 animations:^{
            self.bottomView.frame = frame;
        }];
    }
}
- (void)showWithRow:(NSInteger)row{
    [[[UIApplication sharedApplication].delegate window] addSubview:self];
    
    //动画出现
    CGRect frame = self.bottomView.frame;
    if (frame.origin.y == SCREEN_HEIGHT) {
        frame.origin.y -= self.pickerHeight;
        [UIView animateWithDuration:0.3 animations:^{
            self.bottomView.frame = frame;
        }];
        
    }
}
/**移除视图*/
- (void)removeSelfFromSupView
{
    CGRect selfFrame = self.bottomView.frame;
    if (selfFrame.origin.y == SCREEN_HEIGHT - self.pickerHeight) {
        selfFrame.origin.y += self.pickerHeight;
        [UIView animateWithDuration:0.3 animations:^{
            self.bottomView.frame = selfFrame;
        }completion:^(BOOL finished) {
            [self removeFromSuperview];
        }];
    }
}

@end
