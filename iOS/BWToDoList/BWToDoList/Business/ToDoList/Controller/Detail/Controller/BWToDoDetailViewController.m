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

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UITextField *titleTextField;
@property (weak, nonatomic) IBOutlet UITextField *contentTextField;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UISwitch *timeSwitch;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *datePickerHeight;

@end

@implementation BWToDoDetailViewController

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"To Do Item";
    [self setupNavigationUI];
    [self setupUIData];
    [self localize];
    
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

- (IBAction)switchAction:(UISwitch *)sender {
    self.datePickerHeight.constant = sender.on ? 162.0 : 0.0;
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
        
        if (self.item.time) {
            self.datePicker.date = self.item.time;
            self.timeSwitch.on = YES;
            [self.timeSwitch sendActionsForControlEvents:UIControlEventValueChanged];
        }
    }
}

/** 本地化 */
- (void)localize {
    self.titleLabel.text = BWLocalized(@"标题");
    self.contentLabel.text = BWLocalized(@"内容");
    self.timeLabel.text = BWLocalized(@"提醒时间");
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
