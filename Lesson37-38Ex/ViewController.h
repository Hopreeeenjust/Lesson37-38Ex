//
//  ViewController.h
//  Lesson37-38Ex
//
//  Created by Hopreeeeenjust on 06.02.15.
//  Copyright (c) 2015 Hopreeeeenjust. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MKMapView;

@interface ViewController : UIViewController
@property (weak, nonatomic) IBOutlet MKMapView *mapView;

- (IBAction)actionShowStudents:(UIBarButtonItem *)sender;
@end

