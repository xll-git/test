//
//  BaseToolTitleBarView.m
//  TableMiddleRefresh
//
//  Created by XLL on 2018/11/22.
//  Copyright © 2018 liangli. All rights reserved.
//

#import "BaseToolTitleBarView.h"

@implementation BaseToolTitleBarView {
    NSMutableArray <UIButton *>*_btnArr;
}

- (instancetype)initWithFrame:(CGRect)frame arrayTitles:(NSArray *)titles{
    if (self = [super initWithFrame:frame]) {
        _selectedIndex = 0;
        _titles = titles;
        [self initUI];
    }
    return self;
}


- (void)initUI {
    _btnArr = [NSMutableArray array];
    CGFloat width = SCREEN_WIDTH / _titles.count;
    for (NSInteger i = 0; i < _titles.count; i++) {
        UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(width * i, 0, width, Tool_height)];
        button.tag = i;
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        button.titleLabel.font = [UIFont systemFontOfSize:15];
        [button setTitle:_titles[i] forState:UIControlStateNormal];
        [button setTitle:_titles[i] forState:UIControlStateSelected];
        if (i == _selectedIndex) {
            button.selected = YES;
        }else {
            button.selected = NO;
        }
        [self addSubview:button];
        [button addTarget:self action:@selector(btn_Click:) forControlEvents:UIControlEventTouchUpInside];
        [_btnArr addObject:button];
    }
    UIView *lineView  = [[UIView alloc]init];
    [self addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.mas_equalTo(0);
        make.height.mas_equalTo(1);
    }];
    lineView.backgroundColor = [UIColor  redColor];
    
    UIView *lineView2  = [[UIView alloc]init];
    [self addSubview:lineView2];
    [lineView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.mas_equalTo(0);
        make.height.mas_equalTo(1);
    }];
    lineView2.backgroundColor = [UIColor  redColor];
}

- (void)setTitles:(NSArray *)titles {
    // 移除所有
    for (UIView * childView in self.subviews) {
        [childView removeFromSuperview];
    }
//    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    _titles = titles;
    [self initUI];
}

- (void)setSelectedIndex:(NSInteger)selectedIndex {
    if (_selectedIndex == selectedIndex) {
        return;
    }
    _selectedIndex = selectedIndex;
    [self btn_Click:_btnArr[selectedIndex]];
}

- (void)btn_Click:(UIButton *)button {
    _selectedIndex = button.tag;
    for (NSInteger i = 0; i < _btnArr.count; i++) {
        if (i == button.tag) {
            _btnArr[i].selected = YES;
        }else {
            _btnArr[i].selected = NO;
        }
    }
    if (self.buttonSelected) {
        self.buttonSelected(button.tag);
    }
}


@end
