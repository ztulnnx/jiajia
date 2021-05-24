//
//  EJZUserAddProViewController.m
//  EJZExhibitionUser
//
//  Created by 黄传家 on 2018/5/13.
//  Copyright © 2018年 黄传家. All rights reserved.
//

#import "EJZUserAddProViewController.h"

@interface EJZUserAddProViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)NSMutableArray *dataSource;
@property (nonatomic,strong)UITableView *tableView;
@end

@implementation EJZUserAddProViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, TabbarSafeNavMargin, WIDTH, HEIGHT-TabbarSafeNavMargin)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    return nil;
}


@end
