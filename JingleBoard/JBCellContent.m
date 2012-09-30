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

- (BOOL)isEmpty;
{
    return self.label == nil;
}

- (void)setLabel:(NSString *)label;
{
    if ([label isEqualToString:@""]) {
        label = nil;
    }
    
    _label = label;
    [self postContentDidChangeNotification];
}

- (void)setJingleFileURL:(NSURL *)jingleFileURL;
{
    _jingleFileURL = jingleFileURL;
    [self postContentDidChangeNotification];
}

@end
