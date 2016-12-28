//
//  ChatMessageDisplayView.m
//  VivienVoiceDemo
//
//  Created by Vivien on 2016/12/16.
//  Copyright © 2016年 Vivien. All rights reserved.
//

#import "ChatMessageDisplayView.h"
#import "ChatMessageDisplayView+Delegate.h"

@implementation ChatMessageDisplayView

@synthesize tableView = _tableView;


- (void)initSubviews
{
    [self addSubview:self.tableView];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTouchTableView)];
    [self.tableView addGestureRecognizer:tap];

}

- (void)setSubviewsLayout
{
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
}


- (void)didTouchTableView
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(chatMessageDisplayViewDidTouched:)]) {
        [self.delegate chatMessageDisplayViewDidTouched:self];
    }
}

- (void)scrollToBottomWithAnimation:(BOOL)animation
{
    [self.tableView scrollToBottomWithAnimation:animation];
}


- (void)reloadData
{
    [self.tableView reloadData];
}

#pragma mark - # Getter
- (UITableView *)tableView
{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] init];
        [_tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        [_tableView setBackgroundColor:[UIColor clearColor]];
        [_tableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 10)]];
        [_tableView setDelegate:self];
        [_tableView setDataSource:self];
    }
    return _tableView;
}

@end
