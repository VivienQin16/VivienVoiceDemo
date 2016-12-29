//
//  EcoCommonFunc.h
//  VivienVoiceDemo
//
//  Created by Vivien on 2016/12/26.
//  Copyright © 2016年 Vivien. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EcoCommonFunc : NSObject

//生成num位随机字符串
+ (NSString*)getRandomStringWithNum:(int)num;

//iOS开发中判断字符串是否为空字符的方法
+ (BOOL) isBlankString:(NSString *)string;

@end
