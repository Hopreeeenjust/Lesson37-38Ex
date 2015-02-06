//
//  ViewController.m
//  Lesson37-38Ex
//
//  Created by Hopreeeeenjust on 06.02.15.
//  Copyright (c) 2015 Hopreeeeenjust. All rights reserved.
//

#import "ViewController.h"
#import <MapKit/MapKit.h>
#import "RJStudent.h"
#import "RJMapAnnotation.h"

@interface ViewController ()
@property (strong, nonatomic) NSMutableArray *annotations;
@end

@implementation ViewController

#pragma mark - View

- (void)viewDidLoad {
    [super viewDidLoad];
    CLLocationCoordinate2D center = {55.753744, 37.622637};
    MKCoordinateRegion regionToShow = MKCoordinateRegionMakeWithDistance(center, 40000, 40000);
    [self.mapView setRegion:regionToShow];
    
    double deltaLatitude = 0.15f;
    double deltaLongitude = 0.24f;

    NSArray *maleNamesArray = @[@"Roma", @"Bill", @"Sam", @"Denis", @"Alex", @"Sergey", @"Bob", @"Rob", @"John", @"Simon", @"Nick", @"Piter", @"James", @"Kiran", @"Martin", @"Igor", @"Maks", @"Robby", @"Harry", @"Vova", @"Dima"];
    NSArray *femaleNamesArray = @[@"Alexandra", @"Anna", @"Liz", @"Helen", @"Katty", @"Veronica", @"Jane", @"Cristina", @"Britney", @"Darya", @"Naomy", @"Maria", @"Angelika", @"Svetlana", @"Natalia", @"Marina", @"Margaret"];
    NSArray *surnamesArray = @[@"Gibbs", @"Smith", @"Beniakovski", @"Long", @"Potter", @"Bond", @"Russel", @"Ostin", @"Mendez", @"Green", @"Bullock", @"Jones", @"Freeman", @"Murphy", @"Hanks", @"Goldberg", @"Williams", @"Depp", @"Hoffman", @"Martin", @"Law", @"Oldman", @"Carter", @"Hopkins", @"Delon"];
    
    self.annotations = [NSMutableArray array];
    for (NSInteger i = 0; i < 30; i++) {
        RJStudent *student = [RJStudent new];
        student.gender = arc4random_uniform(2 * 1000) / 1000;
        if (student.gender == RJStudentGenderFemale) {
            student.firstName = [femaleNamesArray objectAtIndex:(int)(arc4random_uniform((int)[femaleNamesArray count] * 1000) / 1000)];
        } else {
            student.firstName = [maleNamesArray objectAtIndex:(int)(arc4random_uniform((int)[maleNamesArray count] * 1000) / 1000)];
        }
        student.lastName = [surnamesArray objectAtIndex:(int)(arc4random_uniform((int)[surnamesArray count] * 1000) / 1000)];
        NSInteger age = arc4random_uniform(18 * 31556926) + 17 * 31556926;
        student.birthDate = [NSDate dateWithTimeIntervalSinceNow:-age];
        CLLocationCoordinate2D currentCoordinate = {(center.latitude - deltaLatitude + (float)(arc4random_uniform(2 * deltaLatitude * 1000000)) / 1000000), (center.longitude - deltaLongitude + (float)(arc4random_uniform(2 * deltaLongitude * 1000000)) / 1000000)};
        student.currentCoordinate = currentCoordinate;
        RJMapAnnotation *annotation = [RJMapAnnotation new];
        annotation.coordinate = student.currentCoordinate;
        annotation.title = [NSString stringWithFormat:@"%@ %@", student.firstName, student.lastName];
        NSDateFormatter *formatter = [NSDateFormatter new];
        [formatter setDateFormat:@"dd/MM/yyyy"];
        annotation.subtitle = [formatter stringFromDate:student.birthDate];
        annotation.studentGender = student.gender ? @"female" : @"male";
        [self.annotations addObject:annotation];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Actions

- (IBAction)actionShowStudents:(UIBarButtonItem *)sender {
//    [self.mapView addAnnotations:self.annotations];
    [self.mapView showAnnotations:self.annotations animated:YES];
}

- (void)actionDescription:(UIButton *)sender {
    
}

#pragma mark - MKMapViewDelegate

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(RJMapAnnotation *)annotation {
    if ([annotation isKindOfClass:[MKUserLocation class]]) {
        return nil;
    }
    static NSString *identifier = @"Annotation";
    MKAnnotationView *annotationView = [mapView dequeueReusableAnnotationViewWithIdentifier:identifier];
    if (!annotationView) {
        annotationView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:identifier];
        annotationView.canShowCallout = YES;
        if ([annotation.studentGender isEqualToString:@"male"]) {
            annotationView.image = [UIImage imageNamed:@"male.png"];
        } else {
            annotationView.image = [UIImage imageNamed:@"female.png"];
        }

        UIButton *descriptionButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
        [descriptionButton addTarget:self action:@selector(actionDescription:) forControlEvents:UIControlEventTouchUpInside];
        annotationView.rightCalloutAccessoryView = descriptionButton;
        
//        UIButton *directionButton = [UIButton buttonWithType:UIButtonTypeContactAdd];
//        [directionButton addTarget:self action:@selector(actionDirection:) forControlEvents:UIControlEventTouchUpInside];
//        pin.leftCalloutAccessoryView = directionButton;
    } else {
        annotationView.annotation = annotation;
    }
    return annotationView;
}


@end
