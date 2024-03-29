//
//  JBDrumPadViewController.m
//  JingleBoard
//
//  Created by Max Winde on 28.09.12.
//  Copyright (c) 2012 Max Winde. All rights reserved.
//

#import "JBDrumPadViewController.h"
#import "JBPad.h"
#import "JBCellContentEditorNavigationController.h"
#import "JBJingleCell.h"

@interface JBDrumPadViewController ()

@property (strong) NSMutableArray *pads;
@property (assign, nonatomic) BOOL editMode;
@property (strong, nonatomic) UIPopoverController *cellEditorPopoverController;
@property (nonatomic, readonly) NSString *padArchiveFilename;

- (void)toggleEditMode:(id)sender;
- (void)padsDidChange:(NSNotification *)notification;

@end


@implementation JBDrumPadViewController

- (id)initWithCollectionViewLayout:(UICollectionViewLayout *)layout;
{
    self = [super initWithCollectionViewLayout:layout];
    
    if (self) {
        _pads = [NSKeyedUnarchiver unarchiveObjectWithFile:self.padArchiveFilename];

        if (_pads == nil) {
            _pads = [[NSMutableArray alloc] initWithCapacity:8 * 6];
            for(NSInteger i = 0; i < 6 * 8; i++) {
                JBPad *content = [[JBPad alloc] init];
                _pads[i] = content;
            }
        }
    }
    
    return self;
}

- (void)viewDidLoad;
{
    self.editMode = NO;

    [self.collectionView registerClass:[JBJingleCell class]
       forCellWithReuseIdentifier:@"JingleCell"];

    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    self.collectionView.backgroundColor = [UIColor whiteColor];
}

- (void)viewWillAppear:(BOOL)animated;
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(padsDidChange:)
                                                 name:JBCellContentDidChangeNotification
                                               object:nil];
}

- (void)viewWillDisappear:(BOOL)animated;
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLayoutSubviews;
{
    UICollectionViewFlowLayout *flowLayout = (UICollectionViewFlowLayout *)self.collectionView.collectionViewLayout;
    CGSize itemSize = self.view.bounds.size;
    itemSize.width /= 8.0;
    itemSize.height /= 6.0;
    flowLayout.itemSize = itemSize;
    flowLayout.minimumInteritemSpacing = 0.0;
    flowLayout.minimumLineSpacing = 0.0;
}

- (void)toggleEditMode:(id)sender;
{
    self.editMode = !self.editMode;
}

- (NSString *)padArchiveFilename;
{
    NSString *documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    return [documentsPath stringByAppendingPathComponent:@"Pads.plist"];
}

- (void)padsDidChange:(NSNotification *)notification;
{
    [NSKeyedArchiver archiveRootObject:self.pads
                                toFile:self.padArchiveFilename];
}

- (void)setEditMode:(BOOL)editMode;
{
    _editMode = editMode;
    
    UIBarButtonItem *toggleButton;
    if (!editMode) {
        toggleButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit
                                                                     target:self
                                                                     action:@selector(toggleEditMode:)];
    } else {
        toggleButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                                                     target:self
                                                                     action:@selector(toggleEditMode:)];
    }
    [self.navigationItem setRightBarButtonItem:toggleButton animated:NO];
    
    self.collectionView.allowsSelection = editMode;
    
    for (JBJingleCell *cell in self.collectionView.visibleCells) {
        cell.editMode = editMode;
    }
}

- (void)setCellEditorPopoverController:(UIPopoverController *)cellEditorPopoverController;
{
    if (_cellEditorPopoverController == cellEditorPopoverController) {
        return;
    }
    
    if (_cellEditorPopoverController) {
        [_cellEditorPopoverController dismissPopoverAnimated:YES];
    }
    
    _cellEditorPopoverController = cellEditorPopoverController;
}

#pragma mark UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView;
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section;
{
    return 8 * 6;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath;
{    
    JBJingleCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"JingleCell"
                                                                   forIndexPath:indexPath];
    
    cell.content = self.pads[indexPath.row];
    cell.editMode = self.editMode;
    
    return cell;
}


#pragma mark UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath;
{
    NSLog(@"selected Cell %i", indexPath.row);
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"CellContentEditor" bundle:nil];
    UIViewController *viewController = [storyboard instantiateInitialViewController];
    
    JBCellContentEditorNavigationController *navigationController = [[JBCellContentEditorNavigationController alloc] initWithRootViewController:viewController];
    navigationController.content = self.pads[indexPath.row];
    
    self.cellEditorPopoverController = [[UIPopoverController alloc] initWithContentViewController:navigationController];
    UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
    [self.cellEditorPopoverController presentPopoverFromRect:cell.bounds
                                                      inView:cell.contentView
                                    permittedArrowDirections:UIPopoverArrowDirectionAny
                                                    animated:YES];
}

@end
