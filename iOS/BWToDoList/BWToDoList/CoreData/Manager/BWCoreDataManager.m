//
//  BWCoreDataManager.m
//  BWToDoList
//
//  Created by BobWong on 2018/2/12.
//  Copyright © 2018年 BobWongStudio. All rights reserved.
//

#import "BWCoreDataManager.h"

@interface BWCoreDataManager ()

@property (strong, nonatomic) NSManagedObjectContext *context;

@end

@implementation BWCoreDataManager

#pragma mark - Life Cycle

+ (instancetype)sharedManager {
    static id sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (instancetype)init {
    if (self = [super init]) {
        [self setupData];
    }
    return self;
}

#pragma mark - Public Method

- (NSArray<BWToDoItem *> *)fetchAllItems {
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"ToDoItem"];  // 建立获取数据的请求对象，指明操作的实体为ToDoItem
    // 执行获取操作，获取所有Employee托管对象
    NSError *error = nil;
    NSArray<BWToDoItem *> *persons = [self.context executeFetchRequest:request error:&error];
    if (error) {
        NSLog(@"CoreData Fetch Error : %@", error);
        return @[];
    }
    return persons;
}

- (BWToDoItem *)insertWithTitle:(NSString *)title content:(NSString *)content time:(NSDate *)time {
    if (!title) {
        NSLog(@"CoreData insert error: no title");
        return nil;
    }
    
    BWToDoItem *newItem =[NSEntityDescription insertNewObjectForEntityForName:@"ToDoItem" inManagedObjectContext:self.context];
    newItem.title = title;
    if (content) newItem.content = content;
    if (time) newItem.time = time;
    
    NSError *error = nil;
    [self.context save:&error];
    if (error) {
        NSLog(@"CoreData insert error: %@", error);
        return nil;
    }
    NSLog(@"CoreData has insert item");
    return newItem;
}

- (BOOL)remove:(BWToDoItem *)item {
    if (!item) {
        NSLog(@"CoreData remove error: nil item");
        return NO;
    }
    
    [self.context deleteObject:item];
    NSError *error = nil;
    [self.context save:&error];
    if (error) {
        NSLog(@"CoreData remove error: %@", error);
        return NO;
    }
    NSLog(@"CoreData has remove item");
    return YES;
}

- (BOOL)modify:(BWToDoItem *)item {
    if (!self.context.hasChanges) {
        NSLog(@"CoreData modify error: context has no changes!");
        return NO;
    }
    
    NSError *error = nil;
    [self.context save:&error];
    if (error) {
        NSLog(@"CoreData modify error: %@", error);
        return NO;
    }
    NSLog(@"CoreData has modified item!");
    return YES;
}

- (BOOL)save {
    if (self.context.hasChanges) {
        NSError *error = nil;
        [self.context save:&error];
        return error ? NO : YES;
    }
    return YES;
}

#pragma mark - Private Method

- (void)setupData {
    // 创建上下文对象，并发队列设置为主队列
    NSManagedObjectContext *context = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    self.context = context;
    
    // 创建托管对象模型，并使用Company.momd路径当做初始化参数
    NSURL *modelPath = [[NSBundle mainBundle] URLForResource:@"BWToDoModel" withExtension:@"momd"];
    NSManagedObjectModel *model = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelPath];
    
    // 创建持久化存储调度器
    NSPersistentStoreCoordinator *coordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:model];
    
    // 创建并关联SQLite数据库文件，如果已经存在则不会重复创建
    NSString *dataPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject;
    NSLog(@"dataPath: %@", dataPath);
    dataPath = [dataPath stringByAppendingFormat:@"/%@.sqlite", @"ToDoList"];
    [coordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:[NSURL fileURLWithPath:dataPath] options:nil error:nil];
    
    // 上下文对象设置属性为持久化存储器
    context.persistentStoreCoordinator = coordinator;
}

@end
