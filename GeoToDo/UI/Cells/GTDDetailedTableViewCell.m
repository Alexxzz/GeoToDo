//
//  GTDDetailedTableViewCell.m
//  GeoToDo
//
//  Created by admin on 7/27/13.
//  Copyright (c) 2013 az. All rights reserved.
//

#import "GTDDetailedTableViewCell.h"

@implementation GTDDetailedTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:reuseIdentifier];
    if (self) {
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    return self;
}

@end
