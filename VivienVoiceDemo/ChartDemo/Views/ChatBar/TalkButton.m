//
//  TalkButton.m
//  VivienVoiceDemo
//
//  Created by Vivien on 2016/12/21.
//  Copyright © 2016年 Vivien. All rights reserved.
//

#import "TalkButton.h"

@implementation TalkButton


- (void)initSubviews
{
    [self.layer setMasksToBounds:YES];
    [self.layer setCornerRadius:4.0f];
    [self.layer setBorderWidth:BORDER_WIDTH_1PX];
    [self.layer setBorderColor:[UIColor colorWithWhite:0.0 alpha:0.3].CGColor];
    
    [self addSubview:self.titleLabel];
}

- (void)setSubviewsLayout
{
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self);
    }];
}


#pragma mark - # Public Methods
- (void)setTouchBeginAction:(void (^)())touchBegin willTouchCancelAction:(void (^)(BOOL))willTouchCancel touchEndAction:(void (^)())touchEnd touchCancelAction:(void (^)())touchCancel
{
    self.touchBegin = touchBegin;
    self.touchMove = willTouchCancel;
    self.touchCancel= touchCancel;
    self.touchEnd = touchEnd;
}

#pragma mark - # Event Response
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self setBackgroundColor:[UIColor colorWithWhite:0.0 alpha:0.1]];
    [self.titleLabel setText:@"松开 结束"];
    if (self.touchBegin) {
        self.touchBegin();
    }
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if (self.touchMove) {
        CGPoint curPoint = [[touches anyObject] locationInView:self];
        BOOL moveIn = curPoint.x >= 0 && curPoint.x <= self.width && curPoint.y >= 0 && curPoint.y <= self.height;
        [self.titleLabel setText:(moveIn ? @"松开 结束" : @"松开 取消")];
        self.touchMove(!moveIn);
    }
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self setBackgroundColor:[UIColor clearColor]];
    [self.titleLabel setText:@"按住 说话"];
    CGPoint curPoint = [[touches anyObject] locationInView:self];
    BOOL moveIn = curPoint.x >= 0 && curPoint.x <= self.width && curPoint.y >= 0 && curPoint.y <= self.height;
    if (moveIn && self.touchEnd) {
        self.touchEnd();
    }
    else if (!moveIn && self.touchCancel) {
        self.touchCancel();
    }
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self setBackgroundColor:[UIColor clearColor]];
    [self.titleLabel setText:@"按住 说话"];
    if (self.touchCancel) {
        self.touchCancel();
    }
}


#pragma mark - # Getter
- (UILabel *)titleLabel
{
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] init];
        [_titleLabel setFont:[UIFont boldSystemFontOfSize:16.0f]];
        [_titleLabel setTextColor:[UIColor colorWithRed:0.3 green:0.3 blue:0.3 alpha:1.0]];
        [_titleLabel setTextAlignment:NSTextAlignmentCenter];
        [_titleLabel setText:@"按住 说话"];
    }
    return _titleLabel;
}

@end
