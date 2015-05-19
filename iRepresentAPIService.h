//
//  iRepresentAPIService.h
//  iRepresent
//
//  Created by Randy McLain on 5/18/15.
//  Copyright (c) 2015 Randy McLain. All rights reserved.
//

#import <Foundation/Foundation.h>
@class AFNetworking;

@interface iRepresentAPIService : NSObject
+(void) postNewUser: (NSString *)theName withPassword: (NSString *)thePassword withEmail: (NSString *)theEmail response: (void (^)(NSString *))completionHandler;

@end
