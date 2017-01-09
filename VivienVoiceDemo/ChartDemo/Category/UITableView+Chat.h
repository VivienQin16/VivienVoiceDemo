//
//  UITableView+TLChat.h
//  VivienVoiceDemo
//
//  Created by Vivien on 2016/12/15.
//  Copyright © 2016年 Vivien. All rights reserved.
//

#import <UIKit/UIKit.h>

#define     HEIGHT_NAVBAR               44.0f
#define     HEIGHT_STATUSBAR            20.0f

@interface UITableView (Chat)

- (void)scrollToBottomWithAnimation:(BOOL)animation;

@end
