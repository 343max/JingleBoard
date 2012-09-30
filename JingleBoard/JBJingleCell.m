//
//  JBJingleCell.m
//  JingleBoard
//
//  Created by Max Winde on 29.09.12.
//  Copyright (c) 2012 Max Winde. All rights reserved.
//

#import "JBJingleCell.h"

@implementation JBJingleCell

- (id)initWithFrame:(CGRect)frame;
{
    self = [super initWithFrame:frame];
    
    if (self) {
        UILabel *textLabel = [[UILabel alloc] initWithFrame:CGRectInset(self.bounds, 1.0, 1.0)];
        textLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        textLabel.backgroundColor = [UIColor blueColor];
        [self.contentView addSubview:textLabel];
        _textLabel = textLabel;
    }
    
    return self;
}

- (void)setEditMode:(BOOL)editMode;
{
    if (editMode == _editMode) {
        return;
    }
    
    _editMode = editMode;
    
    self.textLabel.backgroundColor = (editMode ? [UIColor orangeColor] : [UIColor blueColor]);
}

@end
