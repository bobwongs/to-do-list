//
//  UINavigationController+BWAdd.m
//  BWToDoList
//
//  Created by BobWong on 2018/2/9.
//  Copyright © 2018年 BobWongStudio. All rights reserved.
//

#import "UINavigationController+BWAdd.h"

@implementation UINavigationController (BWAdd)

+ (instancetype)bw_defaultStyleWithRootViewController:(UIViewController *)rootViewController {
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:rootViewController];
    UINavigationBar *navigationBar = navigationController.navigationBar;
    navigationBar.tintColor = [UIColor whiteColor];
    navigationBar.barTintColor = [UIColor colorWithRed:42.0/255.0 green:40.0/255.0 blue:46.0/255.0 alpha:1.0];
    return navigationController;
}

@end
