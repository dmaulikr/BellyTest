//
//  BTAArrow.m
//  BellyTest
//
//  Created by Jonathan Fox on 6/17/14.
//  Copyright (c) 2014 Jon Fox. All rights reserved.
//

#import "BTAArrowView.h"

@implementation BTAArrowView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

// Custom arrow for Tableview cells
- (void)drawRect:(CGRect)rect
{
    // Arrow
    [[UIColor colorWithRed:0.851f green:0.851f blue:0.851f alpha:1.0f] set];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 3.0);
    
    CGContextClearRect(context, rect);
    
    
    CGContextMoveToPoint(context, 1.5, 1.5);
    CGContextAddLineToPoint(context, 7, 7.5);
    
//    CGContextMoveToPoint(context, 8, 5);
    CGContextAddLineToPoint(context, 1.5, 12.5);
    
    CGContextStrokePath(context);
}


@end
