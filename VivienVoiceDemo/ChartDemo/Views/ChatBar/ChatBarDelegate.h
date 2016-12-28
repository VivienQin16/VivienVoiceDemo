//
//  ChatBarDelegate.h
//  VivienVoiceDemo
//
//  Created by Vivien on 2016/12/21.
//  Copyright © 2016年 Vivien. All rights reserved.
//
#import <Foundation/Foundation.h>
@class ChatBar;
@protocol ChatBarDelegate <NSObject>

/**
 *  chatBar状态改变
 */
- (void)changeStatusFrom:(EcoChatBarStatus)fromStatus to:(EcoChatBarStatus)toStatus;

@optional
- (void)sendTextViewText:(NSString *)text;

/**
 *  输入框高度改变
 */
- (void)chatBar:(ChatBar *)chatBar didChangeTextViewHeight:(CGFloat)height;


// 录音控制
- (void)chatBarStartRecording:(ChatBar *)chatBar;

- (void)chatBarWillCancelRecording:(ChatBar *)chatBar cancel:(BOOL)cancel;

- (void)chatBarDidCancelRecording:(ChatBar *)chatBar;

- (void)chatBarFinishedRecoding:(ChatBar *)chatBar;

@end

