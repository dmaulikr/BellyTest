//
//  BTAFourSquareRequest.h
//  BellyTest
//
//  Created by Jonathan Fox on 6/17/14.
//  Copyright (c) 2014 Jon Fox. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BTAFourSquareRequest : NSObject

+ (NSArray *)getVenuesWithLat:(double)latitude andLong:(double)longitude;

@end
