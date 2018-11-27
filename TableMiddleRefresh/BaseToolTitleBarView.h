//
//  BaseToolTitleBarView.h
//  TableMiddleRefresh
//
//  Created by XLL on 2018/11/22.
//  Copyright © 2018 liangli. All rights reserved.
//

#import <UIKit/UIKit.h>

#define Tool_height 40.0

@interface BaseToolTitleBarView : UIView

- (instancetype)initWithFrame:(CGRect)frame arrayTitles:(NSArray *)titles;

@property (nonatomic, assign) NSInteger selectedIndex;

@property (nonatomic, strong) NSArray *titles;

@property (nonatomic, copy)  void(^buttonSelected)(NSInteger index);

@end
