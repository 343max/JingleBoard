//
//  JBCellContentEditorViewController.h
//  JingleBoard
//
//  Created by Max Winde on 30.09.12.
//  Copyright (c) 2012 Max Winde. All rights reserved.
//

#import <UIKit/UIKit.h>

@class JBCellContent;

@interface JBCellContentEditorViewController : UITableViewController <UITextFieldDelegate>

@property (weak) IBOutlet UITextField *labelTextField;

@end
