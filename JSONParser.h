//
//  JSONParser.h
//  iRepresent
//
//  Created by Randy McLain on 5/18/15.
//  Copyright (c) 2015 Randy McLain. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Issue.h"

@interface JSONParser : NSObject

+(NSMutableArray *) getUserIssues:(NSData *)jsonDATA;
+(void) postUserIssue: (Issue *)theIssue;
+(NSString*)postUserResponse: (NSData *)theJSON;

@end
