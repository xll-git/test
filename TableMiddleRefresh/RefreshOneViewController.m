//
//  RefreshOneViewController.m
//  TableMiddleRefresh
//
//  Created by XLL on 2018/11/21.
//  Copyright © 2018 liangli. All rights reserved.
//

#import "RefreshOneViewController.h"
#import "BaseHeaderView.h"

@interface RefreshOneViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) BaseHeaderView *headerView;
@end

@implementation RefreshOneViewController {
    NSInteger _rowNum;
}

#pragma mark - lazy load

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-64)];
        _tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [UIView new];
        if (@available(iOS 11.0, *)) {
            _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
        [self.view addSubview:_tableView];
        //设置内容偏移
        _tableView.contentInset = UIEdgeInsetsMake(260, 0, 0, 0);
        //设置滚动条偏移
        _tableView.scrollIndicatorInsets = UIEdgeInsetsMake(260, 0, 0, 0);
    }
    return _tableView;
}

- (BaseHeaderView *)headerView {
    if (!_headerView) {
        _headerView = [[BaseHeaderView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 260)];
        _headerView.backgroundColor = [UIColor yellowColor];
        [self.view addSubview:_headerView];
        _headerView.layer.contents = (__bridge id _Nullable)([UIImage imageNamed:@"439c9bff9d32655d0bead3e668b1d164.jpg"].CGImage);
    }
    [self.view bringSubviewToFront:_headerView];
    return _headerView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"偏移刷新";
    self.navigationController.navigationBar.translucent = NO;
    _rowNum = 10;
    self.tableView.hidden = NO;
    self.headerView.hidden = NO;
    [self addreFresh];
}

- (void)addreFresh {
    MJWeakSelf;
    _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        self->_rowNum = 10;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [weakSelf.tableView.mj_header endRefreshing];
        });
        [weakSelf.tableView reloadData];
        
    }];
    _tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        self->_rowNum += 10;
        [weakSelf.tableView reloadData];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [weakSelf.tableView.mj_footer endRefreshing];
        });
    }];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (!self.isViewLoaded || !self.view.window) {  //页面没有加载的时候不进行调整
        return;
    }
    CGFloat offsetY = scrollView.contentOffset.y;
    CGRect headerFrame = self.headerView.frame;
    //上拉加载更多（头部还没有隐藏），动态移动header
    if (offsetY > -260 & offsetY < 0) {
        headerFrame.origin.y = -offsetY -260;
    }else if(offsetY > 0){ //头部隐藏，固定头部位置
        headerFrame.origin.y = -260;
    }else{ //下拉刷新
        headerFrame.origin.y = 0;
    }
    self.headerView.frame = headerFrame;
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _rowNum;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell_ID"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell_ID"];
    }
    cell.textLabel.text = @"偏移刷新";
    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 45;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.01;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [UIView new];
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [UIView new];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
