//
//  GTDTasksViewController.m
//  GeoToDo
//
//  Created by admin on 7/11/13.
//  Copyright (c) 2013 az. All rights reserved.
//

#import "GTDTasksViewController.h"
#import "GTDTaskViewController.h"
#import <PKRevealController.h>
#import "GTDDataStorage.h"
#import "Task.h"
#import "GTDTaskTableViewCell.h"

@interface GTDTasksViewController () <NSFetchedResultsControllerDelegate, GTDTaskTableViewCellDelegate>

@end

@implementation GTDTasksViewController
{
    NSDateFormatter *_dateFormatter;
    GTDDataStorage *_dataStorage;
    NSFetchedResultsController *_fetchedController;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _dataStorage = [GTDDataStorage sharedInstance];
    
    self.title = NSLocalizedString(@"Tasks", @"Tasks navigation bar title");
    
    _fetchedController = [_dataStorage tasksFetchedResultsControllerWithDelegate:self];
    
    _dateFormatter = [[NSDateFormatter alloc] init];
    _dateFormatter.timeStyle = NSDateFormatterMediumStyle;
    _dateFormatter.dateStyle = NSDateFormatterMediumStyle;
}

- (void)dealloc {
    self.tableView.delegate = nil;
    self.tableView.dataSource = nil;
    _fetchedController.delegate = nil;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    NSIndexPath *selectedIndexPath = [self.tableView indexPathForCell:sender];
    Task *task = [_fetchedController objectAtIndexPath:selectedIndexPath];
    
    if (task == nil)
        return;
    
    GTDTaskViewController *taskVC = segue.destinationViewController;
    taskVC.task = task;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [[_fetchedController sections] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[[_fetchedController sections][section] objects] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"GTDTaskTableViewCell";
    GTDTaskTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    [self configureCell:cell atIndexPath:indexPath];
    
    return cell;
}

- (void)configureCell:(GTDTaskTableViewCell *)cell atIndexPath:(NSIndexPath *)idxPath {
    Task *task = [_fetchedController objectAtIndexPath:idxPath];
    cell.titleLabel.text = task.title;
    cell.dueDateLabel.text = [_dateFormatter stringFromDate:task.dueDate];
    cell.delegate = self;
}

#pragma mark - NSFetchedResultsController
- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller {
    [self.tableView beginUpdates];
}

- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject
       atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type
      newIndexPath:(NSIndexPath *)newIndexPath {
    
    UITableView *tableView = self.tableView;
    
    switch(type) {
            
        case NSFetchedResultsChangeInsert:
            [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath]
                             withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]
                             withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeUpdate:
            [self configureCell:(GTDTaskTableViewCell *)[tableView cellForRowAtIndexPath:indexPath]
                    atIndexPath:indexPath];
            break;
            
        case NSFetchedResultsChangeMove:
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]
                             withRowAnimation:UITableViewRowAnimationFade];
            [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath]
                             withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}


- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    [self.tableView endUpdates];
}

#pragma mark - GTDTaskTableViewCellDelegate

- (void)didDoneButtonPressedForCell:(GTDTaskTableViewCell *)cell {
    NSIndexPath *idxPath = [self.tableView indexPathForCell:cell];
    
    Task *task = [_fetchedController objectAtIndexPath:idxPath];
    task.done = @(YES);
    
    [_dataStorage save];
}


@end
