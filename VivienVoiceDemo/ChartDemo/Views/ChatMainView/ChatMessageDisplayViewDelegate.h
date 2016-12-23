//
//  ChatMessageDisplayViewDelegate.h
//  VivienVoiceDemo
//
//  Created by Vivien on 2016/12/21.
//  Copyright © 2016年 Vivien. All rights reserved.
//

@class ChatMessageDisplayView;
@protocol ChatMessageDisplayViewDelegate <NSObject>

/**
 *  聊天界面点击事件，用于收键盘
 */
- (void)chatMessageDisplayViewDidTouched:(ChatMessageDisplayView *)chatTVC;

@end
