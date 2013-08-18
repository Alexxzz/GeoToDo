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
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _dataStorage = [GTDDataStorage sharedInstance];
    
    self.title = NSLocalizedString(@"Tasks", @"Tasks navigation bar title");
    
    //[self.tableView registerNib:[UINib nibWithNibName:@"GTDTaskTableViewCell" bundle:nil] forCellReuseIdentifier:@"GTDTaskTableViewCell"];
    
    _dateFormatter = [[NSDateFormatter alloc] init];
    _dateFormatter.timeStyle = NSDateFormatterMediumStyle;
    _dateFormatter.dateStyle = NSDateFormatterMediumStyle;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [[self.fetchedController sections] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[[self.fetchedController sections][section] objects] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"GTDTaskTableViewCell";
    GTDTaskTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    [self configureCell:cell atIndexPath:indexPath];
    
    return cell;
}

- (void)configureCell:(GTDTaskTableViewCell *)cell atIndexPath:(NSIndexPath *)idxPath {
    Task *task = [self.fetchedController objectAtIndexPath:idxPath];
    cell.titleLabel.text = task.title;
    cell.dueDateLabel.text = [_dateFormatter stringFromDate:task.dueDate];
    cell.delegate = self;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    Task *task = [self.fetchedController objectAtIndexPath:indexPath];
    //GTDTaskViewController *editTask = [[GTDTaskViewController alloc] initWithTask:task dataStorage:_dataStorage];
    //[self.navigationController pushViewController:editTask animated:YES];
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - NSFetchedResultsController
- (NSFetchedResultsController *)fetchedController {
    static NSFetchedResultsController *fetchedController = nil;
    
    if (fetchedController == nil) {
        fetchedController = [Task MR_fetchAllGroupedBy:nil
                                         withPredicate:[NSPredicate predicateWithFormat:@"done == 0"]
                                              sortedBy:@"dueDate"
                                             ascending:YES
                                              delegate:self];
    }
    
    return fetchedController;
}

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
    
    Task *task = [self.fetchedController objectAtIndexPath:idxPath];
    task.done = @(YES);
    
    [_dataStorage save];
}


@end
