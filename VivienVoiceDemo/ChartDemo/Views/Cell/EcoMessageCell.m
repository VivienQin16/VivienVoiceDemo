//
//  EcoMessageCell.m
//  VivienVoiceDemo
//
//  Created by Vivien on 2016/12/15.
//  Copyright © 2016年 Vivien. All rights reserved.
//

#import "EcoMessageCell.h"

@interface EcoMessageCell ()

@property (nonatomic, strong) UILabel *messageLabel;

@end

@implementation EcoMessageCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}


- (void)initSubviews
{
    [super initSubviews];
    [self.contentView addSubview:self.messageLabel];
}

- (void)setMessage:(EcoMessage *)message
{
    [super setMessage:message];
    NSLog(@"setMessage:%@",message.messageText);
    
    [_messageLabel  setText:message.messageText];

    if (message.ownerTyper == MessageOwnerTypeUser) {  //用户发的

        [self.messageLabel setTextAlignment: NSTextAlignmentRight];
        
        [self.bubbleImage mas_remakeConstraints:^(MASConstraintMaker *make) {
//            make.top.mas_equalTo(self.contentView).mas_equalTo(1.0f);
            make.centerY.mas_equalTo(self.contentView);
            make.right.mas_equalTo(self.avatarButton.mas_left).mas_offset(-MSG_SPACE_LEFT);
            make.left.mas_equalTo(self.messageLabel.mas_left).mas_offset(-10.0f);
        }];
        
        [self.messageLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
             make.centerY.mas_equalTo(self.bubbleImage);
             make.right.mas_equalTo(self.bubbleImage).mas_offset(-10.0f);
//            make.top.mas_equalTo(self.bubbleImage).mas_offset(1.0f);
            make.bottom.mas_equalTo(self.bubbleImage).mas_offset(-5.0f); //left.
//            make.left.mas_equalTo(self.bubbleImage).mas_offset(10.0f);
        }];
        
    }
    else{  //机器人发的
        
        [self.messageLabel setTextAlignment: NSTextAlignmentLeft];
        
        [self.bubbleImage mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.avatarButton.mas_right).mas_offset(MSG_SPACE_LEFT);
            make.centerY.mas_equalTo(self.contentView);
            make.right.mas_equalTo(self.messageLabel.mas_right).mas_offset(10.0f);
//            make.top.mas_equalTo(self.contentView).mas_offset(1.0f);
            //            make.width.mas_equalTo(self.messageLabel);
        }];
        
        [self.messageLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.bubbleImage).mas_offset(10.0f);
            make.centerY.mas_equalTo(self.bubbleImage);
            
//            make.top.mas_equalTo(self.bubbleImage).mas_offset(1.0f);
//            make.bottom.mas_equalTo(self.bubbleImage).mas_offset(-1.0f); //right.
//            make.right.mas_equalTo(self.bubbleImage).mas_offset(-10.0f);
        }];
        

    
    }
    
    CGSize   frameSize = [self.messageLabel sizeThatFits:CGSizeMake(MAX_MESSAGE_WIDTH, MAXFLOAT)];
    frameSize = CGSizeMake(frameSize.width, frameSize.height + 20);
    [self.messageLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(frameSize);
    }];
    
//    [self.messageLabel mas_updateConstraints:^(MASConstraintMaker *make) {
//        make.size.mas_equalTo(message.messageFrame.contentSize);
//    }];
    
    MASAttachKeys(self.contentView,self.avatarButton,self.messageLabel,self.bubbleImage);
    
}


#pragma mark - Getter -
- (UILabel *)messageLabel
{
    if (_messageLabel == nil) {
        _messageLabel = [[UILabel alloc] init];
        [_messageLabel setFont:[UIFont systemFontOfSize:16.0f]];
        [_messageLabel setNumberOfLines:0];
    }
    return _messageLabel;
}


@end
