//
//  FeedTableViewCell.h
//  iRepresent
//
//  Created by Randy McLain on 5/18/15.
//  Copyright (c) 2015 Randy McLain. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FeedTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *myMainLabelForCell;
@property (weak, nonatomic) IBOutlet UILabel *myDownCountForCell;
@property (weak, nonatomic) IBOutlet UILabel *myUpCountForCell;
@property (weak, nonatomic) IBOutlet UIImageView *myDownTriangleForCell;
@property (weak, nonatomic) IBOutlet UIImageView *myUpTriangleForCell;
@property (weak, nonatomic) IBOutlet UITextView *myTextViewForCell;
@property (weak, nonatomic) IBOutlet UILabel *myDateForCell;
@property (weak, nonatomic) IBOutlet UIView *background;

@end
