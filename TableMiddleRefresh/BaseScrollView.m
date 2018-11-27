//
//  BaseScrollView.m
//  TableMiddleRefresh
//
//  Created by XLL on 2018/11/22.
//  Copyright © 2018 liangli. All rights reserved.
//

#import "BaseScrollView.h"

@implementation BaseScrollView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.clipsToBounds = NO;
    }
    return self;
}

- (void)setOffset:(CGPoint)offset {
    _offset = offset;
}

-(UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    UIView* view = [super hitTest:point withEvent:event];
    BOOL hitHead = point.y < (HeadViewHeight - self.offset.y);
    if (hitHead || !view) {
        self.scrollEnabled = NO;
        if (!view){
            for (UIView* subView in self.subviews) {
                if (subView.frame.origin.x == self.contentOffset.x){
                    view = subView;
                }
            }
        }
        return view;
    }else{
        self.scrollEnabled = YES;
        return view;
    }
}
@end
