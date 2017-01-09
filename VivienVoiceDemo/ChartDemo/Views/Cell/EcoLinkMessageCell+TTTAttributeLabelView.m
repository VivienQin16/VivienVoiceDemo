//
//  EcoLinkMessageCell+TTTAttributeLabelView.m
//  VivienVoiceDemo
//
//  Created by Vivien on 2017/1/9.
//  Copyright © 2017年 Vivien. All rights reserved.
//

#import "EcoLinkMessageCell+TTTAttributeLabelView.h"
#import "TTTAttributeLabelView.h"
@implementation EcoLinkMessageCell (TTTAttributeLabelView)


- (void)TTTAttributeLabelView:(TTTAttributeLabelView *)attributeLabelView linkFlag:(NSString *)flag {
    NSLog(@"%@", flag);

}


@end
