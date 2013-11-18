//
//  BMLeftTrayVC.m
//  BMLeftTrayVC
//
//  Created by Jeffrey Camealy on 11/18/13.
//  Copyright (c) 2013 bearMountain. All rights reserved.
//

#import "BMLeftTrayVC.h"

@interface BMLeftTrayVC ()

@end


@implementation BMLeftTrayVC

#pragma mark - View Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor blueColor];
}

#pragma mark - Custom Setter

- (void)setContentVC:(UIViewController *)contentVC {
    _contentVC = contentVC;
}

@end
