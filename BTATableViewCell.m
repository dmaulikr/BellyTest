//
//  BTATableViewCell.m
//  BellyTest
//
//  Created by Jonathan Fox on 6/17/14.
//  Copyright (c) 2014 Jon Fox. All rights reserved.
//

#import "BTATableViewCell.h"
#import "BTAArrowView.h"

@implementation BTATableViewCell

{
    UIImageView * businessImage;
    BTAArrowView * arrow;
    UILabel * businessName;
    UILabel * businessDistance;
    UILabel * businessCategory;
    UILabel * businessStatus;
}

// Customize the cells
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {        
        businessImage = [[UIImageView alloc] initWithFrame:CGRectMake(12.5, 12.5, 60, 60)];
        businessImage.contentMode = UIViewContentModeScaleToFill;
        businessStatus.layer.masksToBounds = YES;
        businessImage.backgroundColor = [UIColor colorWithRed:0.851f green:0.851f blue:0.851f alpha:1.0f];
        [self.contentView addSubview:businessImage];
        
        businessName = [[UILabel alloc] initWithFrame:CGRectMake(83, 14, 170, 20)];
        businessName.textColor = [UIColor colorWithRed:0.400f green:0.400f blue:0.400f alpha:1.0f];
        businessName.backgroundColor = [UIColor clearColor];
        businessName.font = [UIFont fontWithName:@"HelveticaNeue" size:16];
        [self.contentView addSubview:businessName];
        
        businessDistance = [[UILabel alloc] initWithFrame:CGRectMake(83, 33, 170, 20)];
        businessDistance.textColor = [UIColor colorWithRed:0.400f green:0.400f blue:0.400f alpha:1.0f];
        businessDistance.backgroundColor = [UIColor clearColor];
        businessDistance.font = [UIFont fontWithName:@"HelveticaNeue-thin" size:12];
        [self.contentView addSubview:businessDistance];
        
        businessCategory = [[UILabel alloc] initWithFrame:CGRectMake(83, 51, 170, 20)];
        businessCategory.textColor = [UIColor colorWithRed:0.663f green:0.663f blue:0.663f alpha:1.0f];
        businessCategory.backgroundColor = [UIColor clearColor];
        businessCategory.font = [UIFont systemFontOfSize: 12];
        [self.contentView addSubview:businessCategory];
        
        businessStatus = [[UILabel alloc] initWithFrame:CGRectMake(self.contentView.frame.size.width-50, self.contentView.frame.size.height/2-7, 50, 20)];
        businessStatus.backgroundColor = [UIColor clearColor];
        businessStatus.font = [UIFont systemFontOfSize: 10];
        [self.contentView addSubview:businessStatus];
        
        arrow = [[BTAArrowView alloc] initWithFrame:CGRectMake(self.contentView.frame.size.width-30, self.contentView.frame.size.height/2+13, 10, 16)];
        arrow.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:arrow];
        
    }
    return self;
}

// Load data into custom cells
-(void)setIndex:(NSDictionary * )index
{
    _index = index;
    
    // show store icon
    NSString * iconName = [NSString stringWithFormat:@"%@88.png",index[@"icon"]];
    
    NSURL * imageURL = [NSURL URLWithString:iconName];

    NSData * imageData = [NSData dataWithContentsOfURL:imageURL];

    UIImage * image = [UIImage imageWithData:imageData];

    businessImage.image = image;
    
    // show store name
    businessName.text = index[@"name"];

    // Convert meters to miles and show distance
    int meters = [index[@"distance"]intValue];
    float miles = meters * 0.00062137;
    NSString * distance = [NSString stringWithFormat:@"%.02f miles away", miles];
    businessDistance.text = distance;
    
    // show store category
    businessCategory.text = index[@"category"];
    
    // show store open/closed status
    NSString * status = [NSString stringWithFormat:@"%@", index[@"status"]];
                         
    if ([status isEqual: @"1"]){
       businessStatus.textColor = [UIColor colorWithRed:0.098f green:0.737f blue:0.259f alpha:1.0f];
       businessStatus.text = @"OPEN";
    }else if ([status isEqual: @"0"]){
       businessStatus.textColor = [UIColor colorWithRed:0.851f green:0.851f blue:0.851f alpha:1.0f];
       businessStatus.text = @"CLOSED";
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

@end
