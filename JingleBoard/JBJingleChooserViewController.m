//
//  JBJingleChooserViewController.m
//  JingleBoard
//
//  Created by Max Winde on 30.09.12.
//  Copyright (c) 2012 Max Winde. All rights reserved.
//

#import "UIViewController+JBCellEditorViewController.h"
#import "JBPad.h"
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

- (void)viewWillAppear:(BOOL)animated;
{
    [super viewWillAppear:animated];
    
    NSString *documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    
    NSMutableArray *files = [[NSMutableArray alloc] init];
    for (NSString *fileName in [[NSFileManager defaultManager] enumeratorAtPath:documentsPath]) {
        NSURL *URL = [NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/%@", documentsPath, fileName]];
        [files addObject:URL];
    }
    
    self.files = [files copy];
}

#pragma mark UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return 1 + self.files.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    if (indexPath.row == 0) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
        cell.textLabel.text = @"None";
        BOOL hasCheckmark = self.content.jingleFileURL == nil;
        cell.accessoryType = (hasCheckmark ? UITableViewCellAccessoryCheckmark : UITableViewCellAccessoryNone);
        
        return cell;
    } else {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
        NSURL *fileURL = self.files[indexPath.row - 1];
        cell.textLabel.text = [fileURL lastPathComponent];
        BOOL hasCheckmark = [self.content.jingleFileURL isEqual:fileURL];
        cell.accessoryType = (hasCheckmark ? UITableViewCellAccessoryCheckmark : UITableViewCellAccessoryNone);
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
{
    if (indexPath.row == 0) {
        self.content.jingleFileURL = nil;
    } else {
        self.content.jingleFileURL = self.files[indexPath.row - 1];
    }
    
    for (UITableViewCell *cell in [tableView visibleCells]) {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    [tableView cellForRowAtIndexPath:indexPath].accessoryType = UITableViewCellAccessoryCheckmark;
    
    int64_t delayInSeconds = 0.9;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [self.navigationController popViewControllerAnimated:YES];
    });
}

@end
