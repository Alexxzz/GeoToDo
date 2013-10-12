//
//  GTDPlaceViewController.m
//  GeoToDo
//
//  Created by Alexander Zagorsky on 8/27/13.
//  Copyright (c) 2013 az. All rights reserved.
//

#import "GTDPlaceViewController.h"

@interface GTDPlaceViewController ()

@end

@implementation GTDPlaceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.titleTextField.placeholder = NSLocalizedString(@"Title", @"Place title placeholder");
    self.addressLabel.text = NSLocalizedString(@"Address", @"Address placeholder");
    self.tasksLabel.text = NSLocalizedString(@"Tasks", @"Tasks text");
    self.tasksCountLabel.text = @"0";
}

@end
