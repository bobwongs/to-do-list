//
//  BWBaseViewController.m
//  BWToDoList
//
//  Created by BobWong on 2018/2/9.
//  Copyright © 2018年 BobWongStudio. All rights reserved.
//

#import "BWBaseViewController.h"

@interface BWBaseViewController ()

@end

@implementation BWBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
}

- (void)dealloc {
    NSLog(@"Dealloc %@", NSStringFromClass([self class]));
}

@end
