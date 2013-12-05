//
//  BMLeftTrayVC.h
//  BMLeftTrayVC
//
//  Created by Jeffrey Camealy on 11/18/13.
//  Copyright (c) 2013 bearMountain. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BMLeftTrayView : UIView

- (id)initWithContentView:(UIView *)contentView collapseWidth:(float)collapseWidth;

- (void)toggleExpandCollapse;

@end
