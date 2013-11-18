//
//  RootVC.m
//  BMLeftTrayVC
//
//  Created by Jeffrey Camealy on 11/18/13.
//  Copyright (c) 2013 bearMountain. All rights reserved.
//

#import "RootVC.h"
#import "BMLeftTrayVC.h"

@implementation RootVC

#pragma mark - View Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addLeftTrayVC];
}


#pragma mark - Private API

- (void)addLeftTrayVC {
    BMLeftTrayVC *leftTrayVC = [BMLeftTrayVC new];
    [self addChildViewController:leftTrayVC];
    [self.view addSubview:leftTrayVC.view];
    NSLog(@"%@", NSStringFromCGRect(self.view.bounds));
    [leftTrayVC didMoveToParentViewController:self];
}

@end
