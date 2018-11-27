//
//  RefreshMoreViewController.m
//  TableMiddleRefresh
//
//  Created by XLL on 2018/11/21.
//  Copyright © 2018 liangli. All rights reserved.
//

#import "RefreshMoreViewController.h"
#import "BaseScrollView.h"
#import "MoreHeaderView.h"
#import "BaseToolTitleBarView.h"
#define NAV_Height 64.0

@interface RefreshMoreViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) BaseScrollView *scrollView;
@property (nonatomic, strong) MoreHeaderView *headerView;
@property (nonatomic, strong) UIView *backView;
@property (nonatomic, strong) BaseToolTitleBarView *toolView;

@property (nonatomic, strong) UITableView *oneTableView;
@property (nonatomic, strong) UITableView *twoTableView;
@property (nonatomic, strong) UITableView *threeTableView;
@property (nonatomic, strong) UITableView *fourTableView;

@end

@implementation RefreshMoreViewController

- (BaseScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[BaseScrollView  alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-NAV_Height)];
        _scrollView.backgroundColor = [UIColor yellowColor];
        _scrollView.delaysContentTouches = NO;
        _scrollView.pagingEnabled = YES;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.delegate = self;
        _scrollView.contentSize = CGSizeMake(SCREEN_WIDTH * 4, 0);
        _scrollView.bounces = NO;
    }
    return _scrollView;
}

- (MoreHeaderView *)headerView {
    if (!_headerView) {
        _headerView = [[MoreHeaderView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, HeadViewHeight+Tool_height)];
        _headerView.backgroundColor = [UIColor yellowColor];
        _headerView.layer.contents = (__bridge id _Nullable)([UIImage imageNamed:@"439c9bff9d32655d0bead3e668b1d164.jpg"].CGImage);
        [self.scrollView addSubview:_headerView];
    }
    [self.scrollView bringSubviewToFront:_headerView];
    return _headerView;
}

- (BaseToolTitleBarView *)toolView {
    if (!_toolView) {
        _toolView = [[BaseToolTitleBarView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, Tool_height) arrayTitles:@[@"1",@"2",@"3",@"4"]];
        [self.headerView addSubview:_toolView];
        _toolView.backgroundColor = [UIColor whiteColor];
        __weak typeof(self) weakSelf = self;
        _toolView.buttonSelected = ^(NSInteger index) {
            [weakSelf.scrollView setContentOffset:CGPointMake(SCREEN_WIDTH * index, 0) animated:NO];
        };
        [_toolView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.bottom.right.mas_equalTo(0);
            make.height.mas_equalTo(Tool_height);
        }];
    }
    return _toolView;
}

- (UIView *)backView {
    if (!_backView) {
        _backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, HeadViewHeight+Tool_height)];
    }
    return _backView;
}

- (UITableView *)oneTableView {
    if (!_oneTableView) {
        _oneTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-NAV_Height)];
        _oneTableView.tableHeaderView = self.backView;
        _oneTableView.delegate = self;
        _oneTableView.dataSource = self;
        _oneTableView.showsVerticalScrollIndicator = NO;
        _oneTableView.tableFooterView = [UIView new];
    }
    return _oneTableView;
}

- (UITableView *)twoTableView {
    if (!_twoTableView) {
        _twoTableView = [[UITableView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH, 0, SCREEN_WIDTH, SCREEN_HEIGHT-NAV_Height)];
        _twoTableView.tableHeaderView = self.backView;
        _twoTableView.delegate = self;
        _twoTableView.dataSource = self;
        _twoTableView.showsVerticalScrollIndicator = NO;
        _twoTableView.tableFooterView = [UIView new];
    }
    return _twoTableView;
}

- (UITableView *)threeTableView {
    if (!_threeTableView) {
        _threeTableView = [[UITableView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*2, 0, SCREEN_WIDTH, SCREEN_HEIGHT-NAV_Height)];
        _threeTableView.tableHeaderView = self.backView;
        _threeTableView.delegate = self;
        _threeTableView.dataSource = self;
        _threeTableView.showsVerticalScrollIndicator = NO;
        _threeTableView.tableFooterView = [UIView new];
    }
    return _threeTableView;
}

- (UITableView *)fourTableView {
    if (!_fourTableView) {
        _fourTableView = [[UITableView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*3, 0, SCREEN_WIDTH, SCREEN_HEIGHT-NAV_Height)];
        _fourTableView.tableHeaderView = self.backView;
        _fourTableView.delegate = self;
        _fourTableView.dataSource = self;
        _fourTableView.showsVerticalScrollIndicator = NO;
        _fourTableView.tableFooterView = [UIView new];
    }
    return _fourTableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"多视图联动";
    self.view.backgroundColor = [UIColor whiteColor];
    //
    [self initUI];
}

- (void)initUI {
    self.view.clipsToBounds = YES;
    [self.view addSubview:self.scrollView];
    [self.scrollView addSubview:self.oneTableView];
    [self.scrollView addSubview:self.twoTableView];
    [self.scrollView addSubview:self.threeTableView];
    [self.scrollView addSubview:self.fourTableView];
    
    [self.view addSubview:self.headerView];
    self.toolView.hidden = NO;
}

#pragma mark - UIScrollViewDelegate
// 滚动视图减速完成，滚动将停止时，调用该方法。一次有效滑动，只执行一次。
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if (scrollView == _scrollView) {
        CGFloat contentOffset_X = scrollView.contentOffset.x;
        NSInteger pageNum = contentOffset_X / SCREEN_WIDTH;
        self.toolView.selectedIndex = pageNum;
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (!self.isViewLoaded || !scrollView.window || scrollView == _scrollView) {
        return;
    }
    CGFloat contentOffset_Y = scrollView.contentOffset.y;
    CGFloat originY = 0;
    CGFloat otherOffset_Y = 0;
    if (contentOffset_Y <= HeadViewHeight) {
         originY = -contentOffset_Y;
        if (contentOffset_Y < 0) {
            otherOffset_Y = 0;
        }else {
            otherOffset_Y = contentOffset_Y;
        }
    }else {
        originY = -HeadViewHeight;
        otherOffset_Y = HeadViewHeight;
    }
    self.headerView.frame = CGRectMake(0, originY, SCREEN_WIDTH, HeadViewHeight+Tool_height);
    
    for ( int i = 0; i<self.toolView.titles.count; i++ ) {
        if (i != self.toolView.selectedIndex) {
            UITableView* contentView = self.scrollView.subviews[i];
            CGPoint offset = CGPointMake(0, otherOffset_Y);
            if ([contentView isKindOfClass:[UITableView class]]) {
                if (contentView.contentOffset.y < HeadViewHeight || offset.y < HeadViewHeight) {
                    [contentView setContentOffset:offset animated:NO];
                    self.scrollView.offset = offset;
                }
            }
        }
    }
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell_ID"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell_ID"];
    }
    if (tableView == _oneTableView) {
        cell.textLabel.text = [NSString stringWithFormat:@"1-%ld",indexPath.row];
    }else if (tableView == _twoTableView) {
        cell.textLabel.text = [NSString stringWithFormat:@"2-%ld",indexPath.row];
    }else if (tableView == _threeTableView) {
        cell.textLabel.text = [NSString stringWithFormat:@"3-%ld",indexPath.row];
    }else {
        cell.textLabel.text = [NSString stringWithFormat:@"4-%ld",indexPath.row];
    }
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
