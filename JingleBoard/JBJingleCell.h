//
//  JBJingleCell.h
//  JingleBoard
//
//  Created by Max Winde on 29.09.12.
//  Copyright (c) 2012 Max Winde. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JBJingleCell : UICollectionViewCell

@property (weak, readonly) UILabel *textLabel;
@property (assign, nonatomic) BOOL editMode;

@end
