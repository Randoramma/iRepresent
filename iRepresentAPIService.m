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

//[[AFNetworkActivityIndicatorManager sharedManager] setEnabled:YES];

+(void)postNewUser:(NSString *)theName withPassword:(NSString *)thePassword withEmail:(NSString *)theEmail response:(void (^)(NSString *))completionHandler {
  #warning Enter in the heroku url to make the call to for the issues array.
  NSString *baseURL = @"https://irepresent.herokuapp.com";
  NSString *theHTTPString = [NSString stringWithFormat:@"%@/users", baseURL];
  NSURL *theURL = [NSURL URLWithString:theHTTPString];
  NSURLRequest *theURLRequest = [NSURLRequest requestWithURL:theURL];
  AFHTTPRequestOperationManager *manager= [AFHTTPRequestOperationManager manager];
  manager.requestSerializer = [AFJSONRequestSerializer serializer];
  NSDictionary *params = @{@"username": theName,
                           @"password": thePassword,
                           @"email": theEmail};

  [manager POST:theHTTPString parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
//    NSLog(@"The httpString being sent is: %@", theHTTPString);
//    NSLog(@"The Body being sent is: %@", params);
    NSLog(@"JSON: %@", responseObject);
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:@"Your text here" forKey:@"token"];
    
    // call JSON parser
  } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    NSLog(@"Error: %@", error);
    NSLog(@"The httpString being sent is: %@", theHTTPString);
    NSLog(@"The Body being sent is: %@", params);

    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error Posting User"
                                                        message:[error localizedDescription]
                                                       delegate:nil
                                              cancelButtonTitle:@"Ok"
                                              otherButtonTitles:nil];
    [alertView show];
  }];
  
} // postNewUser

+(void) userLogin: (NSString *)theEmail withPassword:(NSString *)thePassword response:(void (^) (NSString *))completionHandler {
  #warning Enter in the heroku url to make the call to for the get user login.
  NSString *baseURL = @"pasteURLhere";
  #warning Is the endpoint the same for the user login?
  NSString *theHTTPString = [NSString stringWithFormat:@"%@/sign_in?", baseURL];
  NSURL *theURL = [NSURL URLWithString:theHTTPString];
  AFHTTPRequestOperationManager *manager= [AFHTTPRequestOperationManager manager];
  NSDictionary *params = @{@"password:": thePassword,
                           @"email:": theEmail};
  
  [manager GET:theHTTPString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
    NSLog(@"JSON: %@", responseObject);
    
  } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    
    
    NSLog(@"Error: %@", error);
  }];
  
  
  
  
  
  
  
  
}


@end
