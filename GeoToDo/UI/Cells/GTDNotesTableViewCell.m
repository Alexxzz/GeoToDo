//
//  GTDNotesTableViewCell.m
//  GeoToDo
//
//  Created by admin on 7/18/13.
//  Copyright (c) 2013 az. All rights reserved.
//

#import "GTDNotesTableViewCell.h"
#import "GTDTextView.h"

#define kLabelFont [UIFont systemFontOfSize:14]

static const CGFloat kCellOffsetsAndTitleHeight = 55.f;
static const CGFloat kBaseHeight = 38.f;

@interface GTDNotesTableViewCell() <UITextViewDelegate>

@end

@implementation GTDNotesTableViewCell
{
    CGFloat _height;
}

+ (CGFloat)initialHeight {
    return kBaseHeight + kCellOffsetsAndTitleHeight;
}

- (void)_init {
    self.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.titleLabel.font = kLabelFont;
    
    self.textView.placeholder = NSLocalizedString(@"Placeholder", @"Placeholder text for the notes text view in the new task screen");
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self _init];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self _init];
}

#pragma mark - UITextViewDelegate

- (void)textViewDidChange:(UITextView *)textView {
    if (CGRectGetHeight(self.textView.frame) != self.textView.contentSize.height) {
        CGRect frame = self.textView.frame;
        frame.size.height = self.textView.contentSize.height;
        self.textView.frame = frame;
        
        CGFloat newHeight = CGRectGetHeight(frame) + kCellOffsetsAndTitleHeight;
        [self.delegate notesCell:self didChangeHeight:newHeight];
    }
}

@end
