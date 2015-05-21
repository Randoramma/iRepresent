//
//  Issue.h
//  iRepresent
//
//  Created by Randy McLain on 5/18/15.
//  Copyright (c) 2015 Randy McLain. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Issue : NSObject
/*
 "author_id": 32,
 "title": "Mayor McCheese for Govenor",
 "content": "I am sick of all the Pro-Ronald McDonald supporters in this city. It's time for a change!",
 "votes": {
 "up": 21,
 "down": 203
 */

@property (assign, nonatomic)NSInteger author_id;
@property (strong, nonatomic)NSString *title;
@property (strong, nonatomic)NSString *content;
@property (assign, nonatomic)NSInteger upVotes;
@property (assign, nonatomic)NSInteger downVotes;
@property (strong, nonatomic)NSString *theDate;

@end
