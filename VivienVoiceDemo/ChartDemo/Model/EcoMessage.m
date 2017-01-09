//
//  EcoMessage.m
//  VivienVoiceDemo
//
//  Created by Vivien on 2016/12/22.
//  Copyright © 2016年 Vivien. All rights reserved.
//

#import "EcoMessage.h"

static UILabel *textLabel = nil;
@implementation EcoMessage


- (instancetype)init
{
    if (self = [super init])
    {
        _messageID = [EcoCommonFunc getRandomStringWithNum:10];
        _messageType = MessageTypeText; //默认类型为文本;
        
        if (textLabel == nil) {
            textLabel = [[UILabel alloc] init];
            [textLabel setFont:[UIFont systemFontOfSize:16]];
            [textLabel setNumberOfLines:0];
        }
    }
    return self;
}


- (EcoMessageFrame *)messageFrame
{
    if (kMessageFrame == nil) {
        kMessageFrame = [[EcoMessageFrame alloc] init];
        kMessageFrame.height = 20 + 20;   //20 + (self.showTime ? 30 : 0) + (self.showName ? 15 : 0) + 20;
//        [textLabel setAttributedText:self.attrText];
        [textLabel setText:_messageText];
        kMessageFrame.contentSize = [textLabel sizeThatFits:CGSizeMake(MAX_MESSAGE_WIDTH, MAXFLOAT)];
        kMessageFrame.height += kMessageFrame.contentSize.height;
    }
    return kMessageFrame;
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
