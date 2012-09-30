//
//  JBJingleCell.m
//  JingleBoard
//
//  Created by Max Winde on 29.09.12.
//  Copyright (c) 2012 Max Winde. All rights reserved.
//

#import "JBCellContent.h"
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
        JBDottedBox *editView = [[JBDottedBox alloc] initWithFrame:CGRectInset(self.bounds, 4.0, 4.0)];
        editView.strokeColor = [UIColor colorWithWhite:0.842 alpha:1.000];
        editView.lineWidth = 4.0;
        editView.cornerRadius = 8.0;
        editView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        editView.backgroundColor = [UIColor clearColor];
        editView.hidden = YES;
        [self.contentView addSubview:editView];
        _editView = editView;
        
        UILabel *textLabel = [[UILabel alloc] initWithFrame:CGRectInset(self.bounds, 1.0, 1.0)];
        textLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        textLabel.backgroundColor = [UIColor clearColor];
        textLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:textLabel];
        _textLabel = textLabel;
        
        self.selectedBackgroundView = [[UIView alloc] initWithFrame:self.bounds];
        self.selectedBackgroundView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        self.selectedBackgroundView.backgroundColor = [UIColor orangeColor];
    }
    
    return self;
}

- (void)setContent:(JBCellContent *)content;
{
    if (content == _content) {
        return;
    }
    
    _content = content;
    
    self.textLabel.text = content.label;
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
