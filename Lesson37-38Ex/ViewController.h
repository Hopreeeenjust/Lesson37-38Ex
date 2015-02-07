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
@property (weak, nonatomic) IBOutlet UILabel *studentsIn5Km;
@property (weak, nonatomic) IBOutlet UILabel *studentsIn10Km;
@property (weak, nonatomic) IBOutlet UILabel *studentsIn15Km;
@property (weak, nonatomic) IBOutlet UILabel *studentsWIllTakePart;
@property (weak, nonatomic) IBOutlet UIView *distanceView;
@end

