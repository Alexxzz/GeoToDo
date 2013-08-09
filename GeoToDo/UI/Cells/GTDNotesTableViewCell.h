//
//  GTDNotesTableViewCell.h
//  GeoToDo
//
//  Created by admin on 7/18/13.
//  Copyright (c) 2013 az. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GTDNotesTableViewCell;
@class GTDTextView;

@protocol GTDNotesTableViewCellDelegate <NSObject>

- (void)notesCell:(GTDNotesTableViewCell *)cell didChangeHeight:(CGFloat)height;

@end

@interface GTDNotesTableViewCell : UITableViewCell

@property(weak,nonatomic) id<GTDNotesTableViewCellDelegate> delegate;
@property(weak,nonatomic) IBOutlet UILabel *titleLabel;
@property(weak,nonatomic) IBOutlet GTDTextView *textView;

+ (CGFloat)initialHeight;

@end
