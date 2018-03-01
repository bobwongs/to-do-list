//
//  BWToDoListSearchResultViewController.h
//  BWToDoList
//
//  Created by BobWong on 2018/2/13.
//  Copyright © 2018年 BobWongStudio. All rights reserved.
//

#import "BWBaseViewController.h"
@class BWToDoItem;

@interface BWToDoListSearchResultViewController : BWBaseViewController

@property (strong, nonatomic) NSArray<BWToDoItem *> *dataSource;
@property (copy, nonatomic) void(^didSelectBlock)(BWToDoItem *item);

@end
