//
//  TalkButton.h
//  VivienVoiceDemo
//
//  Created by Vivien on 2016/12/21.
//  Copyright © 2016年 Vivien. All rights reserved.
//

#import "ChatBaseView.h"

@interface TalkButton : ChatBaseView

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) void (^touchBegin)();
@property (nonatomic, strong) void (^touchMove)(BOOL cancel);
@property (nonatomic, strong) void (^touchCancel)();
@property (nonatomic, strong) void (^touchEnd)();

@end
