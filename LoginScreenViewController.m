//
//  LoginScreenViewController.m
//  iRepresent
//
//  Created by Randy McLain on 5/18/15.
//  Copyright (c) 2015 Randy McLain. All rights reserved.
//

#import "LoginScreenViewController.h"
#import "iRepresentAPIService.h"


@interface LoginScreenViewController () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;

@end


@implementation LoginScreenViewController

-(void)viewDidAppear:(BOOL)animated {
  self.emailTextField.delegate = self;
  self.passwordTextField.delegate = self;
  
  
} // viewDidAppear
-(void)viewWillAppear:(BOOL)animated {
  [self.navigationController setNavigationBarHidden:YES animated:YES];
} // viewWillAppear

-(void)viewWillDisappear:(BOOL)animated {
  [self.navigationController setNavigationBarHidden:NO animated:YES];
} // viewWillDisappear

- (IBAction)loginPressed:(id)sender {
  
 [iRepresentAPIService userLogin:self.emailTextField.text withPassword:self.passwordTextField.text response:^(NSString *status) {
   
   if ([status  isEqual: @"200"]) {
     UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
     UIViewController *feedVC = [storyboard instantiateViewControllerWithIdentifier:@"FeedVC"];
     // present view controller.
     [self presentViewController:feedVC animated:true completion:nil];
     
     NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
     [userDefaults setObject:@"Your text here" forKey:@"StringKey"];
     [userDefaults synchronize];

   } else {
     
     UIAlertView *failedUserPosted = [[UIAlertView alloc] initWithTitle:@"Error posting user." message:@"User unsuccessfully posted to server, try creating a user." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
     [failedUserPosted show];
   }
 }]; // response

} // loginPressed

-(void)textFieldDidBeginEditing:(UITextField *)textField {
  if (textField == self.emailTextField) {
    self.emailTextField.keyboardType = UIKeyboardTypeEmailAddress;
  }
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
  if (textField == self.emailTextField) {
    [self.emailTextField resignFirstResponder];
  } else {
    [self.passwordTextField resignFirstResponder];
  }
  return true;
}

@end
