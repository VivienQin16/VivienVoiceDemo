//
//  ChatMainViewController+ChatBar.m
//  VivienVoiceDemo
//
//  Created by Vivien on 2016/12/21.
//  Copyright © 2016年 Vivien. All rights reserved.
//

#import "ChatMainViewController+ChatBar.h"
#import "ISRDataHelper.h"
#import "Command.h"
@implementation ChatMainViewController (ChatBar)

#pragma mark --改变Charbar状态
- (void)changeStatusFrom:(EcoChatBarStatus)fromStatus to:(EcoChatBarStatus)toStatus
{
    if (curStatus == toStatus) {
        return;
    }
    
    lastStatus = fromStatus;
    curStatus = toStatus;
    
     if (toStatus == EcoChatBarStatusKeyboard)
    {
        [self.chatBar mas_updateConstraints:^(MASConstraintMaker *make) {
             make.bottom.mas_equalTo(self.view).mas_offset(-HEIGHT_CHAT_KEYBOARD);
        }];
        [self.messageDisplayView scrollToBottomWithAnimation:YES];
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
    
}

///点击空白区域隐藏chatBar
- (void)chatMessageDisplayViewDidTouched:(ChatMessageDisplayView *)chatTVC
{
    if (curStatus == EcoChatBarStatusMore) {
        [self.moreKeyboard dismissWithAnimation:YES];
        [self.chatBar mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(self.view);
        }];
        curStatus = lastStatus;
    }
    else if(curStatus == EcoChatBarStatusKeyboard)
    {
        //收缩键盘
        [self.chatBar mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(self.view);
        }];
    }
    
    [self.chatBar resignFirstResponder];
}

- (void)chatBar:(ChatBar *)chatBar didChangeTextViewHeight:(CGFloat)height
{
    [self.messageDisplayView scrollToBottomWithAnimation:NO];
}

#pragma mark --系统键盘回调
- (void)keyboardWillShow:(NSNotification *)notification
{
    if (curStatus != EcoChatBarStatusKeyboard) {
        return;
    }
    [self.messageDisplayView scrollToBottomWithAnimation:YES];
}

- (void)keyboardDidShow:(NSNotification *)notification
{
    if (curStatus != EcoChatBarStatusKeyboard) {
        return;
    }
    if (lastStatus == EcoChatBarStatusMore) {
        [self.moreKeyboard dismissWithAnimation:NO];
    }
    [self.messageDisplayView scrollToBottomWithAnimation:YES];
}

- (void)keyboardFrameWillChange:(NSNotification *)notification
{
    if (curStatus != EcoChatBarStatusKeyboard && lastStatus != EcoChatBarStatusKeyboard) {
        return;
    }
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
    [self.messageDisplayView scrollToBottomWithAnimation:YES];
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
    
    isNewRecord = YES;
    isRecordCancel = NO;
    self.sendMessage = nil;
    
    //科大讯飞 开始录音
    [self.iFlySpeechRecognizer startListening];
}


- (void)chatBarWillCancelRecording:(ChatBar *)chatBar cancel:(BOOL)cancel
{
     [self.recorderIndicatorView setStatus:cancel ? RecorderStatusWillCancel : RecorderStatusRecording];
}

//取消录音
- (void)chatBarDidCancelRecording:(ChatBar *)chatBar
{
    //取消时，拿掉
    [self.recorderIndicatorView removeFromSuperview];
    
    [self.iFlySpeechRecognizer cancel];

    isRecordCancel = YES;
    isNewRecord = YES;

}

- (void)chatBarFinishedRecoding:(ChatBar *)chatBar
{
    [self.recorderIndicatorView removeFromSuperview];
    
    [self.iFlySpeechRecognizer stopListening];
}

#pragma mark -- IFlySpeechRecognizerDelegate 协议实现

//识别结果返回代理
- (void) onResults:(NSArray *) results isLast:(BOOL)isLast
{
    NSMutableString *resultString = [[NSMutableString alloc] init];
    NSDictionary *dic = results[0];
    for (NSString *key in dic) {
        [resultString appendFormat:@"%@",key];
    }
    
    NSString *resultFromJson =  [ISRDataHelper stringFromJson:resultString];

    NSLog(@"resultFromJson=%@",resultFromJson);

    if (isLast){
        NSLog(@"听写结果(json)：%@",  resultFromJson);
    }
    
    if (self.resultText != nil && !isRecordCancel  && ![EcoCommonFunc isBlankString:resultFromJson]) {
        if (isNewRecord  ) {
            self.resultText = [NSMutableString stringWithString:resultFromJson];
            [self sendMessageText:self.resultText messageType:MessageTypeVoiceText];
            isNewRecord = NO;
        }
        else{
            [self.resultText appendString:resultFromJson];
            [self updateMessageText:self.resultText];
        }
    }
    
    
}

//识别结果返回代理
- (void) onError:(IFlySpeechError *) error
{
    NSLog(@"%s",__func__);
}
//停止录音回调
- (void) onEndOfSpeech
{
    NSLog(@"%s",__func__);
    isNewRecord = YES;
}
//开始录音回调
- (void) onBeginOfSpeech
{
     NSLog(@"onBeginOfSpeech");
}

/**
 音量回调函数
 volume 0－30
 ****/
- (void) onVolumeChanged: (int)volume
{
    NSLog(@"%s",__func__);
    NSLog(@"volume:%d",volume);

    [self.recorderIndicatorView setVolume:volume/30.0f];
    

}

//会话取消回调
- (void) onCancel
{
    NSLog(@"%s",__func__);
}

//发送文本
- (void)sendTextViewText:(NSString *)text
{
    [self sendMessageText:text messageType:MessageTypeText];
}

- (void)sendMessageText:(NSString *)text messageType:(MessageType) messageType
{
    self.sendMessage.messageText  = text;
    self.sendMessage.messageType  = messageType;
    self.sendMessage.sendDate = [NSDate date];
    
    BOOL result =  [[EcoMessageManager sharedMessageManager]  saveEcoMessage:self.sendMessage];
    if (result) {
        //赋值然后刷新
        [self setMessageData];
        [self.messageDisplayView reloadData];

        ///加入解析功能
        Command  *command = [[Command alloc]init];
        
        BOOL  success = [command startRecognise:self.sendMessage.messageText];
        if (success) {
            
            EcoMessage *robotMessage = [[EcoMessage alloc]init];
            robotMessage.ownerTyper = MessageOwnerTypeRobot;
            robotMessage.messageType = MessagetTypeLinkText;
            robotMessage.messageText = @"请自行百度";
            robotMessage.sendDate = [NSDate date];
            
            [[EcoMessageManager sharedMessageManager]  saveEcoMessage:robotMessage];
            
            [self setMessageData];
            [self.messageDisplayView reloadData];
        
        }
        
       
        if (messageType == MessageTypeText) {
            self.sendMessage = nil;
        }
    
    }
}

- (void)updateMessageText:(NSString *)text
{
    [[EcoMessageManager sharedMessageManager] updateEcoMessageByID:self.sendMessage.messageID messageText:self.resultText];
    [self.messageDisplayView reloadData];
    [self.messageDisplayView  scrollToBottomWithAnimation:YES];
}

@end
