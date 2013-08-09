//
//  Place.h
//  GeoToDo
//
//  Created by admin on 7/10/13.
//  Copyright (c) 2013 az. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Task;

@interface Place : NSManagedObject

@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSNumber * latitude;
@property (nonatomic, retain) NSNumber * longtitude;
@property (nonatomic, retain) NSSet *task;
@end

@interface Place (CoreDataGeneratedAccessors)

- (void)addTaskObject:(Task *)value;
- (void)removeTaskObject:(Task *)value;
- (void)addTask:(NSSet *)values;
- (void)removeTask:(NSSet *)values;

@end
