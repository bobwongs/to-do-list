//
//  BWToDoDetailViewController.m
//  BWToDoList
//
//  Created by BobWong on 2018/2/9.
//  Copyright © 2018年 BobWongStudio. All rights reserved.
//

#import "BWToDoDetailViewController.h"
#import "BWCoreDataManager.h"

@interface BWToDoDetailViewController ()

@property (weak, nonatomic) IBOutlet UITextField *titleTextField;
@property (weak, nonatomic) IBOutlet UITextField *contentTextField;

@end

@implementation BWToDoDetailViewController

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"To Do Item";
    [self setupNavigationUI];
}

#pragma mark - Action

- (void)cancelAction {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)doneAction {
    NSString *title = self.titleTextField.text;
    NSString *content = self.contentTextField.text;
    
    if (![[BWCoreDataManager sharedManager] insertWithTitle:title content:content]) {  // 插入失败
        return;
    }
    if (self.addedBlock) self.addedBlock(item);
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Private Method

- (void)setupNavigationUI {
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelAction)];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneAction)];
    self.navigationItem.rightBarButtonItem = rightItem;
}

@end
