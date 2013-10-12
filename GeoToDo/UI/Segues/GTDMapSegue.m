//
//  GTDMapSegue.m
//  GeoToDo
//
//  Created by Alexander Zagorsky on 9/2/13.
//  Copyright (c) 2013 az. All rights reserved.
//

#import "GTDMapSegue.h"
#import "GTDPlaceViewController.h"

@implementation GTDMapSegue

- (void)perform {
    GTDPlaceViewController *placeVc = self.sourceViewController;
    UIViewController *mapVc = self.destinationViewController;
    
    mapVc.view.frame = CGRectMake(0.f, 100.f, 320.f, 100.f);
    
    //[placeVc.navigationController pushViewController:mapVc animated:NO];
    [UIView transitionFromView:placeVc.view
                        toView:mapVc.view
                      duration:0.5f
                       options:UIViewAnimationOptionTransitionNone
                    completion:^(BOOL finished) {
                        mapVc.view.frame = CGRectMake(0.f, 0, 320.f, 480.f);
                    }];
}

@end
