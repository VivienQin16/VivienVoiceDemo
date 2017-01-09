//
//  EcoMessage.h
//  VivienVoiceDemo
//
//  Created by Vivien on 2016/12/22.
//  Copyright © 2016年 Vivien. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EcoMessageFrame.h"

typedef NS_ENUM(NSInteger, MessageOwnerType){
    MessageOwnerTypeUser,     // 用户自己发送的消息
    MessageOwnerTypeRobot,   // 聊天机器人发的
};

typedef NS_ENUM(NSInteger, MessageType) {
    MessageTypeUnknown,
    MessageTypeText,          // 文字
    MessagetTypeLinkText, //富文本,点击操作
    MessageTypeVoiceText,         // 语音文本
};

@interface EcoMessage : NSObject
{
    CGSize fitSize;

    EcoMessageFrame *kMessageFrame;


}

@property (nonatomic, strong) NSString *messageID;                 // 消息ID
//@property (nonatomic, strong) NSString *userID;                  // 发送者ID
@property (nonatomic, assign) MessageOwnerType ownerTyper;        // 发送者类型
@property (nonatomic, assign) MessageType messageType;        // 消息发送类型
@property (nonatomic, strong) NSString *messageText;            //消息发送内容
@property (nonatomic, strong) NSDate *sendDate;            //消息发送时间

- (EcoMessageFrame *)messageFrame;

@end
