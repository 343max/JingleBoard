//
//  JBAppDelegate.h
//  JingleBoard
//
//  Created by Max Winde on 28.09.12.
//  Copyright (c) 2012 Max Winde. All rights reserved.
//

#import <UIKit/UIKit.h>

@class JBViewController;

@interface JBAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) JBViewController *viewController;

@end
