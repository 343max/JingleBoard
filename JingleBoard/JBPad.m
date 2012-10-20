//
//  JBCellContent.m
//  JingleBoard
//
//  Created by Max Winde on 30.09.12.
//  Copyright (c) 2012 Max Winde. All rights reserved.
//

#import "JBPad.h"

NSString * const JBCellContentDidChangeNotification = @"JBCellContentDidChangeNotification";

@interface JBPad ()

- (void)postContentDidChangeNotification;

@end


@implementation JBPad

- (void)postContentDidChangeNotification;
{
    [[NSNotificationCenter defaultCenter] postNotificationName:JBCellContentDidChangeNotification
                                                        object:self];
}

- (BOOL)hasAction;
{
    return self.jingleFileURL != nil;
}

- (BOOL)isEmpty;
{
    return self.label == nil && !self.hasAction;
}

- (NSString *)autoLabel;
{
    if (self.label) {
        return self.label;
    } else if (self.jingleFileURL) {
        return [self.jingleFileURL lastPathComponent];
    } else {
        return nil;
    }
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
