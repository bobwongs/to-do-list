//
//  BWToDoItem.h
//  BWToDoList
//
//  Created by BobWong on 2018/2/12.
//  Copyright © 2018年 BobWongStudio. All rights reserved.
//

#import <CoreData/CoreData.h>

@interface BWToDoItem : NSManagedObject

@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *content;

@end
