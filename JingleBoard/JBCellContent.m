//
//  JBCellContent.m
//  JingleBoard
//
//  Created by Max Winde on 30.09.12.
//  Copyright (c) 2012 Max Winde. All rights reserved.
//

#import "JBCellContent.h"

NSString * const JBCellContentDidChangeNotification = @"JBCellContentDidChangeNotification";

@interface JBCellContent ()

- (void)postContentDidChangeNotification;

@end


@implementation JBCellContent

- (void)postContentDidChangeNotification;
{
    [[NSNotificationCenter defaultCenter] postNotificationName:JBCellContentDidChangeNotification
                                                        object:self];
}

- (void)setLabel:(NSString *)label;
{
    _label = label;
    [self postContentDidChangeNotification];
}

@end
