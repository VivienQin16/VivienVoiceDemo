//
//  EcoMessageCell+TTTAttributedLabel.m
//  VivienVoiceDemo
//
//  Created by Vivien on 2017/1/4.
//  Copyright © 2017年 Vivien. All rights reserved.
//

#import "EcoMessageCell+TTTAttributedLabel.h"

@implementation EcoMessageCell (TTTAttributedLabel)

//
//- (void)attributedLabel:(TTTAttributedLabel *)label
//   didSelectLinkWithURL:(NSURL *)url{
//    //这里可以对点击的url进行操作
//}



- (void)TTTAttributeLabelView:(TTTAttributeLabelView *)attributeLabelView linkFlag:(NSString *)flag {
    
    NSLog(@"%@", flag);
}

@end
