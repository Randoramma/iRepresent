//
//  JSONParser.m
//  iRepresent
//
//  Created by Randy McLain on 5/18/15.
//  Copyright (c) 2015 Randy McLain. All rights reserved.
//

#import "JSONParser.h"

/*
 {
 "success": true,
 "message": "Returned user issues, sorted by most popular.",
 "data": [
 {
 "issue_id": 1,
 "author_id": 32,
 "title": "Mayor McCheese for Govenor",
 "content": "I am sick of all the Pro-Ronald McDonald supporters in this city. It's time for a change!",
 "votes": {
 "up": 21,
 "down": 203
 }
 },
 {
 "issue_id": 32,
 "author_id": 12,
 "title": "Guns for Kids",
 "content": "For too long we've had a Guns for Kicks program, but kids don't wanna be kicked. They want guns!",
 "votes": {
 "up": 4032,
 "down": 1
 }
 },
 {
 "issue_id": 104,
 "author_id": 94,
 "title": "Clearing the WWII Minefield in front of the QFC.",
 "content": "This relic from ages past has been a dangeou....<BOOM!>",
 "votes": {
 "up": 321,
 "down": 13
 }
 }
 ]
 }
 
 */


@implementation JSONParser
//:(NSData *)jsonDATA
+(Issue *)getUserIssues {
  NSString *filePath = [[NSBundle mainBundle]pathForResource:@"get-user-issues-fail" ofType:@"json"];
  
  if (!filePath) {
    
    NSLog(@"Contents of file cannot be read!");
  }
  NSData *theData = [[NSData alloc] initWithContentsOfFile:filePath];
  Issue *theIssue = [[Issue alloc] init];
  NSError *theError;
  
  NSDictionary *userIssueDictionary = [NSJSONSerialization JSONObjectWithData:theData options:0 error:&theError];
  
  if(!theError) {
    NSArray * dataArray = userIssueDictionary[@"data"];
    for (NSDictionary *issueElements in dataArray) {
      theIssue.author_id = [issueElements[@"author_id"] integerValue];
      theIssue.title = issueElements[@"title"];
      theIssue.content = issueElements[@"content"];
      NSDictionary *voteElement = issueElements[@"votes"];
        theIssue.upVotes = [voteElement[@"up"] integerValue];
        theIssue.downVotes = [voteElement[@"down"] integerValue];

    } // for in dataArray
  } // if(!theError)
  else {
    NSLog(@"%@", theError.localizedDescription); 
  }

  NSLog(@"the issue title is %@", theIssue.title);
  return theIssue;
}

+(void)postUserIssue:(Issue *)theIssue {
  
  
  
  
  
}


@end
