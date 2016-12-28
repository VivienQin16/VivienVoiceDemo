
//
//  UITableView+TLChat.m
//  VivienVoiceDemo
//
//  Created by Vivien on 2016/12/15.
//  Copyright © 2016年 Vivien. All rights reserved.
//

#import "UITableView+Chat.h"

@implementation UITableView (Chat)

- (void)scrollToBottomWithAnimation:(BOOL)animation
{
    CGFloat offsetY = self.contentSize.height > self.height ? self.contentSize.height - self.height : -(HEIGHT_NAVBAR + HEIGHT_STATUSBAR);
    [self setContentOffset:CGPointMake(0, offsetY) animated:animation];
}

@end
