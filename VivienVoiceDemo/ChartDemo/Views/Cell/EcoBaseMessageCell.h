//
//  EcoBaseMessageCell.h
//  VivienVoiceDemo
//
//  Created by Vivien on 2017/1/9.
//  Copyright © 2017年 Vivien. All rights reserved.
//

#import <UIKit/UIKit.h>

#define     AVATAR_WIDTH        40.0f
#define     AVATAR_SPACE_X      8.0f
#define     AVATAR_SPACE_Y      12.0f

#define     MSG_SPACE_TOP       14
#define     MSG_SPACE_BTM       20

#define     MSG_SPACE_LEFT      19
#define     MSG_SPACE_RIGHT     22

@interface EcoBaseMessageCell : UITableViewCell

///对话时间
@property (nonatomic, strong) UILabel *timeLabel;
///头像按钮
@property (nonatomic, strong) UIButton *avatarButton;

@property (nonatomic, strong) UILabel *usernameLabel;

//Message Bubble View
@property (nonatomic, strong) UIImageView *bubbleImage;

- (void)setMessage:(EcoMessage *)message;

- (void)initSubviews;

@end
