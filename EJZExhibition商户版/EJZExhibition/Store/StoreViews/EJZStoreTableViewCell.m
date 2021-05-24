//
//  EJZStoreTableViewCell.m
//  EJZExhibition
//
//  Created by 黄传家 on 2018/4/16.
//  Copyright © 2018年 黄传家. All rights reserved.
//

#import "EJZStoreTableViewCell.h"

@implementation EJZStoreTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initCell];
    }
    return self;
}
-(void)initCell{
//    self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(70*WRATIO, 12*WRATIO, 100*WRATIO, 20*WRATIO)];
//    self.nameLabel.font = [UIFont systemFontOfSize:14*WRATIO];
//    [self addSubview:self.nameLabel];
//
//    self.imgView = [[UIImageView alloc] initWithFrame:CGRectMake(WIDTH-24*WRATIO, 13*WRATIO, 8*WRATIO, 14*WRATIO)];
//    self.imgView.image = [UIImage imageNamed:@"arrows"];
//    [self addSubview:self.imgView];
//
//    UIView *pratingView = [[UIView alloc] initWithFrame:CGRectMake(70*WRATIO, 43*WRATIO, WIDTH-80*WRATIO, 1*WRATIO)];
//    pratingView.backgroundColor = [UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1];
//    [self addSubview:pratingView];
    self.imgView = [[UIImageView alloc] initWithFrame:CGRectMake(10*WRATIO, 10*WRATIO, 50*WRATIO, 50*WRATIO)];
    self.imgView.backgroundColor = [UIColor grayColor];
    self.imgView.layer.masksToBounds = YES;
    self.imgView.layer.cornerRadius = 25*WRATIO;
    [self.contentView addSubview:self.imgView];
    
    
    
    self.typeLabel = [[UILabel alloc] initWithFrame:CGRectMake(70*WRATIO, 25*WRATIO, 200*WRATIO, 20*WRATIO)];
    [self.contentView addSubview:self.typeLabel];
    
    
    
    
    
    
    
}
@end
