//
//  EcoMessage.h
//  VivienVoiceDemo
//
//  Created by Vivien on 2016/12/22.
//  Copyright © 2016年 Vivien. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef NS_ENUM(NSInteger, MessageOwnerType){
//    MessageOwnerTypeUnknown,  // 未知的消息拥有者
//    MessageOwnerTypeSystem,   // 系统消息
    MessageOwnerTypeSelf,     // 自己发送的消息
    MessageOwnerTypeFriend,   // 接收到的他人消息
};

typedef NS_ENUM(NSInteger, MessageType) {
    MessageTypeUnknown,
    MessageTypeText,          // 文字
    MessagetTypeAttributedText, //富文本
//    MessageTypeImage,         // 图片
//    MessageTypeExpression,    // 表情
    MessageTypeVoice,         // 语音
//    MessageTypeVideo,         // 视频
//    MessageTypeURL,           // 链接
//    MessageTypePosition,      // 位置
//    MessageTypeBusinessCard,  // 名片
//    MessageTypeSystem,        // 系统
//    MessageTypeOther,
};

@interface EcoMessage : NSObject

@property (nonatomic, strong) NSString *messageID;                  // 消息ID
//@property (nonatomic, strong) NSString *userID;                     // 发送者ID
@property (nonatomic, assign) MessageOwnerType ownerTyper;        // 发送者类型
@property (nonatomic, assign) MessageType messageType;        // 消息发送类型
@property (nonatomic, strong) NSString *messageText;            //消息发送内容

@end
