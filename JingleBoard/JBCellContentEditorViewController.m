//
//  JBCellContentEditorViewController.m
//  JingleBoard
//
//  Created by Max Winde on 30.09.12.
//  Copyright (c) 2012 Max Winde. All rights reserved.
//

#import "JBCellContent.h"
#import "JBCellContentEditorViewController.h"

@interface JBCellContentEditorViewController ()

@end

@implementation JBCellContentEditorViewController

- (void)viewWillAppear:(BOOL)animated;
{
    [super viewWillAppear:animated];
    
    self.labelTextField.text = self.content.label;
}

@end
