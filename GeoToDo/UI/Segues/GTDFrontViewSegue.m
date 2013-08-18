//
//  GTDFrontViewSegue.m
//  GeoToDo
//
//  Created by Alexander Zagorsky on 8/18/13.
//  Copyright (c) 2013 az. All rights reserved.
//

#import "GTDFrontViewSegue.h"
#import "GTDMainViewController.h"

@implementation GTDFrontViewSegue

- (void)perform {
    PKRevealController *revealController = ((UIViewController*)self.sourceViewController).revealController;
    UIViewController *destVc = self.destinationViewController;
    
    [revealController setFrontViewController:destVc];
    [revealController showViewController:destVc];
}

@end
