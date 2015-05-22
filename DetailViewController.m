//
//  DetailViewController.m
//  iRepresent
//
//  Created by Randy McLain on 5/18/15.
//  Copyright (c) 2015 Randy McLain. All rights reserved.
//

#import "DetailViewController.h"
#import "Issue.h"
#import "iRepresentAPIService.h"

@interface DetailViewController ()
@property (weak, nonatomic) IBOutlet UITextField *titleTextField;
@property (weak, nonatomic) IBOutlet UIButton *agreeButton;
@property (weak, nonatomic) IBOutlet UIButton *disagreeButton;
@property (weak, nonatomic) IBOutlet UITextView *contentTextView;
@property (weak, nonatomic) IBOutlet UILabel *upLabel;
@property (weak, nonatomic) IBOutlet UILabel *downLabel;

@end

@implementation DetailViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  
  // check to see what kind of issue was sent over.
  if (self.selectedIssue) {
    // set title
    self.title = self.selectedIssue.title;
    self.titleTextField.text = self.selectedIssue.title;
    self.contentTextView.text = self.selectedIssue.content;
    self.upLabel.text = [NSString stringWithFormat:@"%ld", (long)self.selectedIssue.upVotes];
    self.downLabel.text = [NSString stringWithFormat:@"%ld", (long)self.selectedIssue.downVotes];
    
  } else {
    self.title = @"new";
    //    self.titleTextField.text = @"new";
    self.disagreeButton.hidden = true;
  }
}


- (IBAction)agreePressed:(id)sender {
  NSLog(@"%@", self.selectedIssue.identity);
  // for new issue
  if (self.selectedIssue.identity == nil) {
    // with no title
    if ([self.titleTextField.text isEqualToString:@""]) {
      UIAlertView *noTitleWarning = [[UIAlertView alloc] initWithTitle:@"Warning!" message:@"You must enter a title for your issue." delegate:self cancelButtonTitle:@"Ok." otherButtonTitles: nil];
      [noTitleWarning show];
      return;
      
    } else {
      // for new issue with title
      [iRepresentAPIService createNewIssue:self.titleTextField.text andContent:self.contentTextView.text];
      [self sendEmail];
    }
  } else {
    // for non new issue.
    [iRepresentAPIService voteWithString:self.selectedIssue.identity withVote:@"yes"];
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Thank you for voting!" message:@"You have successfully voted. Now would you like to further act by sending this to your representatives?" delegate:self cancelButtonTitle:@"No!" otherButtonTitles:@"Yes!", nil];
    [alertView show];
    [self sendEmail];
  }
} // agreePressed

- (IBAction)disagreePressed:(id)sender {
  [iRepresentAPIService voteWithString:self.selectedIssue.identity withVote:@"yes"];
  UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Thank you for voting!" message:@"You have successfully voted." delegate:self cancelButtonTitle:@"Back." otherButtonTitles: nil];
  [alertView show];
}


- (void) sendEmail {
  // Email Subject
  NSString *emailTitle = [NSString stringWithFormat:@"Your local constituent cares about: %@", self.titleTextField.text];
  // Email Content
  NSString *messageBody = self.contentTextView.text;
  // To address
  NSArray *toRecipents = [NSArray arrayWithObject:@"randoramma@gmail.com"];
  
  MFMailComposeViewController *mc = [[MFMailComposeViewController alloc] init];
  mc.mailComposeDelegate = self;
  [mc setSubject:emailTitle];
  [mc setMessageBody:messageBody isHTML:NO];
  [mc setToRecipients:toRecipents];
  
  // Present mail view controller on screen
  [self presentViewController:mc animated:YES completion:NULL];
}

- (void) mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
  switch (result)
  {
    case MFMailComposeResultCancelled:
      NSLog(@"Mail cancelled");
      break;
    case MFMailComposeResultSaved:
      NSLog(@"Mail saved");
      break;
    case MFMailComposeResultSent:
      NSLog(@"Mail sent");
      break;
    case MFMailComposeResultFailed:
      NSLog(@"Mail sent failure: %@", [error localizedDescription]);
      break;
    default:
      break;
  }
  
  
  // Close the Mail Interface
  [self dismissViewControllerAnimated:YES completion:NULL];
}
- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
  if (textField == self.titleTextField) {
    [self.titleTextField resignFirstResponder];
  }
  return true;
}

-(BOOL)textViewShouldReturn:(UITextView *)textView {
  if (textView == self.contentTextView) {
    [self.contentTextView resignFirstResponder];
  }
  return true;
}




/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
