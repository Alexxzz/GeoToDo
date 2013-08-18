//
//  GTDMainViewController.m
//  GeoToDo
//
//  Created by Alexander Zagorsky on 8/18/13.
//  Copyright (c) 2013 az. All rights reserved.
//

#import "GTDMainViewController.h"

@interface GTDMainViewController ()

@end

@implementation GTDMainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Storyboard" bundle:nil];
    UIViewController *leftVC = [storyboard instantiateViewControllerWithIdentifier:@"LeftViewController"];
    UIViewController *tasksVC = [storyboard instantiateViewControllerWithIdentifier:@"TasksViewController"];
    
    [self setFrontViewController:tasksVC];
    [self setLeftViewController:leftVC];
}

@end
