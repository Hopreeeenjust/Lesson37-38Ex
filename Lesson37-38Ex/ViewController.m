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
#import "RJStudentDetailsController.h"
#import "UIView+MKAnnotationView.h"
#import "RJMeetingAnnotation.h"

@interface ViewController ()
@property (strong, nonatomic) NSMutableArray *annotations;
@property (strong, nonatomic) CLGeocoder *geoCoder;
@property (assign, nonatomic) CLLocationCoordinate2D center;

@end

@implementation ViewController

#pragma mark - View

- (void)viewDidLoad {
    [super viewDidLoad];
    CLLocationCoordinate2D center = {55.753744, 37.622637};
    self.center = center;
    MKCoordinateRegion regionToShow = MKCoordinateRegionMakeWithDistance(center, 40000, 40000);
    [self.mapView setRegion:regionToShow];
    
    UIBarButtonItem *addStudentsButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(actionAddStudents:)];
    UIBarButtonItem *fixedSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    UIBarButtonItem *showAllStudentsButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:self action:@selector(actionShowStudents:)];
    UIBarButtonItem *meetingButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"Meeting3.png"] style:UIBarButtonItemStylePlain target:self action:@selector(actionAddMeetingPoint:)];
    
    NSArray *buttonsArray = @[addStudentsButton, fixedSpace, showAllStudentsButton, fixedSpace, meetingButton];
    self.navigationItem.rightBarButtonItems = buttonsArray;
    
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
        annotation.studentGender = student.gender ? @"Female" : @"Male";
        [self.annotations addObject:annotation];
    }
    self.geoCoder = [[CLGeocoder alloc] init];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    if ([self.geoCoder isGeocoding]) {
        [self.geoCoder cancelGeocode];
    }
//    if ([self.directions isCalculating]) {
//        [self.directions cancel];
//    }
}

#pragma mark - Actions

- (void)actionAddStudents:(UIBarButtonItem *)sender {
    [self.mapView addAnnotations:self.annotations];
}

- (void)actionDescription:(UIButton *)sender {
    MKAnnotationView *annotationView = [sender superAnnotationView];
    RJStudentDetailsController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"RJStudentDetailsController"];
    [self fillStudentInformationInController:vc fromAnnotation:annotationView];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        UIPopoverController *popover = [[UIPopoverController alloc] initWithContentViewController:nav];
        popover.popoverContentSize = CGSizeMake(330, 430);
        CGRect buttonRect = [self.view convertRect:sender.frame fromView:sender];
        [popover presentPopoverFromRect:buttonRect
                                 inView:self.mapView
               permittedArrowDirections:UIPopoverArrowDirectionAny
                               animated:YES];
    } else {
        [self presentViewController:nav animated:YES completion:nil];
    }
}

- (void)actionShowStudents:(UIBarButtonItem *)sender {
    [self.mapView showAnnotations:self.annotations animated:YES];
}

- (void)actionAddMeetingPoint:(UIBarButtonItem *)sender {
    RJMeetingAnnotation *annotation = [RJMeetingAnnotation new];
    annotation.coordinate = self.center;
    annotation.title = @"Meeting is here";
    
    [self.mapView addAnnotation:annotation];
}

#pragma mark - MKMapViewDelegate

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(RJMapAnnotation <MKAnnotation> *)annotation {
    if ([annotation isKindOfClass:[MKUserLocation class]]) {
        return nil;
    }
    static NSString *identifier = @"Annotation";
    static NSString *meetingIdentifier = @"Meeting";
    if ([annotation isKindOfClass:[RJMapAnnotation class]]) {
        MKAnnotationView *annotationView = [mapView dequeueReusableAnnotationViewWithIdentifier:identifier];
        if (!annotationView) {
            annotationView = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:identifier];
            annotationView.canShowCallout = YES;
            if ([annotation.studentGender isEqualToString:@"Male"]) {
                annotationView.image = [UIImage imageNamed:@"male.png"];
            } else {
                annotationView.image = [UIImage imageNamed:@"female.png"];
            }
            UIButton *descriptionButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
            [descriptionButton addTarget:self action:@selector(actionDescription:) forControlEvents:UIControlEventTouchUpInside];
            annotationView.rightCalloutAccessoryView = descriptionButton;
        } else {
            annotationView.annotation = annotation;
        }
        return annotationView;
    } else if ([annotation isKindOfClass:[RJMeetingAnnotation class]]) {
        MKAnnotationView *annotationView = [mapView dequeueReusableAnnotationViewWithIdentifier:meetingIdentifier];
        if (!annotationView) {
            annotationView = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:meetingIdentifier];
            annotationView.canShowCallout = YES;
            annotationView.draggable = YES;
            annotationView.image = [UIImage imageNamed:@"Meeting2.png"];
        } else {
            annotationView.annotation = annotation;
        }
        [self.mapView removeOverlays:[self.mapView overlays]];
        MKCircle *circle1 = [MKCircle circleWithCenterCoordinate:self.center radius:15000];
        MKCircle *circle2 = [MKCircle circleWithCenterCoordinate:self.center radius:10000];
        MKCircle *circle3 = [MKCircle circleWithCenterCoordinate:self.center radius:5000];
        [self.mapView addOverlays:@[circle1, circle2, circle3] level:MKOverlayLevelAboveRoads];
        return annotationView;
    }
    return nil;
}

- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view didChangeDragState:(MKAnnotationViewDragState)newState fromOldState:(MKAnnotationViewDragState)oldState {
    if (newState == MKAnnotationViewDragStateStarting) {
        [self.mapView removeOverlays:[self.mapView overlays]];
    } else if (newState == MKAnnotationViewDragStateEnding) {
        self.center = view.annotation.coordinate;
        [self.mapView removeOverlays:[self.mapView overlays]];
        MKCircle *circle1 = [MKCircle circleWithCenterCoordinate:self.center radius:15000];
        MKCircle *circle2 = [MKCircle circleWithCenterCoordinate:self.center radius:10000];
        MKCircle *circle3 = [MKCircle circleWithCenterCoordinate:self.center radius:5000];
        [self.mapView addOverlays:@[circle1, circle2, circle3] level:MKOverlayLevelAboveRoads];
        CLLocationCoordinate2D location = view.annotation.coordinate;
        MKMapPoint point = MKMapPointForCoordinate(location);
        NSLog(@"\nlocation = {%f, %f}\npoint = %@", location.latitude, location.longitude, MKStringFromMapPoint(point));
    }
}

- (MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(id<MKOverlay>)overlay {
    if ([overlay isKindOfClass:[MKPolyline class]]) {
        MKPolylineRenderer *renderer = [[MKPolylineRenderer alloc] initWithOverlay:overlay];
        renderer.lineWidth = 2.f;
        renderer.strokeColor = [UIColor redColor];
        return renderer;
    }
    if ([overlay isKindOfClass:[MKCircle class]]) {
        MKCircleRenderer *renderer = [[MKCircleRenderer alloc] initWithOverlay:overlay];
        renderer.lineWidth = 2.f;
        renderer.strokeColor = [UIColor redColor];
        renderer.fillColor = [[UIColor redColor] colorWithAlphaComponent:0.1];
        return renderer;
    }
    return nil;
}


//        UIButton *directionButton = [UIButton buttonWithType:UIButtonTypeContactAdd];
//        [directionButton addTarget:self action:@selector(actionDirection:) forControlEvents:UIControlEventTouchUpInside];
//        pin.leftCalloutAccessoryView = directionButton;

#pragma mark - UITableViewDelegate 

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - Help methods

- (void)fillStudentInformationInController:(RJStudentDetailsController *)controller fromAnnotation:(MKAnnotationView *)annotationView {
    RJMapAnnotation *annotation = annotationView.annotation;
    NSString *fullName = annotation.title;
    NSArray *nameComponents = [fullName componentsSeparatedByString:@" "];
    NSString *name = [nameComponents firstObject];
    NSString *surname = [nameComponents lastObject];
    controller.nameInfo = name;
    controller.surnameInfo = surname;
    controller.genderInfo = annotation.studentGender;
    controller.dateOfBirthInfo = annotation.subtitle;
    CLLocationCoordinate2D coordinate = annotation.coordinate;
    CLLocation *location = [[CLLocation alloc] initWithLatitude:coordinate.latitude longitude:coordinate.longitude];
    if ([self.geoCoder isGeocoding]) {
        [self.geoCoder cancelGeocode];
    }
    [self.geoCoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error) {
        CLPlacemark *placemark = [placemarks firstObject];
        controller.country.text = placemark.country;
        controller.city.text = placemark.locality;
        controller.address.text = placemark.thoroughfare;
    }];
}


@end
