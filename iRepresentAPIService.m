//
//  iRepresentAPIService.m
//  iRepresent
//
//  Created by Randy McLain on 5/18/15.
//  Copyright (c) 2015 Randy McLain. All rights reserved.
//

#import "iRepresentAPIService.h"
#import "AFNetworking.h"
#import "JSONParser.h"

@implementation iRepresentAPIService

+(void)postNewUser:(NSString *)theName withPassword:(NSString *)thePassword withEmail:(NSString *)theEmail response:(void (^)(NSString *))completionHandler {
  
  NSString *baseURL = @"pasteURLhere";
  NSString *theHTTPString = [NSString stringWithFormat:@"%@/users?", baseURL];
  NSURL *theURL = [NSURL URLWithString:theHTTPString];
  NSURLRequest *theURLRequest = [NSURLRequest requestWithURL:theURL];
  AFHTTPRequestOperationManager *manager= [AFHTTPRequestOperationManager manager];
  NSDictionary *params = @{@"username:": theName,
                           @"password:": thePassword,
                           @"theEmail:": theEmail};
  
  /*
   {
   success: <Boolean>, // Indicates a successful (true) or failed (false) result
   message: <String> // Supplemental response information
   }
   
   */
  [manager POST:theHTTPString parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
    NSLog(@"JSON: %@", responseObject);

    
    // call JSON parser
  } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    NSLog(@"Error: %@", error);
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error Posting User"
                                                        message:[error localizedDescription]
                                                       delegate:nil
                                              cancelButtonTitle:@"Ok"
                                              otherButtonTitles:nil];
    [alertView show];
  }];
  
}
@end
