//
//  NavControllerViewController.m
//  iRepresent
//
//  Created by Randy McLain on 11/19/15.
//  Copyright © 2015 Randy McLain. All rights reserved.
//

#import "NavController.h"

@interface NavController ()

@end

@implementation NavController

- (void)viewDidLoad {
    [super viewDidLoad];
  
  self.navigationBar.backgroundColor = [UIColor blackColor];
  self.navigationBar.tintColor = [UIColor whiteColor]; 
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
