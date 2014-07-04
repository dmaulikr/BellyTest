//
//  BTAAnnotation.m
//  BellyTest
//
//  Created by Jonathan Fox on 6/17/14.
//  Copyright (c) 2014 Jon Fox. All rights reserved.
//

#import "BTAAnnotation.h"

@implementation BTAAnnotation

-(id)initWithCoordinate:(CLLocationCoordinate2D)coordinate
{
    self = [super init];
    if (self) {
        _coordinate = coordinate;
    }
    return self;
}

-(void)setCoordinate:(CLLocationCoordinate2D)newCoordinate;
{
    _coordinate = newCoordinate;
}


-(void)setTitle:(NSString *)title
{
    _title = title;
}

-(void)setSubtitle:(NSString *)subtitle
{
    _subtitle = subtitle;
}
@end
