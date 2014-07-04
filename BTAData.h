//
//  BTAData.h
//  BellyTest
//
//  Created by Jonathan Fox on 6/17/14.
//  Copyright (c) 2014 Jon Fox. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BTAData : NSObject

+(BTAData *)mainData;

@property (nonatomic) int selectedCell;
@property (nonatomic) NSMutableArray * listItems;

- (void)saveData;
- (void) loadListItems;

@end
