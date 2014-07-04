//
//  BTAData.m
//  BellyTest
//
//  Created by Jonathan Fox on 6/17/14.
//  Copyright (c) 2014 Jon Fox. All rights reserved.
//

#import "BTAData.h"

@interface BTAData ()

@end

@implementation BTAData

+(BTAData *)mainData
{
    static dispatch_once_t create;
    static BTAData * singleton = nil;
    
    dispatch_once(&create, ^{
        singleton = [[BTAData alloc]init];
    });
    
    return singleton;
}

-(id)init
{
    self = [super init];
    if(self)
    {
        [self loadListItems];
    }
    return self;
}

- (void)saveData{
    NSString * path = [self listArchivePath];
    NSData * data = [NSKeyedArchiver archivedDataWithRootObject:self.listItems];
    [data writeToFile:path options:NSDataWritingAtomic error:nil];
}

-(NSString *)listArchivePath{
    NSArray *documentDirectories = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = documentDirectories[0];
    return [documentDirectory stringByAppendingPathComponent:@"listdata.data"];
}

- (void) loadListItems{
    NSString * path = [self listArchivePath];
    if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
        self.listItems = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
    }
}

@end
