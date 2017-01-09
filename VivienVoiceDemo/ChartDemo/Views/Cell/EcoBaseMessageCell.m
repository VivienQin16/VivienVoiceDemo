//
//  EcoBaseMessageCell.m
//  VivienVoiceDemo
//
//  Created by Vivien on 2017/1/9.
//  Copyright © 2017年 Vivien. All rights reserved.
//

#import "EcoBaseMessageCell.h"

@implementation EcoBaseMessageCell

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
    
    self.backgroundColor = [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1];
    
}


- (void)setMessage:(EcoMessage *)message
{
   
    [self.avatarButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.width.and.height.mas_equalTo(AVATAR_WIDTH);
        make.top.mas_equalTo(self.contentView).mas_offset(AVATAR_SPACE_Y);
        if( message.ownerTyper == MessageOwnerTypeUser) {
            make.right.mas_equalTo(self.contentView).mas_offset(-AVATAR_SPACE_X);
        }
        else {
            make.left.mas_equalTo(self.contentView).mas_offset(AVATAR_SPACE_X);
        }
    }];
    
     UIImage *bubble;
    
    if (message.ownerTyper == MessageOwnerTypeUser) {
        
        bubble =  [UIImage imageNamed:@"SenderTextNodeBkg"];
        [self.bubbleImage setImage:[bubble stretchableImageWithLeftCapWidth:bubble.size.width/2 topCapHeight:bubble.size.height/2]];
        
        [self.avatarButton setImage:[UIImage imageNamed:@"icon_mine"] forState:UIControlStateNormal];
    }
    else{  //机器人发的
        
        bubble =  [UIImage imageNamed:@"ReceiverTextNodeBkg"];
        [self.bubbleImage setImage:[bubble stretchableImageWithLeftCapWidth:bubble.size.width/2 topCapHeight:bubble.size.height/2]];
        
        [self.avatarButton setImage:[UIImage imageNamed:@"icon_friend"] forState:UIControlStateNormal];
        
    }
    
    
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
    }
    return _bubbleImage;
}


@end
