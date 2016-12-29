//
//  EcoMessageManager.m
//  VivienVoiceDemo
//
//  Created by Vivien on 2016/12/23.
//  Copyright © 2016年 Vivien. All rights reserved.
//

#import "EcoMessageManager.h"

@implementation EcoMessageManager

+ (EcoMessageManager *)sharedMessageManager{
    static EcoMessageManager *sharedMessageManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMessageManager = [[self alloc] init];
        [sharedMessageManager setup];
    });
    return sharedMessageManager;
}

- (void)setup
{
    _dbHelper =  [[EcoMessageDBHelper alloc]init];
}

- (NSMutableArray *)getMessageList
{
    _resultArray = [_dbHelper   getMessageList];
    
    if ([_resultArray count] == 0) {
        NSLog(@"无结果");
        EcoMessage *initMessage = [[EcoMessage alloc]init];
        initMessage.messageType = MessagetTypeAttributedText;
        initMessage.ownerTyper =  MessageOwnerTypeFriend;
        initMessage.messageText = @"小主人，欢迎你";
        
        [_dbHelper saveEcoMessage:initMessage];
        _resultArray = [_dbHelper getMessageList];
    }

    return _resultArray;
    
}

- (BOOL)saveEcoMessage:(EcoMessage *)tempMessage
{
    BOOL result = [_dbHelper saveEcoMessage:tempMessage];
    
    return result;
}

- (BOOL )updateEcoMessageByID:(NSString *)messageID  messageText:(NSString *)text
{
    return [_dbHelper updateEcoMessageByID:messageID messageText:text];
}



@end
