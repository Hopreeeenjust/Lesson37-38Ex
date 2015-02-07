//
//  RJStudentDetailsController.m
//  Lesson37-38Ex
//
//  Created by Hopreeeeenjust on 06.02.15.
//  Copyright (c) 2015 Hopreeeeenjust. All rights reserved.
//

#import "RJStudentDetailsController.h"

@implementation RJStudentDetailsController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.name.text = self.nameInfo;
    self.surname.text = self.surnameInfo;
    self.gender.text = self.genderInfo;
    self.dateOfBirth.text = self.dateOfBirthInfo;
}

#pragma mark - Actions

- (IBAction)actionDoneButtonPressed:(UIBarButtonItem *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
