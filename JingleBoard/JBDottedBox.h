//
//  JBDottedBox.h
//  JingleBoard
//
//  Created by Max Winde on 30.09.12.
//  Copyright (c) 2012 Max Winde. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JBDottedBox : UIView

@property (strong, nonatomic) UIColor *strokeColor;
@property (assign, nonatomic) CGFloat cornerRadius;
@property (assign, nonatomic) CGFloat lineWidth;

@end
