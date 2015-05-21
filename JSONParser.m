//
//  JSONParser.m
//  iRepresent
//
//  Created by Randy McLain on 5/18/15.
//  Copyright (c) 2015 Randy McLain. All rights reserved.
//

#import "JSONParser.h"

@implementation JSONParser

+(NSMutableArray *)getUserIssues:(NSDictionary *)jsonDATA {
//  NSString *filePath = [[NSBundle mainBundle]pathForResource:@"get-user-issues-success" ofType:@"json"];
//  
//  if (!filePath) {
//    
//    NSLog(@"Contents of file cannot be read!");
//  }
//  NSData *theTempData = [[NSData alloc] initWithContentsOfFile:filePath];
  NSMutableArray *theIssues = [[NSMutableArray alloc] init];

    NSArray *dataArray = jsonDATA[@"data"];
    for (NSDictionary *issueElements in dataArray) {
      Issue *theIssue = [[Issue alloc] init];
      theIssue.identity = issueElements[@"_id"];
      theIssue.author_id = issueElements[@"author_id"];
      theIssue.title = issueElements[@"title"];
      theIssue.content = issueElements[@"content"];
      theIssue.upVotes = [issueElements[@"votes_up"] integerValue];
      theIssue.downVotes = [issueElements[@"votes_down"] integerValue];
      theIssue.theDate = issueElements[@"date_created"];
      [theIssues addObject:theIssue];
    } // for in dataArray
    
  return theIssues;
}

+(void)postUserIssue:(Issue *)theIssue {
  
  
  
  
  
}

+(NSString *)postUserResponse: (NSDictionary *)theResponse {
  
  NSString *theKey;
  NSDictionary *data = theResponse[@"data"];
  
  theKey = data[@"token"];
  
  return theKey;
}




@end
