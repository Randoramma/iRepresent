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

+(void) userLogin: (NSString *)theEmail withPassword:(NSString *)thePassword response:(void (^) (BOOL success)) completionHandler {
  
  NSString *baseURL = [NSString stringWithFormat:@"http://irepresent.herokuapp.com"];
  NSString *theHTTPString = [NSString stringWithFormat:@"%@/sign_in", baseURL];
  AFHTTPRequestOperationManager *manager= [AFHTTPRequestOperationManager manager];
  
  [manager.requestSerializer setAuthorizationHeaderFieldWithUsername:theEmail password:thePassword];
  [manager GET:theHTTPString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
//    NSLog(@"JSON: %@", responseObject);
    NSString *token = [JSONParser postUserResponse:responseObject];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:token forKey:@"token"];
    // the code from the login screen gets executed here.VVV
    completionHandler(true);
    
  } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    // the code from the login screen gets executed here.VVV
    completionHandler(false);
    
    NSLog(@"Error: %@", error);
  }];
  
} // userLogin

+(void) feedRequestwithSortFormat: (NSString *)sortFormat completionHandler:(void (^) (NSArray* items, NSString *error))completionHandler {
  
  NSString *baseURL = [NSString stringWithFormat:@"http://irepresent.herokuapp.com"];
  NSString *theHTTPString = [NSString stringWithFormat:@"%@/sign_in?%@", baseURL, sortFormat];
  AFHTTPRequestOperationManager *manager= [AFHTTPRequestOperationManager manager];
  NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
  NSString *myKey = [userDefaults stringForKey:@"token"];
  [manager.requestSerializer setValue:myKey forHTTPHeaderField:@"Authorization"];
  [manager GET:theHTTPString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
    // parse JSON here
    
#warning We never get to this point in the codeVVVV.  2015-05-20 20:30
    NSMutableArray *theItems = [JSONParser getUserIssues:responseObject];
    // completion handler /... success.  Array
    completionHandler (theItems, nil);
    
  } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    
    completionHandler (nil, @"There was an error requesting the feed.");
  }];
}

+(NSArray *) jerryRig {
  NSString *filePath = [[NSBundle mainBundle]pathForResource:@"get-user-issues-success" ofType:@"json"];
  
  if (!filePath) {
    NSLog(@"File couldn't be read!");
  }
  
  // convert path to NSData (did not need)
  
  NSData *theData = [[NSData alloc] initWithContentsOfFile:filePath];

  NSMutableArray *theItems = [JSONParser getUserIssues:theData];
  return theItems; 
}


@end
