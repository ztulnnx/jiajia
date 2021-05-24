//
//  EJZUserAddProTableViewCell.m
//  EJZExhibitionUser
//
//  Created by 黄传家 on 2018/5/13.
//  Copyright © 2018年 黄传家. All rights reserved.
//

#import "EJZUserAddProTableViewCell.h"

@implementation EJZUserAddProTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        //自定义cell
        //设置cell的选中效果 蓝色
        //[self setSelectionStyle:UITableViewCellSelectionStyleBlue];
        [self creatUI];
    }
    return self;
}

-(void)creatUI{
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10*WRATIO, 10*WRATIO, 100*WRATIO, 20*WRATIO)];
    self.titleLabel.textColor = [UIColor blackColor];
    self.titleLabel.font =  [UIFont fontWithName:@"Helvetica-Bold" size:12*WRATIO];
    [self.contentView addSubview:self.titleLabel];
    
    
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10*WRATIO, 10*WRATIO, 100*WRATIO, 20*WRATIO)];
    self.titleLabel.textColor = [UIColor blackColor];
    self.titleLabel.font =  [UIFont fontWithName:@"Helvetica-Bold" size:12*WRATIO];
    [self.contentView addSubview:self.titleLabel];
    
    self.subtractBtn = [[UIButton alloc] initWithFrame:CGRectMake(120*WRATIO, 10*WRATIO, 20*WRATIO, 20*WRATIO)];
    [self.subtractBtn setTitle:@"" forState:UIControlStateNormal];
    
    
    
}

@end
