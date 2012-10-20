//
//  JBCellContent.h
//  JingleBoard
//
//  Created by Max Winde on 30.09.12.
//  Copyright (c) 2012 Max Winde. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString * const JBCellContentDidChangeNotification;

@interface JBPad : NSObject

@property (assign, nonatomic, readonly) BOOL isEmpty;
@property (assign, nonatomic, readonly) BOOL hasAction;

@property (strong, nonatomic) NSString *label;
@property (strong, nonatomic, readonly) NSString *autoLabel;
@property (strong, nonatomic) NSURL *jingleFileURL;

@end
