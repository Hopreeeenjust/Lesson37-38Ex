//
//  UIView+MKAnnotationView.m
//  Lesson37-38Ex
//
//  Created by Hopreeeeenjust on 06.02.15.
//  Copyright (c) 2015 Hopreeeeenjust. All rights reserved.
//

#import "UIView+MKAnnotationView.h"

@implementation UIView (MKAnnotationView)
- (MKAnnotationView *)superAnnotationView {
    if ([self isKindOfClass:[MKAnnotationView class]]) {
        return (MKAnnotationView *)self;
    }
    if (!self.superview) {
        return nil;
    }
    return [self.superview superAnnotationView];
}
@end
