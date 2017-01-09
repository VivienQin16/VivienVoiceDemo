//
//  EcoMessageDBHelper.h
//  VivienVoiceDemo
//
//  Created by Vivien on 2016/12/26.
//  Copyright © 2016年 Vivien. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LKDBHelper.h"
#import "EcoMessage.h"

@interface EcoMessageDBHelper : NSObject

///保存Eco消息
- (BOOL)saveEcoMessage:(EcoMessage *)tempMessage;

//获取MessageList
- (NSMutableArray *)getMessageList;

- (BOOL )updateEcoMessageByID:(NSString *)messageID  messageText:(NSString *)text;

@end
