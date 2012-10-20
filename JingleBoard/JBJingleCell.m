//
//  JBJingleCell.m
//  JingleBoard
//
//  Created by Max Winde on 29.09.12.
//  Copyright (c) 2012 Max Winde. All rights reserved.
//

#import "JBPad.h"
#import "JBDottedBox.h"
#import "JBJingleCell.h"

@interface JBJingleCell ()

@property (weak) UILabel *textLabel;
@property (weak) UIView *editView;
@property (weak) UIButton *actionButton;

- (void)contentDidChange:(NSNotification *)notification;

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
        
        UIButton *actionButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        actionButton.frame = CGRectInset(self.bounds, 4.0, 4.0);
        actionButton.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [self.contentView addSubview:actionButton];
        _actionButton = actionButton;
        
        for (UILabel *label in @[ textLabel, actionButton.titleLabel ]) {
            label.font = [UIFont boldSystemFontOfSize:16];
            label.minimumScaleFactor = 0.1;
            label.adjustsFontSizeToFitWidth = YES;
            label.numberOfLines = 0;
            label.textAlignment = NSTextAlignmentCenter;
        }
        
        self.selectedBackgroundView = [[UIView alloc] initWithFrame:self.bounds];
        self.selectedBackgroundView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        self.selectedBackgroundView.backgroundColor = [UIColor orangeColor];
    }
    
    return self;
}

- (void)dealloc;
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)setContent:(JBPad *)content;
{
    if (content == _content) {
        return;
    }
    
    if (_content) {
        [[NSNotificationCenter defaultCenter] removeObserver:self
                                                        name:JBCellContentDidChangeNotification
                                                      object:_content];
    }
    
    _content = content;
    
    if (_content) {
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(contentDidChange:)
                                                     name:JBCellContentDidChangeNotification
                                                   object:_content];
    }
    
    [self contentDidChange:nil];
}

- (void)contentDidChange:(NSNotification *)notification;
{
    self.textLabel.text = self.content.autoLabel;
    [self.actionButton setTitle:self.content.autoLabel forState:UIControlStateNormal];
    
    [self setNeedsLayout];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.editView.hidden = !self.editMode || !self.content.isEmpty;
    self.actionButton.userInteractionEnabled = !self.editMode;
    self.actionButton.alpha = (self.editMode ? 0.7 : 1.0);
    
    if (self.content.hasAction) {
        self.actionButton.hidden = NO;
        self.textLabel.hidden = YES;
    } else {
        self.actionButton.hidden = YES;
        self.textLabel.hidden = NO;
    }
}

- (void)setEditMode:(BOOL)editMode;
{
    if (editMode == _editMode) {
        return;
    }
    
    _editMode = editMode;
    
    [self setNeedsLayout];
}

@end
