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
    
    self.view.backgroundColor = [UIColor grayColor];
    [self addLeftTrayVC];
}


#pragma mark - Private API

- (void)addLeftTrayVC {
    UITableViewController *stubTVC = [[UITableViewController alloc] initWithStyle:UITableViewStylePlain];
//    stubTVC.view.backgroundColor = [UIColor clearColor];
    
    UIView *tabView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    tabView.backgroundColor = [UIColor yellowColor];
    
    BMLeftTrayVC *leftTrayVC = [[BMLeftTrayVC alloc] initWithContentVC:stubTVC tabView:tabView];
    [self addChildViewController:leftTrayVC];
    [self.view addSubview:leftTrayVC.view];
    [leftTrayVC didMoveToParentViewController:self];
    
    [leftTrayVC.view makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@350);
        make.top.equalTo(self.view.top);
        make.bottom.equalTo(self.view.bottom);
        make.left.equalTo(self.view.left);
    }];
}

@end
