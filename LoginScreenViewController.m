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
@property (strong, nonatomic) NSString *myKey;

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

 [iRepresentAPIService userLogin:self.emailTextField.text withPassword:self.passwordTextField.text response:^(BOOL success) {
   // everything in here gets bundled and handed over to the method: iRepresentAPIService userLogin:self.emailTextField.text withPassword:self.passwordTextField.text response and gets exceuted there.
   if (success) {
     NSLog(@"it worked");
     UIAlertView *successUserPosted = [[UIAlertView alloc] initWithTitle:@"Success!" message:@"You now directed to the feed page." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
     
     [successUserPosted show];

     [self performSegueWithIdentifier:@"verifiedToFeedSegue" sender:self];
     // load data from current view controller to settingVC
     
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

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
  
  
}

@end
