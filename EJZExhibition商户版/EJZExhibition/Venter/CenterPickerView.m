//
//  CenterDatePickerView.m
//  大公鸡
//
//  Created by Ivan on 2017/7/12.
//  Copyright © 2017年 Ivan. All rights reserved.
//

#import "CenterPickerView.h"

#define COLOR_BACKGROUD_GRAY    [UIColor colorWithRed:238/255.0f green:238/255.0f blue:238/255.0f alpha:1]

@interface CenterPickerView ()
{
    NSString * dateString;
}
@property (nonatomic, strong) UIView * contentV;
@end

@implementation CenterPickerView

- (instancetype)initWithFrame:(CGRect)frame withdataSource:(NSArray *)arr{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = RGBA(0, 0, 0, 0.5);
        self.alpha = 0;
        
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(cancelDatePicker)];
        [self addGestureRecognizer:tap];
        
        self.dataSource = arr;
        UIView *contentV = [[UIView alloc] initWithFrame:CGRectMake(0, HEIGHT-TabbarSafeBottomMargin, WIDTH, 220)];
        contentV.backgroundColor = [UIColor greenColor];
        [self addSubview:contentV];
        self.contentV = contentV;
        
        self.datePicker = [[UIPickerView alloc]initWithFrame:CGRectMake(0, 40, WIDTH, 180)];
//        self.datePicker.datePickerMode = UIDatePickerModeDate;
        self.datePicker.backgroundColor = [UIColor whiteColor];
        self.datePicker.delegate = self;
        self.datePicker.dataSource = self;
        [contentV addSubview:self.datePicker];
        
        UIView * pickerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, 40)];
        pickerView.backgroundColor = COLOR_BACKGROUD_GRAY;
        [contentV addSubview:pickerView];
        
        self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 40)];
        self.titleLabel.text = @"选择起始时间";
        self.titleLabel.textColor = [UIColor blackColor];
        self.titleLabel.font = [UIFont systemFontOfSize:15.f];
        self.titleLabel.center = pickerView.center;
        [pickerView addSubview:self.titleLabel];
        
        UIButton * cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        cancelBtn.frame = CGRectMake(10, 0, 50, 40);
        [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        cancelBtn.titleLabel.font = [UIFont systemFontOfSize:15.f];
        [cancelBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [cancelBtn addTarget:self action:@selector(cancelDatePicker) forControlEvents:UIControlEventTouchUpInside];
        [pickerView addSubview:cancelBtn];
        
        UIButton * doneBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        doneBtn.frame = CGRectMake(WIDTH-60, 0, 50, 40);
        [doneBtn setTitle:@"确定" forState:UIControlStateNormal];
        doneBtn.titleLabel.font = [UIFont systemFontOfSize:15.f];
        [doneBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [doneBtn addTarget:self action:@selector(doneDatePicker) forControlEvents:UIControlEventTouchUpInside];
        [pickerView addSubview:doneBtn];
        

    
    }
    return self;
}
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return self.dataSource.count;
}
//每行的标题
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    NSString * title = self.dataSource[row];
    
    return title;
}

//获取uidatepickerview数据
-(void)dateViewAction:(UIDatePicker *)sender
{
    NSDate *selectedDate = sender.date;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd";
    NSString * date = [formatter stringFromDate:selectedDate];
    dateString = date;
    NSLog(@"%@",dateString);
    
}
- (void)cancelDatePicker{
    [self hideCenterDatePickerView];
    [_delegate didClickCancelDateTimePickerView];
}
- (void)doneDatePicker{
    
    if (dateString.length == 0) {
        
        NSDate *selectedDate = [NSDate date];
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"yyyy-MM-dd";
        NSString * date = [formatter stringFromDate:selectedDate];
        dateString = date;
    }

    NSLog(@"%@",dateString);
    [_delegate didClickFinishDateTimePickerView:dateString];
    [self hideCenterDatePickerView];
    
}
- (void)showCenterDatePickerView{
    
    self.frame = CGRectMake(0, 0, WIDTH, HEIGHT);
    [UIView animateWithDuration:0.25f animations:^{
        self.alpha = 1;
        _contentV.frame = CGRectMake(0, HEIGHT-220, WIDTH, 220);
        
    } completion:^(BOOL finished) {
        
        
    }];
}
- (void)hideCenterDatePickerView{
 
    [UIView animateWithDuration:0.2f animations:^{
        self.alpha = 0;
        _contentV.frame = CGRectMake(0, HEIGHT, WIDTH, 220);
        
    } completion:^(BOOL finished) {
        
        self.frame = CGRectMake(0, HEIGHT, WIDTH, HEIGHT);
    }];
}
@end
