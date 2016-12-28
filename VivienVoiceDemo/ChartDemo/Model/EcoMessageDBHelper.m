//
//  EcoMessageDBHelper.m
//  VivienVoiceDemo
//
//  Created by Vivien on 2016/12/26.
//  Copyright © 2016年 Vivien. All rights reserved.
//

#import "EcoMessageDBHelper.h"

@interface EcoMessageDBHelper()
{
    LKDBHelper *globalHelper;
}
@end

@implementation EcoMessageDBHelper

+ (LKDBHelper *)getUsingLKDBHelper
{
    static LKDBHelper *db;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        NSString *dbpath = [documentsDirectory stringByAppendingPathComponent:@"message.sqlite"];
        db = [[LKDBHelper alloc]initWithDBPath:dbpath];
        NSLog(@"数据库所在路径：%@", dbpath);
    });
    return db;
}


- (void)getLKDBHelper
{
    if (!globalHelper)
    {
        globalHelper = [EcoMessageDBHelper getUsingLKDBHelper];
    }
}


//获取MessageList
- (NSMutableArray *)getMessageList
{
    [self getLKDBHelper];
    NSMutableArray *searchResultArray = [globalHelper searchWithSQL:@"select * from @t" toClass:[EcoMessage class]];
    for (id obj in searchResultArray)
    {
        NSLog(@"getWarnList%@",[obj printAllPropertys]);
    }
    return  searchResultArray;
}

//存储会话消息
- (BOOL)saveEcoMessage:(EcoMessage *)tempMessage
{
    [self getLKDBHelper];
    BOOL success = false;
    //重复的告警信息不存储
    //    NSMutableArray *searchResultArray = [self getWarnListWithType:warnInfo.deviceType anbotJID:warnInfo.guanjiaJID];
    //    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"timeSecondsSince1970 == %lld", warnInfo.timeSecondsSince1970];
    //    NSArray *timeSameArray = [searchResultArray filteredArrayUsingPredicate:predicate];
    //    if ( !timeSameArray || [timeSameArray count] == 0) {
    success = [globalHelper insertToDB:tempMessage];
    //    }
    return success;
}


@end
