//
//  BWMainTabBarController.m
//  BWToDoList
//
//  Created by BobWong on 2018/2/9.
//  Copyright © 2018年 BobWongStudio. All rights reserved.
//

#import "BWMainTabBarController.h"
#import "BWToDoListViewController.h"
#import "BWMeViewController.h"
#import "UINavigationController+BWAdd.h"

@interface BWMainTabBarController ()

@end

@implementation BWMainTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupViewController];
}

- (void)setupViewController {
    BWToDoListViewController *toDoListVC = [BWToDoListViewController new];
    UINavigationController *toDoListNavigationVC = [UINavigationController bw_defaultStyleWithRootViewController:toDoListVC];
    
    BWMeViewController *meVC = [BWMeViewController new];
    UINavigationController *meNavigationVC = [UINavigationController bw_defaultStyleWithRootViewController:meVC];
    
    self.viewControllers = @[toDoListNavigationVC, meNavigationVC];
    
    NSArray<NSString *> *titleArray = @[@"List", @"Me"];
//    NSArray<NSString *> *normalImageNameArray = @[@"shop2", @"cart2"];
//    NSArray<NSString *> *selectedImageNameArray = @[@"shop1", @"cart1"];
    [self.viewControllers enumerateObjectsUsingBlock:^(__kindof UIViewController * _Nonnull vc, NSUInteger idx, BOOL * _Nonnull stop) {
        vc.tabBarItem.title = titleArray[idx];
    }];
}

@end
