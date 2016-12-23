//
//  ChatBar.m
//  VivienVoiceDemo
//
//  Created by Vivien on 2016/12/20.
//  Copyright © 2016年 Vivien. All rights reserved.
//

#import "ChatBar.h"
#import "TalkButton.h"
@interface ChatBar () <UITextViewDelegate>
{
    
}

@property (nonatomic, strong) UIButton *voiceButton;

@property (nonatomic, strong) UITextView *textView;
///更多按钮
@property (nonatomic, strong) UIButton *moreButton;

@property (nonatomic, strong) TalkButton *talkButton;

@end


@implementation ChatBar

#pragma mark - # init UI
- (void)initSubviews
{
    [self addSubview:self.voiceButton];
    [self addSubview:self.textView];
    [self addSubview:self.moreButton];
    [self addSubview:self.talkButton];
    
    self.status = EcoChatBarStatusInit;
    [self setBackgroundColor:[UIColor greenColor]];
}

- (void)setSubviewsLayout
{
    [self.voiceButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self).mas_offset(-7);
        make.left.mas_equalTo(self.mas_left).mas_offset(1);
        make.width.mas_equalTo(38);
    }];
    
    
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self).mas_offset(7);
        make.bottom.mas_equalTo(self).mas_offset(-7);
        make.left.mas_equalTo(self.voiceButton.mas_right).mas_offset(4);
        make.right.mas_equalTo(self.moreButton.mas_left).mas_offset(-4);
        make.height.mas_equalTo(HEIGHT_CHATBAR_TEXTVIEW);
    }];
    
    [self.talkButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self.textView);
        make.size.mas_equalTo(self.textView);
    }];
    
    [self.moreButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.width.mas_equalTo(self.voiceButton);
        make.right.mas_equalTo(self).mas_offset(-1);
    }];
    

}

#pragma mark - # Delegate 实现
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    if(self.status != EcoChatBarStatusKeyboard)
    {
        if (_delegate && [_delegate respondsToSelector:@selector(changeStatusFrom:to:)]) {
            [self.delegate changeStatusFrom:self.status to:EcoChatBarStatusKeyboard];
        }
        
    }
    
    
    
    return YES;
}


- (BOOL)resignFirstResponder
{
//    [self.moreButton setImage:kMoreImage imageHL:kMoreImageHL];
//    [self.emojiButton setImage:kEmojiImage imageHL:kEmojiImageHL];
//    if (self.status == TLChatBarStatusKeyboard) {
        [self.textView resignFirstResponder];
        self.status = EcoChatBarStatusInit;
//        if (self.delegate && [self.delegate respondsToSelector:@selector(chatBar:changeStatusFrom:to:)]) {
//            [self.delegate chatBar:self changeStatusFrom:self.status to:TLChatBarStatusInit];
//        }
//    }
    
    return [super resignFirstResponder];
}

- (void)moreButtonDown
{
    [self.textView resignFirstResponder];
    
    if (_delegate && [_delegate respondsToSelector:@selector(changeStatusFrom:to:)]) {
        [self.delegate changeStatusFrom:self.status to:EcoChatBarStatusMore];
    }
    self.status = EcoChatBarStatusMore;
    
}


- (void)voiceButtonDown
{
    if (self.status == EcoChatBarStatusVoice) {
        
        [self.textView becomeFirstResponder];
        [self.talkButton setHidden:YES];
        [self.textView setHidden:NO];

        [self.voiceButton setImage:[UIImage imageNamed:@"ToolViewInputVoice"] forState:UIControlStateNormal];
        [self.voiceButton setImage:[UIImage imageNamed:@"ToolViewInputVoiceHL"] forState:UIControlStateHighlighted];
        
        self.status = EcoChatBarStatusKeyboard;
    }
    else
    {
        
        [self.textView resignFirstResponder];
        
        if (_delegate && [_delegate respondsToSelector:@selector(changeStatusFrom:to:)]) {
            [self.delegate changeStatusFrom:self.status to:EcoChatBarStatusVoice];
        }
    
        [self.talkButton setHidden:NO];
        [self.textView setHidden:YES];
        [self.voiceButton setImage:[UIImage imageNamed:@"ToolViewKeyboard"] forState:UIControlStateNormal];
        [self.voiceButton setImage:[UIImage imageNamed:@"ToolViewKeyboardHL"] forState:UIControlStateHighlighted];
        self.status = EcoChatBarStatusVoice;
    }
}



#pragma mark - # Gettter  Subviews
- (UIButton *)voiceButton
{
    if (_voiceButton == nil) {
        _voiceButton = [[UIButton alloc] init];
        [_voiceButton setImage:[UIImage imageNamed:@"ToolViewInputVoice"] forState:UIControlStateNormal];
        [_voiceButton setImage:[UIImage imageNamed:@"ToolViewInputVoiceHL"] forState:UIControlStateHighlighted];
        [_voiceButton addTarget:self action:@selector(voiceButtonDown) forControlEvents:UIControlEventTouchUpInside];
    }
    return _voiceButton;
}

- (TalkButton *)talkButton
{
    if (_talkButton == nil) {
        _talkButton = [[TalkButton alloc] init];
       // _talkButton.backgroundColor = [UIColor greenColor];
        [_talkButton setHidden:YES];
        
        __weak typeof(self) weakSelf = self;
        _talkButton.touchBegin = ^()
        {
            if (weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(chatBarStartRecording:)]) {
                [weakSelf.delegate chatBarStartRecording:weakSelf];
            }
        };
        _talkButton.touchEnd = ^()
        {
            if (weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(chatBarFinishedRecoding:)]) {
                [weakSelf.delegate chatBarFinishedRecoding:weakSelf];
            }
        
        };
        _talkButton.touchCancel = ^()
        {
            if (weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(chatBarDidCancelRecording:)]) {
                [weakSelf.delegate chatBarDidCancelRecording:weakSelf];
            }
        };
        _talkButton.touchMove = ^(BOOL cancel)
        {
            if (weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(chatBarWillCancelRecording:cancel:)]) {
                [weakSelf.delegate chatBarWillCancelRecording:weakSelf cancel:cancel];
            }
        };
        
//        [_talkButton setTouchBeginAction:^{
//            if (weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(chatBarStartRecording:)]) {
//                [weakSelf.delegate chatBarStartRecording:weakSelf];
//            }
//        } willTouchCancelAction:^(BOOL cancel) {
//            if (weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(chatBarWillCancelRecording:cancel:)]) {
//                [weakSelf.delegate chatBarWillCancelRecording:weakSelf cancel:cancel];
//            }
//        } touchEndAction:^{
//            if (weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(chatBarFinishedRecoding:)]) {
//                [weakSelf.delegate chatBarFinishedRecoding:weakSelf];
//            }
//        } touchCancelAction:^{
//            if (weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(chatBarDidCancelRecording:)]) {
//                [weakSelf.delegate chatBarDidCancelRecording:weakSelf];
//            }
//        }];
    }
    return _talkButton;
}


/// 文本输入框
- (UITextView *)textView
{
    if (_textView == nil) {
        _textView = [[UITextView alloc] init];
        _textView.backgroundColor = [UIColor redColor];//vivien delete
        [_textView setFont:[UIFont systemFontOfSize:16.0f]];
        [_textView setReturnKeyType:UIReturnKeySend];
        [_textView.layer setMasksToBounds:YES];
        [_textView.layer setBorderWidth:BORDER_WIDTH_1PX];
        [_textView.layer setBorderColor:[UIColor colorWithWhite:0.0 alpha:0.3].CGColor];
        [_textView.layer setCornerRadius:4.0f];
        [_textView setDelegate:self];
        [_textView setScrollsToTop:NO];
    }
    return _textView;
}

/// 更多按钮
- (UIButton *)moreButton
{
    if (_moreButton == nil) {
        _moreButton = [[UIButton alloc] init];
        [_moreButton setImage:[UIImage imageNamed:@"TypeSelectorBtn_Black"] forState:UIControlStateNormal];
        [_moreButton setImage:[UIImage imageNamed:@"TypeSelectorBtnHL_Black"] forState:UIControlStateHighlighted];
        [_moreButton addTarget:self action:@selector(moreButtonDown) forControlEvents:UIControlEventTouchUpInside];
    }
    return _moreButton;
}
@end
