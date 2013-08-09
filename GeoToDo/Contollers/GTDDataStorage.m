//
//  GTDDataStorage.m
//  GeoToDo
//
//  Created by admin on 7/31/13.
//  Copyright (c) 2013 az. All rights reserved.
//

#import "GTDDataStorage.h"
#import "Task.h"
#import "Place.h"

static GTDDataStorage *__instance = nil;

@implementation GTDDataStorage

#pragma mark - Shared instance methods
+ (instancetype)sharedInstance {
    return __instance;
}

+ (void)registerInstance:(GTDDataStorage *)instance {
    __instance = instance;
}

#pragma mark - Init methods
- (instancetype)init {
    self = [super init];
    if (self) {
        [MagicalRecord setupCoreDataStack];
    }
    return self;
}

#pragma mark - Data access methods
- (Task *)newTask {
    return [Task MR_createEntity];
}

- (NSArray *)tasks {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"done == %@", @(NO)];
    return [Task MR_findAllSortedBy:@"dueDate" ascending:YES withPredicate:predicate];
}

#pragma mark - Saving
- (void)saveAsyncWithCompletion:(void(^)(BOOL success, NSError *error))completion {
    [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreWithCompletion:^(BOOL success, NSError *error) {
        if (completion)
            completion(success, error);
    }];
}

- (void)save {
    [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
}

@end
