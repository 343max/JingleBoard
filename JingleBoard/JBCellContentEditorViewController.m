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

- (void)viewDidLoad;
{
    [super viewDidLoad];
    
    self.labelTextField.delegate = self;
}

- (void)viewWillAppear:(BOOL)animated;
{
    [super viewWillAppear:animated];
    
    self.labelTextField.text = self.content.label;
}


#pragma mark UITextFieldDelegate

- (void)textFieldDidEndEditing:(UITextField *)textField;
{
    self.content.label = self.labelTextField.text;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField;
{
    self.content.label = self.labelTextField.text;
    [self.labelTextField resignFirstResponder];
    return YES;
}

@end
