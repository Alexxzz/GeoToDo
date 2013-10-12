//
//  GTDPlaceViewController.h
//  GeoToDo
//
//  Created by Alexander Zagorsky on 8/27/13.
//  Copyright (c) 2013 az. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface GTDPlaceViewController : UITableViewController
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (weak, nonatomic) IBOutlet UITextField *titleTextField;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UILabel *tasksLabel;
@property (weak, nonatomic) IBOutlet UILabel *tasksCountLabel;

@end
