//
//  JBDottedBox.m
//  JingleBoard
//
//  Created by Max Winde on 30.09.12.
//  Copyright (c) 2012 Max Winde. All rights reserved.
//

#import "JBDottedBox.h"

@interface JBDottedBox ()

- (CGPathRef)pathForRoundedRect:(CGRect)frame cornerRadius:(CGFloat)cornerRadius;

@end


@implementation JBDottedBox

- (id)initWithFrame:(CGRect)frame;
{
    self = [super initWithFrame:frame];
    
    if (self) {
        self.contentMode = UIViewContentModeRedraw;
    }
    
    return self;
}

- (void)setStrokeColor:(UIColor *)strokeColor;
{
    _strokeColor = strokeColor;
    [self setNeedsDisplay];
}

- (void)setCornerRadius:(CGFloat)cornerRadius;
{
    _cornerRadius = cornerRadius;
    [self setNeedsDisplay];
}

- (void)setLineWidth:(CGFloat)lineWidth;
{
    _lineWidth = lineWidth;
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect;
{
    [super drawRect:rect];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSaveGState(context); {
        
        CGContextSetStrokeColorWithColor(context, self.strokeColor.CGColor);
        CGPathRef roundedRectPath = [self pathForRoundedRect:CGRectInset(self.bounds, self.lineWidth / 2.0, self.lineWidth / 2.0)
                                                cornerRadius:self.cornerRadius];
        CGFloat dashes[] = { 8.0, 3.0 };
        CGContextSetLineDash(context, 0.0, dashes, 2);
        CGContextSetLineWidth(context, self.lineWidth);
        CGContextAddPath(context, roundedRectPath);
        CGContextStrokePath(context);
        
    } CGContextRestoreGState(context);
}

- (void)layoutIfNeeded;
{
    [super layoutIfNeeded];
    [self setNeedsDisplay];
}

- (CGPathRef)pathForRoundedRect:(CGRect)frame cornerRadius:(CGFloat)cornerRadius;
{
    CGMutablePathRef retPath = CGPathCreateMutable();
    
	CGRect innerRect = CGRectInset(frame, cornerRadius, cornerRadius);
    
	CGFloat inside_right = innerRect.origin.x + innerRect.size.width;
	CGFloat outside_right = frame.origin.x + frame.size.width;
	CGFloat inside_bottom = innerRect.origin.y + innerRect.size.height;
	CGFloat outside_bottom = frame.origin.y + frame.size.height;
    
	CGFloat inside_top = innerRect.origin.y;
	CGFloat outside_top = frame.origin.y;
	CGFloat outside_left = frame.origin.x;
    
	CGPathMoveToPoint(retPath, NULL, innerRect.origin.x, outside_top);
    
	CGPathAddLineToPoint(retPath, NULL, inside_right, outside_top);
	CGPathAddArcToPoint(retPath, NULL, outside_right, outside_top, outside_right, inside_top, cornerRadius);
	CGPathAddLineToPoint(retPath, NULL, outside_right, inside_bottom);
	CGPathAddArcToPoint(retPath, NULL,  outside_right, outside_bottom, inside_right, outside_bottom, cornerRadius);
    
	CGPathAddLineToPoint(retPath, NULL, innerRect.origin.x, outside_bottom);
	CGPathAddArcToPoint(retPath, NULL,  outside_left, outside_bottom, outside_left, inside_bottom, cornerRadius);
	CGPathAddLineToPoint(retPath, NULL, outside_left, inside_top);
	CGPathAddArcToPoint(retPath, NULL,  outside_left, outside_top, innerRect.origin.x, outside_top, cornerRadius);
    
	CGPathCloseSubpath(retPath);
    
	return retPath;
}

@end
