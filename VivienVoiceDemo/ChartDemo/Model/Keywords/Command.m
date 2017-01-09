//
//  Command.m
//  VivienVoiceDemo
//
//  Created by Vivien on 2017/1/9.
//  Copyright © 2017年 Vivien. All rights reserved.
//

#import "Command.h"

@implementation Command


- (instancetype)init
{
    self = [super init];
    if (self)
    {
    }
    return self;
}


- (BOOL)startRecognise:(NSString *)str
{
    BOOL success = NO;
    
    NSLog(@"Command String:%@",str);
    
    NSMutableString *statementStr = [NSMutableString stringWithString:[str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]]];
    
    if ([statementStr length] <= 0) {
        return success;
    }
    
    if ([statementStr containsString:@"百度"]) {
        success = YES ;
    }
    
    
    return success;
}

@end
