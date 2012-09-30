//
//  JBCellContent.h
//  JingleBoard
//
//  Created by Max Winde on 30.09.12.
//  Copyright (c) 2012 Max Winde. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString * const JBCellContentDidChangeNotification;

@interface JBCellContent : NSObject

@property (assign, nonatomic, readonly) BOOL isEmpty;

@property (strong, nonatomic) NSString *label;

@end
