//
//  JBJingleCell.m
//  JingleBoard
//
//  Created by Max Winde on 29.09.12.
//  Copyright (c) 2012 Max Winde. All rights reserved.
//

#import "JBDottedBox.h"
#import "JBJingleCell.h"

@interface JBJingleCell ()

@property (weak) UIView *editView;

@end


@implementation JBJingleCell

- (id)initWithFrame:(CGRect)frame;
{
    self = [super initWithFrame:frame];
    
    if (self) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        
        JBDottedBox *editView = [[JBDottedBox alloc] initWithFrame:CGRectInset(self.bounds, 4.0, 4.0)];
        editView.strokeColor = [UIColor colorWithWhite:0.842 alpha:1.000];
        editView.lineWidth = 4.0;
        editView.cornerRadius = 8.0;
        editView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        editView.backgroundColor = [UIColor whiteColor];
        editView.hidden = YES;
        [self.contentView addSubview:editView];
        _editView = editView;
        
        UILabel *textLabel = [[UILabel alloc] initWithFrame:CGRectInset(self.bounds, 1.0, 1.0)];
        textLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        textLabel.backgroundColor = [UIColor clearColor];
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
    
    self.editView.hidden = !editMode;
}

@end
