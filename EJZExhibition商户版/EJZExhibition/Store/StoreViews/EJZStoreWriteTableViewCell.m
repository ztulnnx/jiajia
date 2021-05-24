//
//  EJZStoreWriteTableViewCell.m
//  EJZExhibition
//
//  Created by 黄传家 on 2018/4/18.
//  Copyright © 2018年 黄传家. All rights reserved.
//

#import "EJZStoreWriteTableViewCell.h"

@implementation EJZStoreWriteTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initCell];
    }
    return self;
}
-(void)initCell{
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10*WRATIO, 10*WRATIO, 100*WRATIO, 30*WRATIO)];
    self.titleLabel.font = [UIFont fontWithName:@"Helvetica" size:14*WRATIO];
    [self.contentView addSubview:self.titleLabel];
    self.msgTF = [[UITextField alloc] initWithFrame:CGRectMake(110*WRATIO, 10*WRATIO, WIDTH-130*WRATIO, 30*WRATIO)];
    self.msgTF.font = [UIFont fontWithName:@"Helvetica" size:14*WRATIO];
//    self.msgTF.backgroundColor = [UIColor yellowColor];
//    self.msgTF.returnKeyType = UIReturnKeyDone;
//    self.msgTF.delegate = self;
    [self.contentView addSubview:self.msgTF];
    self.msgLabel = [[UILabel alloc] initWithFrame:CGRectMake(110*WRATIO, 10*WRATIO, WIDTH-130*WRATIO, 30*WRATIO)];
    self.msgLabel.textColor = [UIColor colorWithRed:0.6 green:0.6 blue:0.6 alpha:1];
    self.msgLabel.font = [UIFont fontWithName:@"Helvetica" size:14*WRATIO];
    [self.contentView addSubview:self.msgLabel];
    self.addBtn = [[UIButton alloc] initWithFrame:CGRectMake(WIDTH-20*WRATIO, 10*WRATIO, 10*WRATIO, 30*WRATIO)];
//    self.addBtn.backgroundColor = [UIColor redColor];
    [self.contentView addSubview:self.addBtn];
    
    self.prantingView = [[UIView alloc] initWithFrame:CGRectMake(0, 50*WRATIO-1, WIDTH, 1)];
    self.prantingView.backgroundColor = [UIColor colorWithRed:0.8 green:0.8 blue:0.8 alpha:1];
    [self.contentView addSubview:self.prantingView];
}

@end
