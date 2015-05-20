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

+(void) userLogin: (NSString *)theEmail withPassword:(NSString *)thePassword response:(void (^) (NSString *))completionHandler;

+(void) feedRequestwithSortFormat: (NSString *)sortFormat completionHandler:(void (^) (NSArray* items, NSString *error))completionHandler;
@end
