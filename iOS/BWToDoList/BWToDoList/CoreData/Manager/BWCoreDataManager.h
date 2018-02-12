//
//  BWCoreDataManager.h
//  BWToDoList
//
//  Created by BobWong on 2018/2/12.
//  Copyright © 2018年 BobWongStudio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BWToDoItem.h"

@interface BWCoreDataManager : NSObject

+ (instancetype)sharedManager;

- (NSArray<BWToDoItem *> *)fetchAllItems;
- (BOOL)insert:(BWToDoItem *)item;
- (BOOL)remove:(BWToDoItem *)item;
- (BOOL)modify:(BWToDoItem *)item;

@end
