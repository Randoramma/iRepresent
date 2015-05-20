//
//  FeedTableViewCell.h
//  iRepresent
//
//  Created by Randy McLain on 5/18/15.
//  Copyright (c) 2015 Randy McLain. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FeedTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *mainLabelForCell;
@property (weak, nonatomic) IBOutlet UILabel *downCountForCell;
@property (weak, nonatomic) IBOutlet UILabel *upCountForCell;
@property (weak, nonatomic) IBOutlet UIImageView *downTriangleForCell;
@property (weak, nonatomic) IBOutlet UIImageView *upTriangleForCell;
@property (weak, nonatomic) IBOutlet UITextView *textViewForCell;
@property (weak, nonatomic) IBOutlet UILabel *dateForCell;

@end
