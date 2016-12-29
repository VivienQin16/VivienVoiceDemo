//
//  ChatMainViewController+ChatBar.h
//  VivienVoiceDemo
//
//  Created by Vivien on 2016/12/21.
//  Copyright © 2016年 Vivien. All rights reserved.
//

#import "ChatMainViewController.h"

@interface ChatMainViewController (ChatBar)<ChatBarDelegate,ChatMessageDisplayViewDelegate,IFlySpeechRecognizerDelegate>

- (void)keyboardWillShow:(NSNotification *)notification;
- (void)keyboardDidShow:(NSNotification *)notification;
- (void)keyboardWillHide:(NSNotification *)notification;
- (void)keyboardFrameWillChange:(NSNotification *)notification;

@end
