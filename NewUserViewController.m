//
//  NewUserViewController.m
//  iRepresent
//
//  Created by Randy McLain on 5/18/15.
//  Copyright (c) 2015 Randy McLain. All rights reserved.
//

#import "NewUserViewController.h"
#import "iRepresentAPIService.h"
#import "JSONParser.h"

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
 
}

- (IBAction)createButtonPressed:(id)sender {
  [iRepresentAPIService postNewUser:self.userUsernameTextField.text withPassword:self.userPasswordTextField.text withEmail:self.userEmailTextField.text response:^(NSString *status) {

    if ([status  isEqual: @"success"]) {
      
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


#pragma -mark Text Field
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

-(void)textFieldDidBeginEditing:(UITextField *)textField {
  if (textField == self.userEmailTextField) {
    self.userEmailTextField.keyboardType = UIKeyboardTypeEmailAddress;
  }
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
  if (buttonIndex == 1) {
    
    [self performSegueWithIdentifier:@"createdToFeedSegue" sender:self];
    // load data from current view controller to settingVC
  }
}


@end
