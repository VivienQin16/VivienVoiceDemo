//
//  ChatMainViewController.h
//  VivienVoiceDemo
//
//  Created by Vivien on 2016/12/12.
//  Copyright © 2016年 Vivien. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChatBaseViewController.h"
#import "ChatMessageDisplayView.h"
#import "ChatBar.h"
#import "KeyboardMoreView.h"
#import "RecorderIndicatorView.h"
@interface ChatMainViewController : ChatBaseViewController
    
@property (nonatomic, strong) NSMutableArray *dataArray;

@property (nonatomic, assign) EcoChatBarStatus lastStatus;

@property (nonatomic, assign) EcoChatBarStatus curStatus;

/// 消息展示页面
@property (nonatomic, strong) ChatMessageDisplayView *messageDisplayView;

/// 聊天输入栏
@property (nonatomic, strong) ChatBar *chatBar;

/// 更多键盘
@property (nonatomic, strong) KeyboardMoreView *moreKeyboard;
/// 录音展示view
@property (nonatomic, strong) RecorderIndicatorView *recorderIndicatorView;;

- (void)setMessageData;
- (void)layoutSubviews;

@end
