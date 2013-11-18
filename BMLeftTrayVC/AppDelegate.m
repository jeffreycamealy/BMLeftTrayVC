//
//  AppDelegate.m
//  BMLeftTrayVC
//
//  Created by Jeffrey Camealy on 11/18/13.
//  Copyright (c) 2013 bearMountain. All rights reserved.
//

#import "AppDelegate.h"
#import "RootVC.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [self setupWindow];
    [self setupRootVC];
    return YES;
}


#pragma mark - Private API

- (void)setupWindow {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [self.window makeKeyAndVisible];
}

- (void)setupRootVC {
    self.window.rootViewController = [RootVC new];
}


@end
