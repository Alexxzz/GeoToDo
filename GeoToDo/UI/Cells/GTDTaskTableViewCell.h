//
//  GTDTaskTableViewCell.h
//  GeoToDo
//
//  Created by admin on 8/6/13.
//  Copyright (c) 2013 az. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GTDTaskTableViewCell;

@protocol GTDTaskTableViewCellDelegate <NSObject>

- (void)didDoneButtonPressedForCell:(GTDTaskTableViewCell *)cell;

@end

@interface GTDTaskTableViewCell : UITableViewCell

@property (nonatomic, weak) id<GTDTaskTableViewCellDelegate> delegate;

@property (weak, nonatomic) IBOutlet UIButton *doneButton;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *dueDateLabel;

- (IBAction)onDoneButton:(id)sender;

@end
