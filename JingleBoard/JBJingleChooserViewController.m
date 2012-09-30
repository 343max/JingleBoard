//
//  JBJingleChooserViewController.m
//  JingleBoard
//
//  Created by Max Winde on 30.09.12.
//  Copyright (c) 2012 Max Winde. All rights reserved.
//

#import "UIViewController+JBCellEditorViewController.h"
#import "JBCellContent.h"
#import "JBJingleChooserViewController.h"

@interface JBJingleChooserViewController ()

@property (strong) NSArray *files;

@end

@implementation JBJingleChooserViewController

- (void)viewDidLoad;
{
    [super viewDidLoad];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
}

#pragma mark UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    if (indexPath.row == 0) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
        cell.textLabel.text = @"None";
        BOOL hasCheckmark = self.content.jingleFileURL == nil;
        cell.accessoryType = (hasCheckmark ? UITableViewCellAccessoryCheckmark : UITableViewCellAccessoryNone);
        
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
{
    if (indexPath.row == 0) {
        self.content.jingleFileURL = nil;
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}

@end
