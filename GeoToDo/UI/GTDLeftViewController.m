//
//  GTDMainViewController.m
//  GeoToDo
//
//  Created by admin on 7/10/13.
//  Copyright (c) 2013 az. All rights reserved.
//

#import <PKRevealController.h>
#import "GTDLeftViewController.h"
#import "GTDTasksViewController.h"
#import "GTDPlacesViewController.h"
#import "GTDDataStorage.h"

NS_ENUM(NSUInteger, eGTDTopController) {
    eGTDTopController_Tasks = 0,
    eGTDTopController_Calendar,
    eGTDTopController_Map,
    eGTDTopController_Places,
    eGTDTopController_Completed,
    eGTDTopController_Profile,
    
    eGTDTopController_count
};

@implementation GTDLeftViewController
{
    GTDTasksViewController *_tasksVC;
    GTDPlacesViewController *_placesVC;
    UINavigationController *_navigationController;
    
    GTDDataStorage *_dataStorage;
}

- (instancetype)initWithDataStorage:(GTDDataStorage *)dataStorage {
    self = [super initWithStyle:UITableViewStylePlain];
    if (self) {
        _dataStorage = dataStorage;
        
        _tasksVC = [[GTDTasksViewController alloc] initWithDataStorage:_dataStorage];
        _navigationController = [[UINavigationController alloc] initWithRootViewController:_tasksVC];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.revealController setFrontViewController:_navigationController];
    
    self.tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, CGRectGetHeight([[UIApplication sharedApplication] statusBarFrame]))];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    if (_placesVC == nil)
        _placesVC = [GTDPlacesViewController new];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return eGTDTopController_count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:CellIdentifier];
    
    NSString *itemName = nil;
    switch (indexPath.row) {
        case eGTDTopController_Tasks:
            itemName = NSLocalizedString(@"Tasks", @"Tasks menu text");
            break;
            
        case eGTDTopController_Calendar:
            itemName = NSLocalizedString(@"Calendar", @"Calendar menu text");
            break;
            
        case eGTDTopController_Map:
            itemName = NSLocalizedString(@"Map", @"Map menu text");
            break;
            
        case eGTDTopController_Places:
            itemName = NSLocalizedString(@"Places", @"Places menu text");
            break;
            
        case eGTDTopController_Completed:
            itemName = NSLocalizedString(@"Completed", @"Completed menu text");
            break;
            
        case eGTDTopController_Profile:
            itemName = NSLocalizedString(@"Profile", @"Profile menu text");
            break;
            
        default:
            break;
    }
    
    cell.textLabel.text = itemName;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UIViewController *newVC = _tasksVC;
    
    switch (indexPath.row) {
        case eGTDTopController_Tasks:
            newVC = _tasksVC;
            break;
            
        case eGTDTopController_Calendar:
            break;
            
        case eGTDTopController_Map:
            break;
            
        case eGTDTopController_Places:
            newVC = _placesVC;
            break;
            
        case eGTDTopController_Completed:
            break;
            
        case eGTDTopController_Profile:
            break;
            
        default:
            break;
    }
    
    _navigationController.viewControllers = @[newVC];
    [self.revealController showViewController:_navigationController];
}

@end
