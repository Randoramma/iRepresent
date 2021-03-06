//
//  ViewController.m
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
  self.tabBarController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Logout" style:UIBarButtonItemStyleDone target:self action:@selector(logout)];
  
  [super viewDidLoad];
  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refresh:) name:@"RefreshMasterNotification" object:nil];
  
  // determining which tab-bar button we selected to determine the sort functionality we want.
  if (self.view.tag == 1) {
    self.feedFormat = @"sort=newest";
    self.navigationItem.title = @"Newest Issues";
  } else if (self.view.tag == 2) {
    self.feedFormat = @"sort=popular";
    self.navigationItem.title = @"Popular Issues";
  }
  
//  [iRepresentAPIService feedRequestwithSortFormat:self.feedFormat completionHandler:^(NSArray *items, NSString *error) {
//    if (!error) {
//      self.issues = items;
//    } else {
//      NSLog(@"Feed response error is: %@", error);
//    }
//    [self.tableView reloadData];
//  }];
  
  UINib *cellNib = [UINib nibWithNibName:@"FeedCell" bundle:nil];
  [self.tableView registerNib:cellNib forCellReuseIdentifier:@"feedNib"];
  
} // viewDidLoad

-(void)viewWillAppear:(BOOL)animated {
  [iRepresentAPIService feedRequestwithSortFormat:self.feedFormat completionHandler:^(NSArray *items, NSString *error) {
    if (!error) {
      self.issues = items;
    } else {
      NSLog(@"Feed response error is: %@", error);
    }
    [self.tableView reloadData];
  }];
  
  [super viewWillAppear:true];
  if (self.view.tag == 1) {
    [self.tableView reloadData];
    self.feedFormat = @"sort=newest";
    self.navigationItem.title = @"Newest Issues";
  } else if (self.view.tag == 2) {
    [self.tableView reloadData];
    self.feedFormat = @"sort=popular";
    self.navigationItem.title = @"Popular Issues";
  }
}

#pragma mark - TableView
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return self.issues.count;
} // numberOfRowsInSection

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  FeedTableViewCell *theCell = [tableView dequeueReusableCellWithIdentifier:@"feedNib"];
  Issue *theIssue = self.issues[indexPath.row];
  theCell.myMainLabelForCell.text = theIssue.title;
  theCell.myTextViewForCell.text = theIssue.content;
  theCell.myDateForCell.text = theIssue.theDate;
  theCell.myTextViewForCell.text = theIssue.content;
  theCell.myUpCountForCell.text = [NSString stringWithFormat:@"%ld",(long)theIssue.upVotes];
  theCell.myDownCountForCell.text = [NSString stringWithFormat:@"%ld", (long)theIssue.downVotes];
  
  theCell.myTextViewForCell.userInteractionEnabled = NO;
  
  UIImage *backgroundImage = [UIImage imageNamed:@"Cell Background"];
  theCell.background.backgroundColor= [UIColor colorWithPatternImage:backgroundImage];
  
  return theCell;
} // cellForRowAtIndexPath

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  [self performSegueWithIdentifier:@"segueToDetail" sender:self];
  
} // didSelectRowAtIndexPath


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
  if ([segue.identifier isEqual:@"segueToNewDetail"]) {
    // pass an empty issue object to detail controller.
    // DetailViewController *newDetail = (DetailViewController*)segue.destinationViewController;
    // send issue over
  }else if ([segue.identifier isEqual:@"segueToDetail"]) {
    // pass a completed issue object to detail controller.
    NSIndexPath *theIndexPath = [self.tableView indexPathForSelectedRow];
    NSInteger theRow = [theIndexPath row];
    DetailViewController *newDetail = (DetailViewController*)segue.destinationViewController;
    newDetail.selectedIssue = self.issues[theRow];
    
    //    [self.navigationController pushViewController:detailVCFromIssue animated:true];
    
  }else if ([segue.identifier isEqual:@"logout"]) {
    // here I want to return to the root VC.
    [self logout]; 
    
  }else {
    NSLog(@"non-labeled segue was chosen.");
  }
} // prepareForSegue

-(void) logout {
  NSString *token = @"";
  NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
  [userDefaults setObject:token forKey:@"token"];
# warning Get back to root view controller.
  NSArray *viewControllers = self.navigationController.viewControllers;
  UIViewController *rootViewController = [viewControllers objectAtIndex:0];
  [self.navigationController pushViewController:rootViewController animated:true]; 
  
}

- (void)refresh:(NSNotification *)notification
{
  [self.tableView reloadData];
}
@end
