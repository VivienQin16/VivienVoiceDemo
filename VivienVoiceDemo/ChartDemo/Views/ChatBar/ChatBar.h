//
//  ChatBar.h
//  VivienVoiceDemo
//
//  Created by Vivien on 2016/12/20.
//  Copyright © 2016年 Vivien. All rights reserved.
//

#import "ChatBaseView.h"
#import "ChatBarDelegate.h"

@interface ChatBar : ChatBaseView
{
    NSString *textRec; //存储textview Text
}

@property (nonatomic, assign) EcoChatBarStatus status;

@property (nonatomic, assign) id<ChatBarDelegate> delegate;

- (BOOL)resignFirstResponder;


@end
