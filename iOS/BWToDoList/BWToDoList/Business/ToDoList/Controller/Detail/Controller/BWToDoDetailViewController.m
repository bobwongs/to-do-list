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
    [self setupUIData];
}

#pragma mark - Action

- (void)cancelAction {
    [self dismissVC];
}

- (void)doneAction {
    NSString *title = self.titleTextField.text;
    NSString *content = self.contentTextField.text;
    
    // Modified.
    if (self.item) {
        if (![self.item.title isEqualToString:title]) self.item.title = title;
        if (![self.item.content isEqualToString:content]) self.item.content = content;
        [[BWCoreDataManager sharedManager] save];
        if (self.modificationBlock) self.modificationBlock(self.item);
        [self dismissVC];
        return;
    }
    
    // New added.
    BWToDoItem *item = [[BWCoreDataManager sharedManager] insertWithTitle:title content:content];
    if (!item) {  // 插入失败
        return;
    }
    if (self.addedBlock) self.addedBlock(item);
    [self dismissVC];
}

#pragma mark - Private Method

- (void)setupNavigationUI {
    if (!self.item) {
        UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelAction)];
        self.navigationItem.leftBarButtonItem = leftItem;
    }
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneAction)];
    self.navigationItem.rightBarButtonItem = rightItem;
}

- (void)setupUIData {
    if (self.item) {
        self.titleTextField.text = self.item.title;
        self.contentTextField.text = self.item.content;
    }
}

- (void)dismissVC {
    if (self.navigationController.viewControllers.count > 1) {
        [self.navigationController popViewControllerAnimated:YES];
        return;
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
