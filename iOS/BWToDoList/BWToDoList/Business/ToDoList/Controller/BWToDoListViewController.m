//
//  BWToDoListViewController.m
//  BWToDoList
//
//  Created by BobWong on 2018/2/9.
//  Copyright © 2018年 BobWongStudio. All rights reserved.
//

#import "BWToDoListViewController.h"
#import "BWToDoListCell.h"
#import "BWToDoDetailViewController.h"
#import "BWCoreDataManager.h"

NSString *const BWToDoListCellId = @"BWToDoListCellId";

@interface BWToDoListViewController () <UITableViewDataSource, UITableViewDelegate>

/* UI */
@property (weak, nonatomic) IBOutlet UITableView *tableView;

/* Data */
@property (strong, nonatomic) NSMutableArray<BWToDoItem *> *dataSource;

@end

@implementation BWToDoListViewController

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"To Do List";
    [self setupData];
    [self setupUI];
}

#pragma mark - Action

- (void)addAction {
    BWToDoDetailViewController *detailViewController = [BWToDoDetailViewController new];
    __weak typeof(self) weakSelf = self;
    detailViewController.addedBlock = ^(BWToDoItem *item) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        [strongSelf addItem:item];
    };
    [self.navigationController pushViewController:detailViewController animated:YES];
}

#pragma mark - TableView Data Source and Delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource ? self.dataSource.count : 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BWToDoListCell *cell = [tableView dequeueReusableCellWithIdentifier:BWToDoListCellId];
    NSInteger row = indexPath.row;
    
    BWToDoItem *item = self.dataSource[row];
    cell.titleLabel.text = item.title;
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    BWToDoDetailViewController *detailVC = [BWToDoDetailViewController new];
    [self.navigationController pushViewController:detailVC animated:YES];
}

- (NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewRowAction *deleteAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"Delete" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        [self.dataSource removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationBottom];
    }];
    UITableViewRowAction *shareAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"Share" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        NSInteger row = indexPath.row;
        NSLog(@"share indexPath.row: %ld, message: %@", (long)row, self.dataSource[row]);
    }];
    return @[deleteAction, shareAction];
}

#pragma mark - Private Method

- (void)setupData {
    NSArray<BWToDoItem *> *allItems = [[BWCoreDataManager sharedManager] fetchAllItems];
    self.dataSource = [NSMutableArray arrayWithArray:allItems];
}

- (void)setupNavigationUI {
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addAction)];
    self.navigationItem.rightBarButtonItem = rightItem;
}

- (void)setupUI {
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([BWToDoListCell class]) bundle:nil] forCellReuseIdentifier:BWToDoListCellId];
}

- (void)addItem:(BWToDoItem *)item {
    [self.dataSource addObject:item];

    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:self.dataSource.count - 1 inSection:0];
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationTop];
}

@end
