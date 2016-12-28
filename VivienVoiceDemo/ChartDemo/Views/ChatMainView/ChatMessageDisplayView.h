//
//  ChatMessageDisplayView.h
//  VivienVoiceDemo
//
//  Created by Vivien on 2016/12/16.
//  Copyright © 2016年 Vivien. All rights reserved.
//

#import "ChatBaseView.h"
#import "ChatMessageDisplayView.h"
#import "ChatMessageDisplayViewDelegate.h"
@interface ChatMessageDisplayView : ChatBaseView

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *dataArr;

@property (nonatomic, assign) id<ChatMessageDisplayViewDelegate>delegate;

- (void)reloadData;


@end
