//
//  CenterDatePickerView.h
//  大公鸡
//
//  Created by Ivan on 2017/7/12.
//  Copyright © 2017年 Ivan. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CenterPickerViewDelegate <NSObject>
@optional
/**
 * 确定按钮
 */
-(void)didClickFinishDateTimePickerView:(NSString*)date;
/**
 * 取消按钮
 */
-(void)didClickCancelDateTimePickerView;

@end


@interface CenterPickerView : UIView<UIPickerViewDelegate,UIPickerViewDataSource>

@property (nonatomic, strong)  UIPickerView * datePicker;
@property (nonatomic, strong)  UILabel * titleLabel;
@property (nonatomic, strong)  NSArray *dataSource;
@property (nonatomic,weak) id<CenterPickerViewDelegate>delegate;
- (void)showCenterDatePickerView;
- (instancetype)initWithFrame:(CGRect)frame withdataSource:(NSArray *)arr;
@end
