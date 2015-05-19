//
//  NewUserViewController.m
//  iRepresent
//
//  Created by Randy McLain on 5/18/15.
//  Copyright (c) 2015 Randy McLain. All rights reserved.
//

#import "NewUserViewController.h"
#import "iRepresentAPIService.h"

@interface NewUserViewController () <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *userEmailTextField;
@property (weak, nonatomic) IBOutlet UITextField *userUsernameTextField;
@property (weak, nonatomic) IBOutlet UITextField *userPasswordTextField;
@property (strong, nonatomic) UITapGestureRecognizer *tapGestureRecoginzer;

@end


@implementation NewUserViewController

-(void)viewDidLoad {
  
  self.userEmailTextField.delegate = self;
  self.userPasswordTextField.delegate = self;
  self.userUsernameTextField.delegate = self; 
//  self.tapGestureRecoginzer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismissKeyboard:)];
//  [self.view addGestureRecognizer:self.tapGestureRecoginzer];
}


- (IBAction)createButtonPressed:(id)sender {
  [iRepresentAPIService postNewUser:self.userUsernameTextField.text withPassword:self.userPasswordTextField.text withEmail:self.userEmailTextField.text response:^(NSString *status) {
    
    if ([status  isEqual: @"200"]) {
      UIAlertView *successUserPosted = [[UIAlertView alloc] initWithTitle:@"Success!" message:@"You now need to login to post through the login page." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
      
      [successUserPosted show];
      
      
      
    } else {
      
      UIAlertView *failedUserPosted = [[UIAlertView alloc] initWithTitle:@"Error posting user." message:@"User unsuccessfully posted to server" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
      
      [failedUserPosted show];
    }
  }]; // response
} // createButtonPressed

-(void)dismissKeyboard {
  [self.userUsernameTextField resignFirstResponder];
  [self.userPasswordTextField resignFirstResponder];
  [self.userEmailTextField resignFirstResponder];
} // dismissKeyboard

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
  if (textField == self.userEmailTextField) {
    [self.userEmailTextField resignFirstResponder];
  } else if (textField == self.userUsernameTextField) {
    [self.userUsernameTextField resignFirstResponder];
  } else {
    [self.userPasswordTextField resignFirstResponder];
  }
  return true;
}


@end
