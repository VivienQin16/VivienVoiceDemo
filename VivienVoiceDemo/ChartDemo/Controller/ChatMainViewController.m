//
//  ChatMainViewController.m
//  VivienVoiceDemo
//
//  Created by Vivien on 2016/12/12.
//  Copyright © 2016年 Vivien. All rights reserved.
//

#import "ChatMainViewController.h"
#import "ChatBar.h"
#import "ChatMainViewController+ChatBar.h"
#import "EcoMessageManager.h"
@interface ChatMainViewController ()


@end
#define kChatTableViewControllerCellId @"ChatTableViewController"
@implementation ChatMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"科大讯飞";
    lastStatus = curStatus = EcoChatBarStatusInit;
    
    _resultText = [[NSMutableString alloc]init];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)initSubviews
{
    [self.view addSubview:self.messageDisplayView];
    [self.view addSubview:self.chatBar];
}

- (void)setSubviewsLayout
{
    [self.messageDisplayView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.left.and.right.mas_equalTo(self.view);
        make.bottom.mas_equalTo(self.chatBar.mas_top);
    }];
    [self.chatBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.and.bottom.mas_equalTo(self.view);
        make.height.mas_greaterThanOrEqualTo(HEIGHT_TABBAR);
    }];
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardFrameWillChange:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
    [self setMessageData];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)setMessageData
{
    self.dataArray = [[EcoMessageManager sharedMessageManager] getMessageList];
    
    self.messageDisplayView.dataArr = self.dataArray;
}

- (void)layoutSubviews
{
//    [self.view layoutSubviews];
//    [self setSubviewsLayout];
}

- (NSMutableArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = [NSMutableArray new];
    }
    return _dataArray;
}

#pragma mark - # Getter
- (ChatMessageDisplayView *)messageDisplayView
{
    if (_messageDisplayView == nil) {
        _messageDisplayView = [[ChatMessageDisplayView alloc] init];
        [_messageDisplayView setDelegate:self];
    }
    return _messageDisplayView;
}

//底下的聊天框
- (ChatBar *)chatBar
{
    if (_chatBar == nil) {
        _chatBar = [[ChatBar alloc] init];
        [_chatBar setDelegate:self];
    }
    return _chatBar;
}

/// 更多键盘
- (KeyboardMoreView *)moreKeyboard
{
    if (_moreKeyboard == nil) {
        _moreKeyboard = [[KeyboardMoreView alloc]init];
//        [self.view addSubview:_moreKeyboard];
    }
    return _moreKeyboard;
}

- (RecorderIndicatorView *)recorderIndicatorView
{
    if (_recorderIndicatorView == nil) {
        _recorderIndicatorView = [[RecorderIndicatorView alloc] init];
    }
    return _recorderIndicatorView;
}

///科大讯飞语音识别
- (IFlySpeechRecognizer *) iFlySpeechRecognizer
{
    if (_iFlySpeechRecognizer == nil) {
        _iFlySpeechRecognizer = [IFlySpeechRecognizer sharedInstance];
        [_iFlySpeechRecognizer setParameter:@"" forKey:[IFlySpeechConstant PARAMS]];
        
        //设置听写模式
        [_iFlySpeechRecognizer setParameter:@"iat" forKey:[IFlySpeechConstant IFLY_DOMAIN]];
        [_iFlySpeechRecognizer setParameter:@"iat.pcm" forKey:[IFlySpeechConstant
                                                                   ASR_AUDIO_PATH]];
        _iFlySpeechRecognizer.delegate = self;
    }
    return _iFlySpeechRecognizer;
}
//用户的语音或文本Message
- (EcoMessage *)sendMessage
{
    if(_sendMessage == nil)
    {
        _sendMessage = [[EcoMessage alloc]init];
        _sendMessage.ownerTyper = MessageOwnerTypeSelf;
        _sendMessage.messageType = MessageTypeText;
    }
    return _sendMessage;
}

@end
