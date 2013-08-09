//
//  GTDMainViewController.h
//  GeoToDo
//
//  Created by admin on 7/10/13.
//  Copyright (c) 2013 az. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GTDDataStorage;

@interface GTDLeftViewController : UITableViewController

- (instancetype)initWithDataStorage:(GTDDataStorage *)dataStorage;

@end
