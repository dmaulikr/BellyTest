//
//  BTAViewController.m
//  BellyTest
//
//  Created by Jonathan Fox on 6/17/14.
//  Copyright (c) 2014 Jon Fox. All rights reserved.
//

#import "BTAMapViewController.h"
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "BTAAnnotation.h"
#import "BTAFourSquareRequest.h"
#import "BTATableViewController.h"
#import "BTAData.h"

@interface BTAMapViewController () <CLLocationManagerDelegate, MKMapViewDelegate>

@end

@implementation BTAMapViewController
{
    MKMapView * fsMap;
    CLLocationManager * lmanager;
    CLLocation * currentLocation;
    NSMutableArray * sortedAnnotationInfoArray;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        lmanager = [[CLLocationManager alloc]init];
        lmanager.delegate = self;
        
        lmanager.distanceFilter = 10;
        lmanager.desiredAccuracy = kCLLocationAccuracyBest;
        
        [lmanager startUpdatingLocation];
    }
    return self;
}

- (void)viewDidLoad
{
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    [super viewDidLoad];
    fsMap = [[MKMapView alloc]initWithFrame:self.view.frame];
    fsMap.delegate = self;
    [self.view addSubview:fsMap];
    
    [lmanager stopUpdatingLocation];

}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    [lmanager stopUpdatingLocation];
    
    if (locations == nil) {
        
        for (NSDictionary * location in [BTAData mainData].listItems) {
            currentLocation = location[@"current"];
        }
    }else{
        currentLocation = [locations firstObject];
    }


    BTAAnnotation * annotation = [[BTAAnnotation alloc]initWithCoordinate:currentLocation.coordinate];

    annotation.title = @"YOU ARE HERE";
    annotation.subtitle = @"Wahooey!";
    
    [fsMap removeAnnotation:annotation];
    [fsMap addAnnotation:annotation];

    NSMutableArray * venues = [BTAData mainData].listItems;
    [self createMapAnnotationsWithVenues:venues andLocation:currentLocation.coordinate];
}

-(void)createMapAnnotationsWithVenues:(NSMutableArray *)venues andLocation:(CLLocationCoordinate2D)coordinate
{
    double minLat = coordinate.latitude,
    minLong = coordinate.longitude,
    maxLat = coordinate.latitude,
    maxLong = coordinate.longitude;

    int index = [BTAData mainData].selectedCell;

    sortedAnnotationInfoArray = [@[]mutableCopy];

    for (NSDictionary * item in [BTAData mainData].listItems) {
  
        NSDictionary * nameInfo = item[@"name"];
        NSDictionary * distance = item[@"location"][@"distance"];
        NSDictionary * location = item[@"location"];

        [sortedAnnotationInfoArray addObject:@{
                                @"name":nameInfo,
                                @"distance":distance,
                                @"location":location,
                                    }];
        }
    
    NSDictionary * locationInfo = sortedAnnotationInfoArray[index][@"location"];

    double latitude = [locationInfo[@"lat"]doubleValue];
    double longitude = [locationInfo[@"lng"]doubleValue];

    if (latitude < minLat) minLat = latitude;
    if (latitude > maxLat) maxLat = latitude;
    if (longitude < minLong) minLong = longitude;
    if (longitude > maxLong) maxLong = longitude;

    BTAAnnotation * annotation = [[BTAAnnotation alloc]init];

    [annotation setCoordinate:CLLocationCoordinate2DMake(latitude, longitude)];
    
    [annotation setTitle:sortedAnnotationInfoArray[index][@"name"]];
    [annotation setSubtitle:sortedAnnotationInfoArray[index][@"location"][@"address"]];

    [fsMap addAnnotation:annotation];

    double centerLat = (maxLat - minLat)/2.0 + minLat;
    double centerLong = (maxLong - minLong)/2.0 + minLong;
    
    CLLocationCoordinate2D centerCoordinate = CLLocationCoordinate2DMake(centerLat, centerLong);
    
    MKCoordinateRegion region = MKCoordinateRegionMake(centerCoordinate, MKCoordinateSpanMake(maxLat-minLat + 0.001, maxLong-minLong + 0.001));
    
    [fsMap setRegion:region animated:YES];
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
    
     MKPinAnnotationView * annotationView = [[MKPinAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:@"annotationView"];
    
    
    annotationView.pinColor = MKPinAnnotationColorGreen;
    
    if([[annotation title] isEqualToString:@"YOU ARE HERE"])
    {
        annotationView.pinColor = MKPinAnnotationColorPurple;
    }else{
        annotationView.pinColor = MKPinAnnotationColorGreen;
    }
    
    if (annotationView == nil)
    {
        annotationView = [[MKPinAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:@"annotationView"];
    }else{
        annotationView.annotation = annotation;
    }
    
    annotationView.canShowCallout = YES;
    
    return annotationView;
}


@end
