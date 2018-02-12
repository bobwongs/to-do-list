//
//  BWToDoDetailViewController.h
//  BWToDoList
//
//  Created by BobWong on 2018/2/9.
//  Copyright © 2018年 BobWongStudio. All rights reserved.
//

#import "BWBaseViewController.h"
#import "BWToDoItem.h"

@interface BWToDoDetailViewController : BWBaseViewController

@property (copy, nonatomic) void(^addedBlock)(BWToDoItem *item);  ///< Added
@property (copy, nonatomic) void(^modificationBlock)(BWToDoItem *item);  ///< Modification

@end
