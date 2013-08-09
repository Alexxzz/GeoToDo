//
//  GTDTaskTableViewCell.m
//  GeoToDo
//
//  Created by admin on 8/6/13.
//  Copyright (c) 2013 az. All rights reserved.
//

#import "GTDTaskTableViewCell.h"

@implementation GTDTaskTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
}

- (IBAction)onDoneButton:(id)sender {
    [self.delegate didDoneButtonPressedForCell:self];
}

@end
