//
//  FeedTableViewController.m
//  iRepresent
//
//  Created by Randy McLain on 5/18/15.
//  Copyright (c) 2015 Randy McLain. All rights reserved.
//

#import "DetailViewController.h"
#import "FeedTableViewController.h"
#import "FeedTableViewCell.h"
#import "JSONParser.h"
#import "iRepresentAPIService.h"
#import <UIKit/UIKit.h>


@interface FeedTableViewController ()
@property (strong, nonatomic) NSString *feedFormat;
@property (strong, nonatomic) NSArray *issues;

@end

@implementation FeedTableViewController

-(void)viewDidLoad {
  self.tableView.delegate = self;
  self.tableView.dataSource = self;
  // determining which tab bar button we selected to determine the sort functionality we want.
  if (self.view.tag == 1) {
    
    
    self.feedFormat = @"sort=newest";
  } else if (self.view.tag == 2) {
    self.feedFormat = @"sort=popular";
  }

  
  [iRepresentAPIService feedRequestwithSortFormat:self.feedFormat completionHandler:^(NSArray *items, NSString *error) {
    
    if (!error) {
    self.issues = items;
      NSLog(@"we got to the Feed Table View"); 
    } else {
      NSLog(@"%@", error.description);
    }
    
  }];
  
  UINib *cellNib = [UINib nibWithNibName:@"FeedCell" bundle:nil];
  [self.tableView registerNib:cellNib forCellReuseIdentifier:@"feedNib"];
  
} // viewDidLoad

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  
  return self.issues.count;
} // numberOfRowsInSection

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  FeedTableViewCell *theCell = [tableView dequeueReusableCellWithIdentifier:@"feedNib"];
  Issue *theIssue = self.issues[indexPath.row];
  theCell.myMainLabelForCell.text = theIssue.title;
  theCell.myTextViewForCell.text = theIssue.content;
//  theCell.myDownCountForCell.text = [NSString stringWithFormat:theIssue.downVotes];
//  theCell.myUpCountForCell.text = theIssue.upVotes;
  
  return theCell;
} // cellForRowAtIndexPath

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

//  self performSegueWithIdentifier:@"segueToDetail" sender:[indexPath.row];

} // didSelectRowAtIndexPath



@end
