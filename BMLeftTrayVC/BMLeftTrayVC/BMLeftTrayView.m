//
//  BMLeftTrayVC.m
//  BMLeftTrayVC
//
//  Created by Jeffrey Camealy on 11/18/13.
//  Copyright (c) 2013 bearMountain. All rights reserved.
//

#import "BMLeftTrayView.h"

@interface BMLeftTrayView () {
    UIView *contentView;
    
    BOOL collapsed;
    id <MASConstraint> collapsedConstraint;
    id <MASConstraint> panningConstraint;
    float panningTouchStartX;
    float collapseWidth;
}
@end


@implementation BMLeftTrayView

#pragma mark - Public API

- (id)initWithContentView:(UIView *)aContentView collapseWidth:(float)aCollapseWidth {
    if (self = [super init]) {
        contentView = aContentView;
        collapseWidth = aCollapseWidth;
        
        [self addContentView];
    }
    
    return self;
}

- (void)toggleExpandCollapse {
    collapsed ? [self expand] : [self collapse];
}


#pragma mark - Private API

- (void)addContentView {
    [self addSubview:contentView];
    [contentView makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.width);
        make.top.equalTo(self.top);
        make.bottom.equalTo(self.bottom);
        make.left.equalTo(self.left).with.priority(MASLayoutPriorityDefaultHigh);
        make.left.lessThanOrEqualTo(self.left);
        make.right.greaterThanOrEqualTo(self.left).with.offset(collapseWidth);
    }];
    
    UIPanGestureRecognizer *panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(trayPanned:)];
    [contentView addGestureRecognizer:panGestureRecognizer];
}

- (void)expand {
    [collapsedConstraint uninstall];
    [self updateCollapsedConstraint];
    collapsed = NO;
}

- (void)collapse {
    if (!collapsed) {
        [contentView makeConstraints:^(MASConstraintMaker *make) {
            collapsedConstraint = make.right.equalTo(self.left).with.offset(collapseWidth).with.priority(MASLayoutPriorityDefaultHigh+1);
        }];
    }
    [self updateCollapsedConstraint];
    collapsed = YES;
}

- (void)updateCollapsedConstraint {
    [panningConstraint uninstall];
    [UIView animateWithDuration:0.4 animations:^{
        [self layoutIfNeeded];
    }];
}


#pragma mark - Action Methods 

- (void)trayPanned:(UIPanGestureRecognizer *)recognizer {
    CGPoint locationInView = [recognizer locationInView:self];
    
    switch (recognizer.state) {
        case UIGestureRecognizerStateBegan: {
            CGPoint touchLocation = [recognizer locationInView:contentView];
            panningTouchStartX = touchLocation.x;
            [contentView makeConstraints:^(MASConstraintMaker *make) {
                panningConstraint = make.left.equalTo(self.left).with.offset(locationInView.x-panningTouchStartX).with.priority(MASLayoutPriorityDefaultHigh+2);
            }];
        } break;

        case UIGestureRecognizerStateChanged: {
            panningConstraint.offset(locationInView.x-panningTouchStartX);
        } break;

        case UIGestureRecognizerStateEnded:
        case UIGestureRecognizerStateCancelled: {
            float x = contentView.frame.origin.x;
            float width = contentView.frame.size.width;
            if (x < -width/2) {
                [self collapse];
            } else {
                [self expand];
            }
        } break;
            
        default:
            break;
    }
}


#pragma mark - Responder Chain

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    return CGRectContainsPoint(contentView.frame, point);
}

@end

































