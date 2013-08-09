//
//  Task.h
//  GeoToDo
//
//  Created by admin on 7/10/13.
//  Copyright (c) 2013 az. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Task : NSManagedObject

@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSString * notes;
@property (nonatomic, retain) NSDate * dueDate;
@property (nonatomic, retain) NSNumber * done;
@property (nonatomic, retain) NSManagedObject *place;

@end
