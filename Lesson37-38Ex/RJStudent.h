//
//  RJStudent.h
//  Lesson37-38Ex
//
//  Created by Hopreeeeenjust on 06.02.15.
//  Copyright (c) 2015 Hopreeeeenjust. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MKUserLocation.h>

typedef NS_ENUM(NSInteger, RJStudentGender) {
    RJStudentGenderMale = 0,
    RJStudentGenderFemale
};

@interface RJStudent : NSObject
@property (strong, nonatomic) NSString *firstName;
@property (strong, nonatomic) NSString *lastName;
@property (strong, nonatomic) NSDate *birthDate;
@property (assign, nonatomic) RJStudentGender gender;
@property (assign, nonatomic) CLLocationCoordinate2D currentCoordinate;
@end
 