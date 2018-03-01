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
@property (weak, nonatomic) IBOutlet UISwitch *timeSwitch;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;

@end

@implementation BWToDoDetailViewController

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"To Do Item";
    [self setupNavigationUI];
    [self setupUIData];
    
    [self setNeedsStatusBarAppearanceUpdate];
}

#pragma mark - Action

- (void)cancelAction {
    [self dismissVC];
}

- (void)doneAction {
    NSString *title = self.titleTextField.text;
    NSString *content = self.contentTextField.text;
    NSDate *time = self.timeSwitch.on ? self.datePicker.date : nil;
    
    // Modified.
    if (self.item) {
        self.item.title = title;
        self.item.content = content;
        self.item.time = time;
        [[BWCoreDataManager sharedManager] save];
        
        if (self.modificationBlock) self.modificationBlock(self.item);
        [self dismissVC];
        return;
    }
    
    // New added.
    BWToDoItem *item = [[BWCoreDataManager sharedManager] insertWithTitle:title content:content time:time];
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

#pragma mark - Override

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

@end
