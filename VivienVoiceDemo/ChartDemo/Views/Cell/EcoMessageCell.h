//
//  EcoMessageCell.h
//  VivienVoiceDemo
//
//  Created by Vivien on 2016/12/15.
//  Copyright © 2016年 Vivien. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EcoMessageCell : UITableViewCell

///对话时间
@property (nonatomic, strong) UILabel *timeLabel;
///头像按钮
@property (nonatomic, strong) UIButton *avatarButton;

@property (nonatomic, strong) UILabel *usernameLabel;

@property (nonatomic, strong) UIImageView *messageBackgroundView;

@end
