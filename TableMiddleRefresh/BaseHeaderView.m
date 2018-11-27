//
//  BaseHeaderView.m
//  TableMiddleRefresh
//
//  Created by XLL on 2018/11/21.
//  Copyright © 2018 liangli. All rights reserved.
//

#import "BaseHeaderView.h"

@implementation BaseHeaderView

-(UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    
    UIView* view = [super hitTest:point withEvent:event];
    
    if ([view isKindOfClass:[UIButton class]])
    {
        return view;
    }
    
    return nil;
}

@end
