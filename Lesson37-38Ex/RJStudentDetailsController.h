//
//  RJStudentDetailsController.h
//  Lesson37-38Ex
//
//  Created by Hopreeeeenjust on 06.02.15.
//  Copyright (c) 2015 Hopreeeeenjust. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RJStudentDetailsController : UITableViewController
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *surname;
@property (weak, nonatomic) IBOutlet UILabel *gender;
@property (weak, nonatomic) IBOutlet UILabel *dateOfBirth;
@property (weak, nonatomic) IBOutlet UILabel *country;
@property (weak, nonatomic) IBOutlet UILabel *city;
@property (weak, nonatomic) IBOutlet UILabel *address;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *doneButton;

@property (strong, nonatomic) NSString *nameInfo;
@property (strong, nonatomic) NSString *surnameInfo;
@property (strong, nonatomic) NSString *genderInfo;
@property (strong, nonatomic) NSString *dateOfBirthInfo;

-(IBAction)actionDoneButtonPressed:(UIBarButtonItem *)sender;
@end
