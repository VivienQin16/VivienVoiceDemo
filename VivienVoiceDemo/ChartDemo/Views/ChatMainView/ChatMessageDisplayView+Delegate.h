//
//  ChatMessageDisplayView+Delegate.h
//  VivienVoiceDemo
//
//  Created by Vivien on 2016/12/19.
//  Copyright © 2016年 Vivien. All rights reserved.
//

#import "ChatMessageDisplayView.h"

@interface ChatMessageDisplayView (Delegate)<UITableViewDelegate, UITableViewDataSource>

- (void)registerCellClassForTableView:(UITableView *)tableView;

@end
