//
//  JBCellContentEditorViewController.h
//  JingleBoard
//
//  Created by Max Winde on 30.09.12.
//  Copyright (c) 2012 Max Winde. All rights reserved.
//

#import <UIKit/UIKit.h>

@class JBPad;

@interface JBCellContentEditorViewController : UITableViewController <UITextFieldDelegate>

@property (weak) IBOutlet UITextField *labelTextField;
@property (weak) IBOutlet UITableViewCell *selectSoundCell;

@end
