//
//  BTATableVCTableViewController.m
//  BellyTest
//
//  Created by Jonathan Fox on 6/17/14.
//  Copyright (c) 2014 Jon Fox. All rights reserved.
//

#import "BTATableViewController.h"
#import "BTATableViewCell.h"
#import "BTAFourSquareRequest.h"
#import "BTAMapViewController.h"
#import "BTAData.h"

#import <CoreLocation/CoreLocation.h>

@interface BTATableViewController () <CLLocationManagerDelegate>

@end

@implementation BTATableViewController
{
    CLLocationManager * lmanager;
    CLLocation * currentLocation;
    NSArray * venueProfilesCopy;
    UIActivityIndicatorView *spinner;
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
                
        lmanager = [[CLLocationManager alloc]init];
        lmanager.delegate = self;
        
        [lmanager startUpdatingLocation];
        
        spinner = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        spinner.center = CGPointMake(160, 125);
        spinner.hidesWhenStopped = YES;
        [spinner setColor:[UIColor lightGrayColor]];
        [self.view addSubview:spinner];
        [spinner startAnimating];
    }
    return self;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UILabel * navTitle = [[UILabel alloc]initWithFrame:CGRectMake(150, 0, 100, 20)];
    navTitle.text = @"Locations";
    navTitle.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:17];
    navTitle.textColor = [UIColor whiteColor];
    navTitle.textAlignment = 1;
    self.navigationItem.titleView = navTitle;
    
    self.tableView.rowHeight = 83;
    self.tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshTableView) name:UIApplicationWillEnterForegroundNotification object:[UIApplication sharedApplication]];
}

-(void)refreshTableView
{
    [self.tableView reloadData];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    [lmanager stopUpdatingLocation];
    
    self.venueProfiles = [@[]mutableCopy];
    
    // Get current location
    currentLocation = [locations firstObject];
    
    // Get venues
    NSArray * venues = [BTAFourSquareRequest getVenuesWithLat:currentLocation.coordinate.latitude andLong:currentLocation.coordinate.longitude];
    
    for (NSDictionary * venue in venues) {
        
        NSDictionary * venueInfo = venue[@"venue"];
        
        NSDictionary * icon = venueInfo[@"categories"][0][@"icon"][@"prefix"];
        NSDictionary * nameInfo = venueInfo[@"name"];
        NSDictionary * location = venueInfo[@"location"];
        NSDictionary * distance = venueInfo[@"location"][@"distance"];
        NSDictionary * status = venueInfo[@"hours"][@"isOpen"];
        NSDictionary * category = venueInfo[@"categories"][0][@"shortName"];
        
        if (status == nil) {
            status = @{@"nil":@""};
        }

        [self.venueProfiles addObject:@{
                @"icon": icon,
                @"name":nameInfo,
                @"location":location,
                @"distance":distance,
                @"status":status,
                @"category":category,
                @"current":currentLocation
            }];
        }
    
    // get info from singleton if info is not available, else display error alert.
    if ([self.venueProfiles count] == 0)
    {
        [[BTAData mainData] loadListItems];
        self.venueProfiles = [BTAData mainData].listItems;
    }else if ([[BTAData mainData].listItems count] == 0 && [self.venueProfiles count] == 0){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"Sorry" message: @"Not connected to internet. Please try again later." delegate: nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }else{
        [BTAData mainData].listItems = self.venueProfiles;
        [[BTAData mainData]saveData];
    }
    
    // Sort the information by distance. Nearest to furthest.
    NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"distance" ascending:YES];
    [self.venueProfiles sortUsingDescriptors:@[sort]];
    
    [self.tableView reloadData];
    
    [spinner removeFromSuperview];
}

-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"ERROR: %@", error);
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{    
    return [self.venueProfiles count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BTATableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (cell == nil) {
        cell = [[BTATableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.index = self.venueProfiles[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{    
    [BTAData mainData].selectedCell = (int)indexPath.row;

    BTAMapViewController * mapVC = [[BTAMapViewController alloc]init];
    [self.navigationController pushViewController:mapVC animated:YES];

    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
