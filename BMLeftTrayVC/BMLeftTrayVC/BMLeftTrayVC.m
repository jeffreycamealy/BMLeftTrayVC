//
//  BMLeftTrayVC.m
//  BMLeftTrayVC
//
//  Created by Jeffrey Camealy on 11/18/13.
//  Copyright (c) 2013 bearMountain. All rights reserved.
//

#import "BMLeftTrayVC.h"

@interface BMLeftTrayVC () {
    UIViewController *contentVC;
    UIView *tabView;
    
    BOOL collapsed;
    id <MASConstraint> collapsedConstraint;
    id <MASConstraint> panningConstraint;
    float panningTabOffset;
}
@end


@implementation BMLeftTrayVC

#pragma mark - Public API

- (id)initWithContentVC:(UIViewController *)aContentVC tabView:(UIView *)aTabView {
    if (self = [super init]) {
        contentVC = aContentVC;
        tabView = aTabView;
        
        [self addContentVC];
        [self addTabView];
    }
    
    return self;
}


#pragma mark - Private API

- (void)addContentVC {
    [self addChildViewController:contentVC];
    [self.view addSubview:contentVC.view];
    [contentVC didMoveToParentViewController:self];
    [contentVC.view makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.view.width).with.offset(-tabView.frame.size.width);
        make.top.equalTo(self.view.top);
        make.bottom.equalTo(self.view.bottom);
        make.left.equalTo(self.view.left).with.priority(MASLayoutPriorityDefaultHigh);
    }];
}

- (void)addTabView {
    [self.view addSubview:tabView];
    [tabView makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(contentVC.view.right);
        make.centerY.equalTo(contentVC.view.centerY);
        make.height.equalTo(@(tabView.frame.size.height));
        make.width.equalTo(@(tabView.frame.size.width));
        
        make.right.lessThanOrEqualTo(self.view.right);
    }];
    
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tabTapped:)];
    [tabView addGestureRecognizer:tapGestureRecognizer];
    
    UIPanGestureRecognizer *panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(tabPanned:)];
    [tabView addGestureRecognizer:panGestureRecognizer];
}

- (void)expand {
    [collapsedConstraint uninstall];
    [self updateCollapsedConstraint];
    collapsed = NO;
}

- (void)collapse {
    if (!collapsed) {
        [contentVC.view makeConstraints:^(MASConstraintMaker *make) {
            collapsedConstraint = make.right.equalTo(self.view.left).with.priority(MASLayoutPriorityDefaultHigh+1);
        }];
    }
    [self updateCollapsedConstraint];
    collapsed = YES;
}

- (void)updateCollapsedConstraint {
    [panningConstraint uninstall];
    [UIView animateWithDuration:0.4 animations:^{
        [self.view layoutIfNeeded];
    }];
}


#pragma mark - Action Methods 

- (void)tabTapped:(UITapGestureRecognizer *)recognizer {
    collapsed ? [self expand] : [self collapse];
}

- (void)tabPanned:(UIPanGestureRecognizer *)recognizer {
    CGPoint locationInView = [recognizer locationInView:self.view];
    
    switch (recognizer.state) {
        case UIGestureRecognizerStateBegan: {
            CGPoint locationInTab = [recognizer locationInView:tabView];
            panningTabOffset = locationInTab.x;
            [contentVC.view makeConstraints:^(MASConstraintMaker *make) {
                panningConstraint = make.right.equalTo(self.view.left).with.offset(locationInView.x-panningTabOffset).with.priority(MASLayoutPriorityDefaultHigh+2);
            }];
        }
            break;

        case UIGestureRecognizerStateChanged: {
            panningConstraint.offset(locationInView.x-panningTabOffset);
        }
            break;

        case UIGestureRecognizerStateEnded:
        case UIGestureRecognizerStateCancelled: {
            float x = contentVC.view.frame.origin.x;
            float width = contentVC.view.frame.size.width;
            if (x < -width/2) {
                [self collapse];
            } else {
                [self expand];
            }
                
        }
            break;
            
        default:
            break;
    }
}


@end

































