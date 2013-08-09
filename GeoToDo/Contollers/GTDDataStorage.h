//
//  GTDDataStorage.h
//  GeoToDo
//
//  Created by admin on 7/31/13.
//  Copyright (c) 2013 az. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Task;
@class Place;

@interface GTDDataStorage : NSObject

+ (instancetype)sharedInstance;
+ (void)registerInstance:(GTDDataStorage *)instance;

- (Task *)newTask;

- (NSArray *)tasks;

- (void)saveAsyncWithCompletion:(void(^)(BOOL success, NSError *error))completion;
- (void)save;

@end
