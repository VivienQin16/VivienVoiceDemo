//
//  EcoLinkMessageCell.m
//  VivienVoiceDemo
//
//  Created by Vivien on 2017/1/9.
//  Copyright © 2017年 Vivien. All rights reserved.
//

#import "EcoLinkMessageCell.h"
#import "TTTAttributeLabelView.h"
#import "EcoLinkMessageCell+TTTAttributeLabelView.h"
@interface EcoLinkMessageCell ()

@property (nonatomic, strong) TTTAttributeLabelView  *attributeLabelView;

@end
@implementation EcoLinkMessageCell

- (void)initSubviews
{
    [super initSubviews];
    [self.contentView addSubview:self.attributeLabelView];
    
}

- (void)setMessage:(EcoMessage *)message
{
    [super setMessage:message];
    NSLog(@"setMessage:%@",message.messageText);
    
   self.attributeLabelView.attributedString   = [[NSAttributedString alloc]initWithString:message.messageText];
    
    if (message.ownerTyper == MessageOwnerTypeUser) { 

        [self.bubbleImage mas_remakeConstraints:^(MASConstraintMaker *make) {
            //            make.top.mas_equalTo(self.contentView).mas_equalTo(1.0f);
            make.centerY.mas_equalTo(self.contentView);
            make.right.mas_equalTo(self.avatarButton.mas_left).mas_offset(-MSG_SPACE_LEFT);
            make.left.mas_equalTo(self.attributeLabelView.mas_left).mas_offset(-10.0f);
        }];
        
        [self.attributeLabelView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.bubbleImage);
            make.right.mas_equalTo(self.bubbleImage).mas_offset(-10.0f);
            //            make.top.mas_equalTo(self.bubbleImage).mas_offset(1.0f);
            make.bottom.mas_equalTo(self.bubbleImage).mas_offset(-5.0f); //left.
            //            make.left.mas_equalTo(self.bubbleImage).mas_offset(10.0f);
        }];
        
    }
    else{  //机器人发的
        
        
        [self.bubbleImage mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.avatarButton.mas_right).mas_offset(MSG_SPACE_LEFT);
            make.centerY.mas_equalTo(self.contentView);
            make.right.mas_equalTo(self.attributeLabelView.mas_right).mas_offset(10.0f);
        }];
        
        [self.attributeLabelView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.bubbleImage).mas_offset(10.0f);
            make.centerY.mas_equalTo(self.bubbleImage);
        }];
        
        
        
    }

    
    NSRange range1 = [message.messageText rangeOfString:@"请自行百度"];
    [self.attributeLabelView addLinkStringRange:range1 flag:@"link1"];
    
    [self.attributeLabelView render];
    [self.attributeLabelView resetSize];

    
}








#pragma mark - Getter -
- (TTTAttributeLabelView *)attributeLabelView
{
    if (_attributeLabelView == nil) {
        _attributeLabelView = [[TTTAttributeLabelView alloc] init];
        self.attributeLabelView.delegate           = self;
        _attributeLabelView.linkColor          = [UIColor cyanColor];
    }
    return _attributeLabelView;
}


@end
