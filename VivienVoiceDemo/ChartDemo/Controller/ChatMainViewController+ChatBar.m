//
//  ChatMainViewController+ChatBar.m
//  VivienVoiceDemo
//
//  Created by Vivien on 2016/12/21.
//  Copyright © 2016年 Vivien. All rights reserved.
//

#import "ChatMainViewController+ChatBar.h"

@implementation ChatMainViewController (ChatBar)

#pragma mark --改变Charbar状态
- (void)changeStatusFrom:(EcoChatBarStatus)fromStatus to:(EcoChatBarStatus)toStatus
{
    if (self.curStatus == toStatus) {
        return;
    }
    self.lastStatus = fromStatus;
    self.curStatus = toStatus;
    
     if (toStatus == EcoChatBarStatusKeyboard)
    {
        [self.chatBar mas_updateConstraints:^(MASConstraintMaker *make) {
             make.bottom.mas_equalTo(self.view).mas_offset(-HEIGHT_CHAT_KEYBOARD);
        }];
    }
     else if (toStatus == EcoChatBarStatusMore)
    {
        [self.moreKeyboard showInView:self.view withAnimation:YES];
        
        [self.chatBar mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(self.view).mas_offset(-HEIGHT_CHAT_KEYBOARD);
        }];
    }
     else if (toStatus == EcoChatBarStatusVoice)
     {
         if (fromStatus == EcoChatBarStatusMore) {
             [self.moreKeyboard dismissWithAnimation:YES];
         }
    
         [self.chatBar mas_updateConstraints:^(MASConstraintMaker *make) {
             make.bottom.mas_equalTo(self.view);
         }];
     }
    
    [self layoutSubviews];
}

///点击空白区域隐藏chatBar
- (void)chatMessageDisplayViewDidTouched:(ChatMessageDisplayView *)chatTVC
{
    if (self.curStatus == EcoChatBarStatusMore) {
        [self.moreKeyboard dismissWithAnimation:YES];
        [self.chatBar mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(self.view);
        }];
        self.curStatus = self.lastStatus;
        
    }
    else if(self.curStatus == EcoChatBarStatusKeyboard)
    {
        //收缩键盘
        [self.chatBar mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(self.view);
        }];
    }
    
    [self.chatBar resignFirstResponder];
}


//发送文本
- (void)sendTextViewText:(NSString *)text
{
    EcoMessage *textMessage = [[EcoMessage alloc]init];
    textMessage.ownerTyper = MessageOwnerTypeSelf;
    textMessage.messageText = text;
    textMessage.messageType = MessageTypeText;
    
    BOOL result =  [[EcoMessageManager sharedMessageManager]  saveEcoMessage:textMessage];
    if (result) {
        [self setMessageData];
        [self.messageDisplayView reloadData];
    }
    
    
    
}

#pragma mark --系统键盘回调
- (void)keyboardWillShow:(NSNotification *)notification
{
    if (self.curStatus != EcoChatBarStatusKeyboard) {
        return;
    }
//    [self.messageDisplayView scrollToBottomWithAnimation:YES];
}

- (void)keyboardDidShow:(NSNotification *)notification
{
//    if (curStatus != TLChatBarStatusKeyboard) {
//        return;
//    }
//    if (lastStatus == TLChatBarStatusMore) {
//        [self.moreKeyboard dismissWithAnimation:NO];
//    }
//    [self.messageDisplayView scrollToBottomWithAnimation:YES];
}

- (void)keyboardFrameWillChange:(NSNotification *)notification
{
//    if (curStatus != TLChatBarStatusKeyboard && lastStatus != TLChatBarStatusKeyboard) {
//        return;
//    }
    CGRect keyboardFrame = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
//    if (lastStatus == TLChatBarStatusMore || lastStatus == TLChatBarStatusEmoji) {
//        if (keyboardFrame.size.height <= HEIGHT_CHAT_KEYBOARD) {
//            return;
//        }
//    }
//    else if (curStatus == TLChatBarStatusEmoji || curStatus == TLChatBarStatusMore) {
//        return;
//    }
    [self.chatBar mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.view).mas_offset(-keyboardFrame.size.height);
    }];
    [self.view layoutIfNeeded];
//    [self.messageDisplayView scrollToBottomWithAnimation:YES];
}

- (void)keyboardWillHide:(NSNotification *)notification
{
//    if (curStatus != TLChatBarStatusKeyboard && lastStatus != TLChatBarStatusKeyboard) {
//        return;
//    }
//    if (curStatus == TLChatBarStatusEmoji || curStatus == TLChatBarStatusMore) {
//        return;
//    }
    [self.chatBar mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.view);
    }];
    [self.view layoutIfNeeded];
}

#pragma mark - record
// 录音控制
- (void)chatBarStartRecording:(ChatBar *)chatBar
{
    [self.recorderIndicatorView setStatus:RecorderStatusRecording];
    [self.messageDisplayView addSubview:self.recorderIndicatorView];
    [self.recorderIndicatorView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(150, 150));
    }];
    
}

- (void)chatBarWillCancelRecording:(ChatBar *)chatBar cancel:(BOOL)cancel
{
     [self.recorderIndicatorView setStatus:cancel ? RecorderStatusWillCancel : RecorderStatusRecording];
}

- (void)chatBarDidCancelRecording:(ChatBar *)chatBar
{
    //取消时，拿掉
    [self.recorderIndicatorView removeFromSuperview];
}

- (void)chatBarFinishedRecoding:(ChatBar *)chatBar
{
    [self.recorderIndicatorView removeFromSuperview];
}

@end
