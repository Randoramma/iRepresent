//
//  JSONParser.m
//  iRepresent
//
//  Created by Randy McLain on 5/18/15.
//  Copyright (c) 2015 Randy McLain. All rights reserved.
//

#import "JSONParser.h"

@implementation JSONParser

+(NSMutableArray *)getUserIssues:(NSData *)jsonDATA {
  NSString *filePath = [[NSBundle mainBundle]pathForResource:@"get-user-issues-success" ofType:@"json"];
  
  if (!filePath) {
    
    NSLog(@"Contents of file cannot be read!");
  }
  NSData *theTempData = [[NSData alloc] initWithContentsOfFile:filePath];
  NSMutableArray *theIssues = [[NSMutableArray alloc] init];
  NSError *theError;
  
  NSDictionary *userIssueDictionary = [NSJSONSerialization JSONObjectWithData:theTempData options:0 error:&theError];
  
  if(!theError) {
    NSArray *dataArray = userIssueDictionary[@"data"];
    for (NSDictionary *issueElements in dataArray) {
      Issue *theIssue = [[Issue alloc] init];
      theIssue.author_id = [issueElements[@"author_id"] integerValue];
      theIssue.title = issueElements[@"title"];
      theIssue.content = issueElements[@"content"];
      //      NSDictionary *voteElement = issueElements[@"votes"];
      theIssue.upVotes = [issueElements[@"votes_up"] integerValue];
      theIssue.downVotes = [issueElements[@"votes_down"] integerValue];
      theIssue.theDate = issueElements[@"date_created"];
      [theIssues addObject:theIssue];
    } // for in dataArray
    
  } // if(!theError)
  else {
    NSLog(@"%@", theError.localizedDescription);
  }
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
