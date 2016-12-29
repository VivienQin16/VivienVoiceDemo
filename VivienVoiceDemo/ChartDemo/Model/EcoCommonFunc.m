//
//  EcoCommonFunc.m
//  VivienVoiceDemo
//
//  Created by Vivien on 2016/12/26.
//  Copyright © 2016年 Vivien. All rights reserved.
//

#import "EcoCommonFunc.h"

@implementation EcoCommonFunc


//生成num位随机字符串
+ (NSString*)getRandomStringWithNum:(int)num
{
    int NUMBER_OF_CHARS = num;//10;
    char data[NUMBER_OF_CHARS];
    for (int x=0;x<NUMBER_OF_CHARS;data[x++] = (char)('A' + (arc4random_uniform(26))));
    
    NSString *str = [[NSString alloc] initWithBytes:data length:NUMBER_OF_CHARS encoding:NSUTF8StringEncoding];
    return str;
}


//iOS开发中判断字符串是否为空字符的方法
+ (BOOL) isBlankString:(NSString *)string
{
    if (string == nil || string == NULL)
    {
        return YES;
    }
    if ([string isKindOfClass:[NSNull class]])
    {
        return YES;
    }
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0)
    {
        return YES;
    }
    if ([string isEqualToString:@"null"] || [string isEqualToString:@"(null)"]) {
        return YES;
    }
    if ([string isEqualToString:@""]) {
        return YES;
    }
    return NO;
}

@end
