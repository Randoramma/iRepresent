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
 
}


- (IBAction)createButtonPressed:(id)sender {
  [iRepresentAPIService postNewUser:self.userUsernameTextField.text withPassword:self.userPasswordTextField.text withEmail:self.userEmailTextField.text response:^(NSString *status) {
    // NSLog(@"%@", )
    if ([status  isEqual: @"200"]) {
      UIAlertView *successUserPosted = [[UIAlertView alloc] initWithTitle:@"Success!" message:@"You now directed to the feed page." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
      
#warning "this is where we set the key.  This needs to be paired with a token.  
       NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
      [userDefaults setObject:@"Your text here" forKey:@"StringKey"];
      [userDefaults synchronize];
      
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

-(void)textFieldDidBeginEditing:(UITextField *)textField {
  if (textField == self.userEmailTextField) {
    self.userEmailTextField.keyboardType = UIKeyboardTypeEmailAddress;
  }
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
  if (buttonIndex == 1) {
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *feedVC = [storyboard instantiateViewControllerWithIdentifier:@"FeedVC"];
    // present view controller.
    [self presentViewController:feedVC animated:true completion:nil];
  }
}


@end
