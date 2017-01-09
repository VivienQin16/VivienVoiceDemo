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
{
    BOOL isRecordCancel;
    BOOL isNewRecord; 
    EcoChatBarStatus lastStatus;
    EcoChatBarStatus curStatus;
}

///显示的数据
@property (nonatomic, strong) NSMutableArray *dataArray;
///消息
@property (nonatomic, strong) EcoMessage *sendMessage;

/// 消息展示页面
@property (nonatomic, strong) ChatMessageDisplayView *messageDisplayView;
/// 聊天输入栏
@property (nonatomic, strong) ChatBar *chatBar;
/// 更多键盘
@property (nonatomic, strong) KeyboardMoreView *moreKeyboard;
/// 录音展示view
@property (nonatomic, strong) RecorderIndicatorView *recorderIndicatorView;

///科大讯飞 语音识别对象
@property (nonatomic, strong) IFlySpeechRecognizer *iFlySpeechRecognizer;
//科大讯飞 语音返回结果
@property (nonatomic, strong) NSMutableString * resultText;


- (void)setMessageData;
- (void)layoutSubviews;

@end
