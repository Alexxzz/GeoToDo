//
//  GTDNewTaskViewController.m
//  GeoToDo
//
//  Created by admin on 7/14/13.
//  Copyright (c) 2013 az. All rights reserved.
//

#import "GTDNewTaskViewController.h"
#import "GTDEditTableViewCell.h"
#import "GTDNotesTableViewCell.h"
#import "GTDDetailedTableViewCell.h"
#import "GTDPlacesViewController.h"
#import "GTDTextView.h"
#import "GTDDataStorage.h"
#import "Task.h"
#import "Place.h"

typedef NS_ENUM(NSUInteger, eNewTaskCell) {
    eNewTaskCell_name = 0,
    eNewTaskCell_notes,
    eNewTaskCell_place,
    eNewTaskCell_date,
    
    eNewTaskCell_count
};

@interface GTDNewTaskViewController () <GTDNotesTableViewCellDelegate>

@end

@implementation GTDNewTaskViewController
{
    CGFloat _notesHeight;
    
    UIDatePicker *_datePicker;
    UIView *_blockingView;
    UITapGestureRecognizer *_tapGesture;
    BOOL _keyboardVisible;
    
    NSDateFormatter *_dateFormatter;
    
    Task *_task;
    GTDDataStorage *_dataStorage;
}

- (instancetype)initWithTask:(Task *)task dataStorage:(GTDDataStorage *)dataStorage {
    self = [super initWithStyle:UITableViewStyleGrouped];
    if (self) {
        _task = task;
        _dataStorage = dataStorage;
    }
    return self;
}

- (void)registerCellClass:(Class)class {
    NSString *cellClass = NSStringFromClass(class);
    [self.tableView registerNib:[UINib nibWithNibName:cellClass bundle:nil]
         forCellReuseIdentifier:cellClass];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self registerCellClass:[GTDEditTableViewCell class]];
    [self registerCellClass:[GTDNotesTableViewCell class]];
    [self.tableView registerClass:[GTDDetailedTableViewCell class]
           forCellReuseIdentifier:NSStringFromClass([GTDDetailedTableViewCell class])];
    
    _notesHeight = [GTDNotesTableViewCell initialHeight];
    
    self.title = _task ? _task.title : NSLocalizedString(@"New Task", @"Navigation title for new task");
    
    _datePicker = [[UIDatePicker alloc] init];
    [_datePicker addTarget:self
                    action:@selector(onDateChanged:)
          forControlEvents:UIControlEventValueChanged];
    _blockingView = [[UIView alloc] initWithFrame:self.view.bounds];
    _blockingView.backgroundColor = [UIColor clearColor];
    _tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideDatePicker)];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardDidShow)
                                                 name:UIKeyboardDidShowNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardDidHide)
                                                 name:UIKeyboardDidHideNotification
                                               object:nil];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                                                                           target:self
                                                                                           action:@selector(onDoneButton:)];
    _dateFormatter = [[NSDateFormatter alloc] init];
    _dateFormatter.dateStyle = NSDateFormatterShortStyle;
    _dateFormatter.timeStyle = NSDateFormatterShortStyle;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - Notifications

- (void)keyboardDidShow {
    _keyboardVisible = YES;
}

- (void)keyboardDidHide {
    _keyboardVisible = NO;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return eNewTaskCell_count;
}

- (NSString *)cellIdForIndexPath:(NSIndexPath *)indexPath {
    NSString *cellId = nil;
    
    switch (indexPath.row) {
        case eNewTaskCell_name:
            cellId = NSStringFromClass([GTDEditTableViewCell class]);
            break;
        
        case eNewTaskCell_notes:
            cellId = NSStringFromClass([GTDNotesTableViewCell class]);
            break;
            
        case eNewTaskCell_place:
        case eNewTaskCell_date:
            cellId = NSStringFromClass([GTDDetailedTableViewCell class]);
            break;
            
        default:
            break;
    }
    
    return cellId;
}

- (void)configCell:(UITableViewCell *)cell forIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case eNewTaskCell_name: {
            if (_task)
                ((GTDEditTableViewCell *)cell).textField.text = _task.title;
            
            ((GTDEditTableViewCell *)cell).textField.placeholder = NSLocalizedString(@"Task name", @"Task name cell placeholder");
            break;
        }
            
        case eNewTaskCell_notes: {
            if (_task)
                ((GTDNotesTableViewCell *)cell).textView.text = _task.notes;
                
            ((GTDNotesTableViewCell *)cell).titleLabel.text = NSLocalizedString(@"Notes", @"Notes cell title text");
            ((GTDNotesTableViewCell *)cell).textView.placeholder = NSLocalizedString(@"Enter notes", @"Notes cell placeholder");
            ((GTDNotesTableViewCell *)cell).delegate = self;
            break;
        }
            
        case eNewTaskCell_place: {
            cell.textLabel.text = NSLocalizedString(@"Place", @"Place cell title");
            cell.detailTextLabel.text = NSLocalizedString(@"Not set", @"When some thing is not set");
            break;
        }
            
        case eNewTaskCell_date: {
            cell.textLabel.text = NSLocalizedString(@"Due date", @"Due date cell title");
            cell.detailTextLabel.text = [_dateFormatter stringFromDate:(_task ? _task.dueDate : _datePicker.date)];
            break;
        }
            
        default:
            break;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *CellIdentifier = [self cellIdForIndexPath:indexPath];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier
                                                            forIndexPath:indexPath];
    
    [self configCell:cell forIndexPath:indexPath];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat height = tableView.rowHeight;
    
    if (indexPath.row == eNewTaskCell_notes) {
        height = _notesHeight;
    }
    
    return height;
}

- (void)showDatePicker {
    self.tableView.tableFooterView = _datePicker;
    [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:3 inSection:0]
                          atScrollPosition:UITableViewScrollPositionTop
                                  animated:YES];
    self.tableView.scrollEnabled = NO;
    
    [self.view addGestureRecognizer:_tapGesture];
    _blockingView.height = CGRectGetHeight(self.view.bounds) - CGRectGetHeight(_datePicker.frame);
    [self.view addSubview:_blockingView];
}

- (void)hideDatePicker {
    [UIView animateWithDuration:gDefaultAnimationTime
                     animations:^{
                         [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]
                                               atScrollPosition:UITableViewScrollPositionTop
                                                       animated:NO];
                     }
                     completion:^(BOOL finished) {
                         self.tableView.tableFooterView = nil;
                         self.tableView.scrollEnabled = YES;
                         [self.view removeGestureRecognizer:_tapGesture];
                         [_blockingView removeFromSuperview];
                     }];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    switch (indexPath.row) {
        case eNewTaskCell_place: {
            GTDPlacesViewController *places = [[GTDPlacesViewController alloc] init];
            [self.navigationController pushViewController:places animated:YES];
            break;
        }
            
        case eNewTaskCell_date: {
            
            if (_keyboardVisible) {
                [self.view endEditing:YES];
                
                [UIView animateWithDuration:gDefaultAnimationTime
                                      delay:gDefaultAnimationTime
                                    options:0
                                 animations:nil
                                 completion: ^(BOOL b){
                                     [self showDatePicker];
                                 }];
            } else {
                [self showDatePicker];
            }
            
            break;
        }
            
        default:
            break;
    }
}

#pragma mark - Done button
- (UITableViewCell *)cellForType:(eNewTaskCell)type {
    return [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:type inSection:0]];
}

- (void)onDoneButton:(id)sender {
    if ([_datePicker superview]) {
        [self hideDatePicker];
    } else {
        NSString *title = ((GTDEditTableViewCell*)[self cellForType:eNewTaskCell_name]).textField.text;
        NSString *notes = ((GTDNotesTableViewCell*)[self cellForType:eNewTaskCell_notes]).textView.text;
        NSDate *date = _datePicker.date;
        
        if (_task == nil)
            _task = [_dataStorage newTask];
        _task.title = title;
        _task.notes = notes;
        _task.dueDate = date;
        _task.done = @(NO);
        
        [_dataStorage saveAsyncWithCompletion:^(BOOL success, NSError *error) {
            [self.navigationController popViewControllerAnimated:YES];
        }];
    }
}

#pragma mark - Date picker
- (void)onDateChanged:(UIDatePicker *)sender {
    [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:eNewTaskCell_date inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
}

#pragma mark - GTDNotesTableViewCellDelegate

- (void)notesCell:(GTDNotesTableViewCell *)cell didChangeHeight:(CGFloat)height {
    _notesHeight = height;
    [self.tableView beginUpdates];
    [self.tableView endUpdates];
}

@end
