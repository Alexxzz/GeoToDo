//
//  GTDLeftViewSegue.m
//  GeoToDo
//
//  Created by Alexander Zagorsky on 8/18/13.
//  Copyright (c) 2013 az. All rights reserved.
//

#import "GTDLeftViewSegue.h"

@implementation GTDLeftViewSegue

- (void)perform {
    PKRevealController *sourceVC = [((UIViewController*)self.sourceViewController) navigationController].revealController;
    [sourceVC showViewController:sourceVC.leftViewController];
}

@end
