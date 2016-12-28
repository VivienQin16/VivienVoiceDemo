//
//  EcoMessage.m
//  VivienVoiceDemo
//
//  Created by Vivien on 2016/12/22.
//  Copyright © 2016年 Vivien. All rights reserved.
//

#import "EcoMessage.h"

@implementation EcoMessage


- (instancetype)init
{
    if (self = [super init])
    {
        _messageID = [EcoCommonFunc getRandomStringWithNum:10];
        _messageType = MessageTypeText; //默认类型为文本;
    }
    return self;
}

+ (NSString *)getPrimaryKey
{
    return @"messageID";
}

+ (NSString *)getTableName
{
    return @"DR935Message";
}

@end
