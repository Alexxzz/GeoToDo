//
//  GTDNewTaskViewController.h
//  GeoToDo
//
//  Created by admin on 7/14/13.
//  Copyright (c) 2013 az. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Task;
@class GTDDataStorage;

@interface GTDNewTaskViewController : UITableViewController

- (instancetype)initWithTask:(Task *)task dataStorage:(GTDDataStorage *)dataStorage;

@end
