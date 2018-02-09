//
//  BWToDoListViewController.m
//  BWToDoList
//
//  Created by BobWong on 2018/2/9.
//  Copyright © 2018年 BobWongStudio. All rights reserved.
//

#import "BWToDoListViewController.h"

@interface BWToDoListViewController () <UITableViewDataSource, UITableViewDelegate>

/* UI */
@property (weak, nonatomic) IBOutlet UITextField *inputTextField;

@end

@implementation BWToDoListViewController

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"To Do List";
    [self setUI];
}

#pragma mark - Private Method

- (void)setUI {
    
}

#pragma mark - Getter and Setter

@end
