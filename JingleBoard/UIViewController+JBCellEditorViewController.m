//
//  UIViewController+JBCellEditorViewController.m
//  JingleBoard
//
//  Created by Max Winde on 30.09.12.
//  Copyright (c) 2012 Max Winde. All rights reserved.
//

#import "JBCellContentEditorNavigationController.h"

#import "UIViewController+JBCellEditorViewController.h"

@implementation UIViewController (JBCellEditorViewController)

- (JBCellContent *)content;
{
    JBCellContentEditorNavigationController *navigationController = (JBCellContentEditorNavigationController *)self.navigationController;
    return navigationController.content;
}

@end
