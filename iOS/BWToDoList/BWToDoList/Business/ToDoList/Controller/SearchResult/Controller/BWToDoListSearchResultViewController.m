//
//  BWToDoListSearchResultViewController.m
//  BWToDoList
//
//  Created by BobWong on 2018/2/13.
//  Copyright © 2018年 BobWongStudio. All rights reserved.
//

#import "BWToDoListSearchResultViewController.h"
#import "BWToDoListSearchResultCell.h"
#import "BWToDoItem.h"
#import "BWToDoDetailViewController.h"

NSString *const BWToDoListSearchResultCellId = @"BWToDoListSearchResultCellId";

@interface BWToDoListSearchResultViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation BWToDoListSearchResultViewController

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([BWToDoListSearchResultCell class]) bundle:nil] forCellReuseIdentifier:BWToDoListSearchResultCellId];
}

#pragma mark - TableView DataSource and Delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource ? self.dataSource.count : 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BWToDoListSearchResultCell *cell = [tableView dequeueReusableCellWithIdentifier:BWToDoListSearchResultCellId];
    BWToDoItem *item = self.dataSource[indexPath.row];
    cell.titleLabel.text = item.title;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    BWToDoItem *item = self.dataSource[indexPath.row];
    if (self.didSelectBlock) self.didSelectBlock(item);
}

#pragma mark - Setter and Getter

- (void)setDataSource:(NSArray<BWToDoItem *> *)dataSource {
    _dataSource = dataSource;
    [self.tableView reloadData];
}

@end
