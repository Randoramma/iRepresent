//
//  FeedTableViewCell.m
//  iRepresent
//
//  Created by Randy McLain on 5/18/15.
//  Copyright (c) 2015 Randy McLain. All rights reserved.
//

#import "FeedTableViewCell.h"

@interface FeedTableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *feedCellTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *feedCellBodyLabel;
@property (weak, nonatomic) IBOutlet UIImageView *feedCellUpTriangle;
@property (weak, nonatomic) IBOutlet UIImageView *feedCellDownController;
@property (weak, nonatomic) IBOutlet UILabel *feedCellUpCount;
@property (weak, nonatomic) IBOutlet UILabel *feedCellDownCount;

@end

@implementation FeedTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
