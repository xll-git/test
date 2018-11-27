//
//  MoreHeaderView.m
//  TableMiddleRefresh
//
//  Created by XLL on 2018/11/22.
//  Copyright © 2018 liangli. All rights reserved.
//

#import "MoreHeaderView.h"

@implementation MoreHeaderView

-(UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    
    if (self.userInteractionEnabled == NO || self.hidden == YES || self.alpha <= 0.01) return nil;
    
    UIView* view = [super hitTest:point withEvent:event];
    
    if ([view isKindOfClass:[UIButton class]])
    {
        return view;
    }
    
    return nil;
}

@end
