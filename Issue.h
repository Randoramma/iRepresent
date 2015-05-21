//
//  Issue.h
//  iRepresent
//
//  Created by Randy McLain on 5/18/15.
//  Copyright (c) 2015 Randy McLain. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Issue : NSObject

@property (strong, nonatomic)NSString *identity;
@property (assign, nonatomic)NSString *author_id;
@property (strong, nonatomic)NSString *title;
@property (strong, nonatomic)NSString *content;
@property (assign, nonatomic)NSInteger upVotes;
@property (assign, nonatomic)NSInteger downVotes;
@property (strong, nonatomic)NSString *theDate;

@end
