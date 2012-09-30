//
//  JBDrumPadViewController.m
//  JingleBoard
//
//  Created by Max Winde on 28.09.12.
//  Copyright (c) 2012 Max Winde. All rights reserved.
//

#import "JBDrumPadViewController.h"
#import "JBCellContent.h"
#import "JBCellContentEditorViewController.h"
#import "JBJingleCell.h"

@interface JBDrumPadViewController ()

@property (strong) NSMutableArray *sounds;
@property (assign, nonatomic) BOOL editMode;
@property (strong, nonatomic) UIPopoverController *cellEditorPopoverController;

- (void)toggleEditMode:(id)sender;

@end


@implementation JBDrumPadViewController

- (id)initWithCollectionViewLayout:(UICollectionViewLayout *)layout;
{
    self = [super initWithCollectionViewLayout:layout];
    
    if (self) {
        _sounds = [[NSMutableArray alloc] initWithCapacity:8 * 6];
        for(NSInteger i = 0; i < 6 * 8; i++) {
            JBCellContent *content = [[JBCellContent alloc] init];
            content.label = [NSString stringWithFormat:@"Cell %i", i];
            _sounds[i] = content;
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

- (void)viewDidLayoutSubviews;
{
    UICollectionViewFlowLayout *flowLayout = (UICollectionViewFlowLayout *)self.collectionView.collectionViewLayout;
    CGSize itemSize = self.view.bounds.size;
    itemSize.width /= 8.0;
    itemSize.height /= 6.0;
//    itemSize = CGSizeMake(60, 50);
    NSLog(@"itemSize: %@", NSStringFromCGSize(itemSize));
    flowLayout.itemSize = itemSize;
    flowLayout.minimumInteritemSpacing = 0.0;
    flowLayout.minimumLineSpacing = 0.0;
//    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
}

- (void)toggleEditMode:(id)sender;
{
    self.editMode = !self.editMode;
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
    
    cell.content = self.sounds[indexPath.row];
    cell.editMode = self.editMode;
    
    return cell;
}


#pragma mark UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath;
{
    NSLog(@"selected Cell %i", indexPath.row);
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"CellContentEditor" bundle:nil];
    JBCellContentEditorViewController *viewController = [storyboard instantiateInitialViewController];
    viewController.content = self.sounds[indexPath.row];
    
    self.cellEditorPopoverController = [[UIPopoverController alloc] initWithContentViewController:viewController];
    UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
    [self.cellEditorPopoverController presentPopoverFromRect:cell.bounds
                                                      inView:cell.contentView
                                    permittedArrowDirections:UIPopoverArrowDirectionAny
                                                    animated:YES];
}

@end
