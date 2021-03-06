//
//  ChatEnterViewController.m
//  VivienVoiceDemo
//
//  Created by Vivien on 2016/12/12.
//  Copyright © 2016年 Vivien. All rights reserved.
//

#import "ChatEnterViewController.h"
#import "ChatMainViewController.h"
#define APPID_VALUE           @"584a6628"


#import "TTTAttributedLabel.h"

@interface ChatEnterViewController ()<TTTAttributedLabelDelegate>

@end

@implementation ChatEnterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"聊天Demo";
    
    UIButton *enterBtn = [[UIButton alloc]initWithFrame:CGRectMake(50, 100, 100, 30)];
    enterBtn.backgroundColor = [UIColor blueColor];
    [enterBtn setTitle:@"进入聊天" forState:UIControlStateNormal];
    [enterBtn addTarget:self
                         action:@selector(enterBtnClicked)
               forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:enterBtn];
    
    
    
    TTTAttributedLabel *tttLabel = [[TTTAttributedLabel alloc]initWithFrame:CGRectMake(10, 200, 200, 200)];
    tttLabel.delegate = self;
    [self.view addSubview:tttLabel];
    NSString *labelText = @"Lost? Learn more.";
    tttLabel.text = labelText;
    NSRange r = [labelText rangeOfString:@"Learn more"];
    [tttLabel addLinkToURL:[NSURL URLWithString:@"action://show-help"] withRange:r];

    

    
}

- (void)viewWillAppear:(BOOL)animated
{
    
    //创建语音配置,appid必须要传入，仅执行一次则可
    NSString *initString = [[NSString alloc] initWithFormat:@"appid=%@",APPID_VALUE];
    
    //所有服务启动前，需要确保执行createUtility
    [IFlySpeechUtility createUtility:initString];
}

    
- (void)enterBtnClicked
{
    ChatMainViewController *ChatVC =  [[ChatMainViewController alloc]init];
    [self.navigationController pushViewController:ChatVC animated:NO];
}
    
    
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)attributedLabel:(TTTAttributedLabel *)label didSelectLinkWithURL:(NSURL *)url {
    NSLog(@"Did click");
}



@end
