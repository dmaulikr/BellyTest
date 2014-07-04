//
//  BTAAnnotation.h
//  BellyTest
//
//  Created by Jonathan Fox on 6/17/14.
//  Copyright (c) 2014 Jon Fox. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface BTAAnnotation : NSObject <MKAnnotation>

@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;

@property (nonatomic, readonly, copy) NSString * title;
@property (nonatomic, readonly, copy) NSString * subtitle;

-(void)setCoordinate:(CLLocationCoordinate2D)newCoordinate;
-(id)initWithCoordinate:(CLLocationCoordinate2D)coordinate;

-(void)setTitle:(NSString *)title;
-(void)setSubtitle:(NSString *)subtitle;

@end
