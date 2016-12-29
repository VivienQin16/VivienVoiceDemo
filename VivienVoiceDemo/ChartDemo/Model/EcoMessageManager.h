//
//  EcoMessageManager.h
//  VivienVoiceDemo
//
//  Created by Vivien on 2016/12/23.
//  Copyright © 2016年 Vivien. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EcoMessageDBHelper.h"
#import "EcoMessage.h"
@interface EcoMessageManager : NSObject

@property (nonatomic, strong)EcoMessageDBHelper *dbHelper;
@property (nonatomic, strong)NSMutableArray *resultArray;

+ (EcoMessageManager *)sharedMessageManager;

- (NSMutableArray *)getMessageList;

- (BOOL)saveEcoMessage:(EcoMessage *)tempMessage;

- (BOOL )updateEcoMessageByID:(NSString *)messageID  messageText:(NSString *)text;



@end
