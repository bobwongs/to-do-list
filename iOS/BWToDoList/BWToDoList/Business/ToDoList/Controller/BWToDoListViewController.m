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
#import "UINavigationController+BWAdd.h"
#import "BWToDoListSearchResultViewController.h"

NSString *const BWToDoListCellId = @"BWToDoListCellId";

@interface BWToDoListViewController () <UITableViewDataSource, UITableViewDelegate, UISearchResultsUpdating>

/* UI */
@property (weak, nonatomic) IBOutlet UITableView *tableView;

/* Data */
@property (strong, nonatomic) NSMutableArray<BWToDoItem *> *dataSource;

@property (strong, nonatomic) UISearchController *searchController;
@property (strong, nonatomic) BWToDoListSearchResultViewController *resultController;

@end

@implementation BWToDoListViewController

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupData];
    [self setupNavigationUI];
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
    UINavigationController *detailNavigationController = [UINavigationController bw_defaultStyleWithRootViewController:detailViewController];
    [self presentViewController:detailNavigationController animated:YES completion:nil];
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
    cell.contentLabel.text = item.content;
    
    NSString *timeStr;
    if (item.time) {
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"YYYY/MM/dd HH:mm";
        timeStr = [formatter stringFromDate:item.time];
    } else {
        timeStr = @"";
    }
    cell.timeLabel.text = timeStr;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    BWToDoItem *item = self.dataSource[indexPath.row];
    [self pushToDetail:item];
}

- (NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewRowAction *deleteAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"Delete" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        [self deleteItemInIndexPath:indexPath];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationBottom];
    }];
    UITableViewRowAction *shareAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"Share" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        NSInteger row = indexPath.row;
        NSLog(@"share indexPath.row: %ld, message: %@", (long)row, self.dataSource[row]);
    }];
    return @[deleteAction, shareAction];
}

#pragma mark - UISearchResultsUpdating

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    NSString *text = searchController.searchBar.text;
    NSMutableArray<BWToDoItem *> *arrayM = [NSMutableArray new];
    [self.dataSource enumerateObjectsUsingBlock:^(BWToDoItem * _Nonnull item, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([item.title containsString:text]) {
            [arrayM addObject:item];
        }
    }];
    self.resultController.dataSource = arrayM;
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
    BWToDoListSearchResultViewController *resultController = [BWToDoListSearchResultViewController new];
    self.resultController = resultController;
    __weak typeof(self) weakSelf = self;
    resultController.didSelectBlock = ^(BWToDoItem *item) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        strongSelf.searchController.active = NO;
        [strongSelf pushToDetail:item];
    };
    
    UISearchController *searchController = [[UISearchController alloc] initWithSearchResultsController:resultController];
    self.searchController = searchController;
    searchController.searchResultsUpdater = self;
    searchController.dimsBackgroundDuringPresentation = NO;
    self.tableView.tableHeaderView = self.searchController.searchBar;
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([BWToDoListCell class]) bundle:nil] forCellReuseIdentifier:BWToDoListCellId];
}

- (void)addItem:(BWToDoItem *)item {
    [self.dataSource addObject:item];

    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:self.dataSource.count - 1 inSection:0];
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationTop];
}

- (void)deleteItemInIndexPath:(NSIndexPath *)indexPath {
    BWToDoItem *item = self.dataSource[indexPath.row];
    [[BWCoreDataManager sharedManager] remove:item];
    [self.dataSource removeObjectAtIndex:indexPath.row];
}

- (void)pushToDetail:(BWToDoItem *)item {
    BWToDoDetailViewController *detailVC = [BWToDoDetailViewController new];
    detailVC.item = item;
    __weak typeof(self) weakSelf = self;
    detailVC.modificationBlock = ^(BWToDoItem *item) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        [strongSelf.tableView reloadData];
    };
    [self.navigationController pushViewController:detailVC animated:YES];
}

#pragma mark - Setter and Getter

#pragma mark - Status Bar研究

// Override
- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleDefault;
}

//- (void)viewDidAppear:(BOOL)animated {
//    [super viewDidAppear:animated];
//    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
//}
//
//- (void)viewDidDisappear:(BOOL)animated {
//    [super viewDidDisappear:animated];
//    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
//}

@end
