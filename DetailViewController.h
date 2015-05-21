//
//  DetailViewController.h
//  iRepresent
//s
//  Created by Randy McLain on 5/18/15.
//  Copyright (c) 2015 Randy McLain. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import "Issue.h"

@interface DetailViewController : UIViewController <MFMailComposeViewControllerDelegate>
@property (strong, nonatomic) Issue *selectedIssue; 

@end
