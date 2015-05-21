//
//  DetailViewController.h
//  iRepresent
//
//  Created by Randy McLain on 5/18/15.
//  Copyright (c) 2015 Randy McLain. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>

@interface DetailViewController : UIViewController <MFMailComposeViewControllerDelegate>


- (IBAction)showEmail:(id)sender;
@end
