//
//  EcoMessageCell.m
//  VivienVoiceDemo
//
//  Created by Vivien on 2016/12/15.
//  Copyright © 2016年 Vivien. All rights reserved.
//

#import "EcoMessageCell.h"

#define     AVATAR_WIDTH        40.0f
#define     AVATAR_SPACE_X      8.0f
#define     AVATAR_SPACE_Y      12.0f

#define     MSG_SPACE_TOP       14
#define     MSG_SPACE_BTM       20

#define     MSG_SPACE_LEFT      19
#define     MSG_SPACE_RIGHT     22

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

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
    
        [self initSubviews];
    }
    return self;
}


- (void)initSubviews
{
    self.selectionStyle = NO;
    [self setBackgroundColor:[UIColor clearColor]];
    [self setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    [self.contentView addSubview:self.avatarButton];
    [self.contentView addSubview:self.bubbleImage];
    [self.contentView addSubview:self.messageLabel];
    
    self.backgroundColor = [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1];

}

- (void)setMessage:(EcoMessage *)message
{
    [_messageLabel  setText:message.messageText];
    
    UIImage *bubble;
    
    [self.avatarButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.width.and.height.mas_equalTo(AVATAR_WIDTH);
        make.top.mas_equalTo(self.contentView).mas_offset(AVATAR_SPACE_Y);
//        make.top.mas_equalTo(self.timeLabel.mas_bottom).mas_offset(AVATAR_SPACE_Y);
        if(message.ownerTyper == MessageOwnerTypeSelf) {
            make.right.mas_equalTo(self.contentView).mas_offset(-AVATAR_SPACE_X);
        }
        else {
            make.left.mas_equalTo(self.contentView).mas_offset(AVATAR_SPACE_X);
        }
    }];
    
    if (message.ownerTyper == MessageOwnerTypeSelf) {  //用户发的
        [_avatarButton setImage:[UIImage imageNamed:@"icon_mine"] forState:UIControlStateNormal];
        [self.messageLabel setTextAlignment: NSTextAlignmentRight];

        
        bubble =  [UIImage imageNamed:@"SenderTextNodeBkg"];
        [_bubbleImage setImage:[bubble stretchableImageWithLeftCapWidth:bubble.size.width/2 topCapHeight:bubble.size.height/2]];
        
        [_bubbleImage mas_remakeConstraints:^(MASConstraintMaker *make) {
//            make.top.mas_equalTo(self.contentView).mas_equalTo(1.0f);
            make.centerY.mas_equalTo(self.contentView);
            make.right.mas_equalTo(self.avatarButton.mas_left).mas_offset(-MSG_SPACE_LEFT);
            make.left.mas_equalTo(self.messageLabel.mas_left).mas_offset(-10.0f);
        }];
        
        [self.messageLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
             make.centerY.mas_equalTo(_bubbleImage);
             make.right.mas_equalTo(self.bubbleImage).mas_offset(-10.0f);
//            make.top.mas_equalTo(self.bubbleImage).mas_offset(1.0f);
            make.bottom.mas_equalTo(self.bubbleImage).mas_offset(-5.0f); //left.
//            make.left.mas_equalTo(self.bubbleImage).mas_offset(10.0f);
        }];
        
    }
    else{  //机器人发的
        
        bubble =  [UIImage imageNamed:@"ReceiverTextNodeBkg"];
        [_bubbleImage setImage:[bubble stretchableImageWithLeftCapWidth:bubble.size.width/2 topCapHeight:bubble.size.height/2]];
        
        [_avatarButton setImage:[UIImage imageNamed:@"icon_friend"] forState:UIControlStateNormal];
        [self.messageLabel setTextAlignment: NSTextAlignmentLeft];

        
        [_bubbleImage mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.avatarButton.mas_right).mas_offset(MSG_SPACE_LEFT);
            make.centerY.mas_equalTo(self.contentView);
            make.right.mas_equalTo(self.messageLabel.mas_right).mas_offset(10.0f);
//            make.top.mas_equalTo(self.contentView).mas_offset(1.0f);
            //            make.width.mas_equalTo(self.messageLabel);
        }];
        
        [self.messageLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.bubbleImage).mas_offset(10.0f);
            make.centerY.mas_equalTo(_bubbleImage);
            
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

#pragma mark - Getter -
- (UILabel *)timeLabel
{
    if (_timeLabel == nil) {
        _timeLabel = [[UILabel alloc] init];
        _timeLabel.backgroundColor = [UIColor grayColor];
        [_timeLabel setFont:[UIFont systemFontOfSize:12.0f]];
        [_timeLabel setTextColor:[UIColor whiteColor]];
        [_timeLabel setBackgroundColor:[UIColor grayColor]];
        [_timeLabel setAlpha:0.7f];
        [_timeLabel.layer setMasksToBounds:YES];
        [_timeLabel.layer setCornerRadius:5.0f];
    }
    return _timeLabel;
}

- (UIButton *)avatarButton
{
    if (_avatarButton == nil) {
        _avatarButton = [[UIButton alloc] init];
        [_avatarButton.layer setMasksToBounds:YES];
        [_avatarButton.layer setBorderWidth:BORDER_WIDTH_1PX];
        [_avatarButton.layer setBorderColor:[UIColor colorWithWhite:0.7 alpha:1.0].CGColor];
        _avatarButton.userInteractionEnabled = NO ;
    }
    return _avatarButton;
}

- (UIImageView *)bubbleImage
{
    if (_bubbleImage == nil) {
        _bubbleImage = [[UIImageView alloc]init];
//        _bubbleImage.backgroundColor = [UIColor grayColor];
        
    }
    return _bubbleImage;
}

@end
