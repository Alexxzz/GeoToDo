//
//  GTDPlacesViewController.m
//  GeoToDo
//
//  Created by admin on 7/12/13.
//  Copyright (c) 2013 az. All rights reserved.
//

#import "GTDPlacesViewController.h"
#import "GTDDetailedTableViewCell.h"

@interface GTDPlacesViewController ()

@end

@implementation GTDPlacesViewController

- (id)initWithStyle:(UITableViewStyle)style {
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = NSLocalizedString(@"Places", @"Tasks navigation bar title");

    if ([self.navigationController.viewControllers count] == 1)
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"leftMenu.png"]
                                                                                 style:UIBarButtonItemStylePlain
                                                                                target:self
                                                                                action:@selector(onShowMenu:)];

}

- (void)onShowMenu:(id)sender {
    [self.navigationController.revealController showViewController:self.navigationController.revealController.leftViewController];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    GTDDetailedTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier
                                                                     forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}

@end
