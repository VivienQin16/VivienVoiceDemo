//
//  EcoLinkMessageCell.m
//  VivienVoiceDemo
//
//  Created by Vivien on 2017/1/9.
//  Copyright © 2017年 Vivien. All rights reserved.
//

#import "EcoLinkMessageCell.h"
#import  "TTTAttributedLabel.h"

@interface EcoLinkMessageCell () <TTTAttributedLabelDelegate>

@property (nonatomic, strong) TTTAttributedLabel  *attributedLabel;

@end


@implementation EcoLinkMessageCell

- (void)initSubviews
{
    [super initSubviews];
    [self.contentView addSubview:self.attributedLabel];
}

- (void)setMessage:(EcoMessage *)message
{
    [super setMessage:message];
    
    self.attributedLabel.linkAttributes       = @{NSForegroundColorAttributeName:[UIColor cyanColor], NSFontAttributeName:[UIFont systemFontOfSize:16.0f]};
    self.attributedLabel.activeLinkAttributes = @{NSForegroundColorAttributeName:[UIColor redColor], NSFontAttributeName:[UIFont systemFontOfSize:16.0f]};

    [self.attributedLabel   setText:message.messageText];
    
    NSRange serviceRange = [message.messageText rangeOfString:@"自行百度"];
    [self.attributedLabel addLinkToURL:[NSURL URLWithString:@"action://show-help"] withRange:serviceRange];
    self.attributedLabel.userInteractionEnabled = YES;

    [self.bubbleImage mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.avatarButton.mas_right).mas_offset(MSG_SPACE_LEFT);
        make.centerY.mas_equalTo(self.contentView);
    }];
    
    [self.attributedLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.bubbleImage).mas_offset(10.0f);
        make.centerY.mas_equalTo(self.bubbleImage);
        make.right.mas_equalTo(self.bubbleImage).mas_offset(-10.0f);
    }];

}



#pragma mark - Getter -

- (TTTAttributedLabel *)attributedLabel
{
    if (_attributedLabel == nil) {
        _attributedLabel = [[TTTAttributedLabel alloc] initWithFrame:CGRectZero];
        _attributedLabel.font = [UIFont systemFontOfSize:16];
        _attributedLabel.lineBreakMode = NSLineBreakByCharWrapping;
        _attributedLabel.numberOfLines = 0;
        _attributedLabel.delegate = self ;
        _attributedLabel.verticalAlignment = TTTAttributedLabelVerticalAlignmentCenter;
        _attributedLabel.enabledTextCheckingTypes = NSTextCheckingTypePhoneNumber|NSTextCheckingTypeAddress|NSTextCheckingTypeLink;
        //链接正常状态文本属性
        _attributedLabel.userInteractionEnabled = YES ;
    }
//    _attributedLabel.delegate = self;

    return _attributedLabel;
}


#pragma mark - Delegate

/// 点击链接的方法
- (void)attributedLabel:(TTTAttributedLabel *)label
   didSelectLinkWithURL:(NSURL *)url
{
    NSLog(@"被点击的url === %@", url);
}

/// 点击长按数据
- (void)attributedLabel:(TTTAttributedLabel *)label
  didSelectLinkWithDate:(NSDate *)date
{
    
}

/// 点击文本链接
- (void)attributedLabel:(TTTAttributedLabel *)label
didSelectLinkWithTextCheckingResult:(NSTextCheckingResult *)result
{
    NSLog(@"被点击的话题 === %@", NSStringFromRange(result.range));
    
}
/// 长按链接的方法
- (void)attributedLabel:(TTTAttributedLabel *)label
didLongPressLinkWithURL:(NSURL *)url
                atPoint:(CGPoint)point
{
    NSLog(@"被长按的url === %@", url);
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"message" delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil, nil];
    alertView.message = @"呵呵呵呵呵";
    [alertView show];
}
/// 可以长按的文本
- (void)attributedLabel:(TTTAttributedLabel *)label
didLongPressLinkWithTextCheckingResult:(NSTextCheckingResult *)result
                atPoint:(CGPoint)point
{
    NSLog(@"被长按的话题 === %@", NSStringFromRange(result.range));
}



@end
