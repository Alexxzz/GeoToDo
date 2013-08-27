//
//  GTDDetailSubtitleCell.h
//  GeoToDo
//
//  Created by Alexander Zagorsky on 8/26/13.
//  Copyright (c) 2013 az. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GTDDetailSubtitleCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *subtitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailLabel;

@end
