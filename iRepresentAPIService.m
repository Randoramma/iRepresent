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
  NSString *baseURL = @"https://irepresent.herokuapp.com";
  NSString *theHTTPString = [NSString stringWithFormat:@"%@/users", baseURL];
  AFHTTPRequestOperationManager *manager= [AFHTTPRequestOperationManager manager];
  manager.requestSerializer = [AFJSONRequestSerializer serializer];
  NSDictionary *params = @{@"username": theName,
                           @"password": thePassword,
                           @"email": theEmail};
  
  [manager POST:theHTTPString parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
    NSLog(@"JSON: %@", responseObject);
    NSString *token = [JSONParser postUserResponse:responseObject];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:token forKey:@"token"];
#warning bring back the alert view stuff back to the new user VC in the success block when you figure out how.
    UIAlertView *successUserPosted = [[UIAlertView alloc] initWithTitle:@"Success!" message:@"You now directed to the feed page." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
    
    [successUserPosted show];
    
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

  // <un>:<pw>@<host>:<port>/sign_in
  NSString *baseURL = [NSString stringWithFormat:@"https://%@:%@@irepresent.herokuapp.com:80", theEmail, thePassword];
  NSString *theHTTPString = [NSString stringWithFormat:@"%@/sign_in", baseURL];
  AFHTTPRequestOperationManager *manager= [AFHTTPRequestOperationManager manager];
  manager.requestSerializer = [AFJSONRequestSerializer serializer];
  NSDictionary *params = @{@"password:": thePassword,
                           @"email:": theEmail};
  
  [manager GET:theHTTPString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
    NSLog(@"JSON: %@", responseObject);
    NSString *token = [JSONParser postUserResponse:responseObject];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:token forKey:@"token"];
    
    UIAlertView *successUserPosted = [[UIAlertView alloc] initWithTitle:@"Success!" message:@"You now directed to the feed page." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
    
    [successUserPosted show];
    
    
  } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    
    
    NSLog(@"Error: %@", error);
  }];
 
}


@end
