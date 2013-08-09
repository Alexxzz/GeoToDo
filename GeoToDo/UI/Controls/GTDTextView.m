//
//  GTDTextField.m
//  GeoToDo
//
//  Created by admin on 7/26/13.
//  Copyright (c) 2013 az. All rights reserved.
//

#import "GTDTextView.h"

@implementation GTDTextView
{
    UIColor *_normalColor;
    BOOL _placeholderVisible;
}

- (void)_init {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(didTextBeginEdinig)
                                                 name:UITextViewTextDidBeginEditingNotification
                                               object:self];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(didTextEndEdinig)
                                                 name:UITextViewTextDidEndEditingNotification
                                               object:self];
    _placeholderColor = [UIColor grayColor];
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self _init];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self _init];
    }
    return self;
}

- (void)showPlaceholder {
    if ([self.text length] == 0) {
        _placeholderVisible = YES;
        
        self.text = _placeholder;
        if (self.textColor != _placeholderColor)
            _normalColor = self.textColor;
        self.textColor = _placeholderColor;
    }
}

- (void)layoutSubviews {
    [self showPlaceholder];
}

- (NSString *)text {
    if ([[super text] isEqualToString:_placeholder])
        return @"";
    
    return [super text];
}

- (void)didTextBeginEdinig {
    self.textColor = _normalColor;
    if ([[super text] isEqualToString:_placeholder])
        self.text = @"";
    
    _placeholderVisible = NO;
}

- (void)didTextEndEdinig {
    [self showPlaceholder];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
