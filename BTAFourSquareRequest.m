//
//  BTAFourSquareRequest.m
//  BellyTest
//
//  Created by Jonathan Fox on 6/17/14.
//  Copyright (c) 2014 Jon Fox. All rights reserved.
//

#import "BTAFourSquareRequest.h"

@implementation BTAFourSquareRequest

+ (NSArray *)getVenuesWithLat:(double)latitude andLong:(double)longitude;
{
    NSArray * venues = @[];
    
    NSString * locationURL = [NSString stringWithFormat: @"https://api.foursquare.com/v2/venues/explore?ll=%f,%f&oauth_token=K1KL41A4VXMDGTDPA0IJYW5Y4HPUE2LGO0HTEYTMMACETJAW&v=20140605", latitude, longitude];
    
    NSURLRequest * request = [NSURLRequest requestWithURL:[NSURL URLWithString:locationURL]];
    
    NSData * responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    
    NSDictionary * fsInfo = [NSJSONSerialization JSONObjectWithData:responseData options:0 error:nil];
    
    venues = fsInfo[@"response"][@"groups"][0][@"items"];
        
    return venues;
}


@end
