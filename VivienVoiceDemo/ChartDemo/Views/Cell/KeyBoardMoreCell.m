//
//  KeyBoardMoreCell.m
//  VivienVoiceDemo
//
//  Created by Vivien on 2016/12/21.
//  Copyright © 2016年 Vivien. All rights reserved.
//

#import "KeyBoardMoreCell.h"

@implementation KeyBoardMoreCell


- (id) initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self initSubviews];
        [self setSubviewsLayout];


    }
    return self;
}



- (void)iconButtonDown:(UIButton *)sender
{
    
    
}



- (void)initSubviews
{
    [self.contentView addSubview:self.iconButton];
    [self.contentView addSubview:self.titleLabel];
}

- (void)setSubviewsLayout
{
    [self.iconButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentView);
        make.centerX.mas_equalTo(self.contentView);
        make.width.mas_equalTo(self.contentView);
        make.height.mas_equalTo(self.iconButton.mas_width);
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.contentView);
        make.bottom.mas_equalTo(self.contentView);
    }];
    
}


#pragma mark - Getter -
- (UIButton *)iconButton
{
    if (_iconButton == nil) {
        _iconButton = [[UIButton alloc] init];
        _iconButton.backgroundColor = [UIColor redColor];
        [_iconButton.layer setMasksToBounds:YES];
        [_iconButton.layer setCornerRadius:5.0f];
        [_iconButton.layer setBorderWidth:BORDER_WIDTH_1PX];
        [_iconButton.layer setBorderColor:[UIColor grayColor].CGColor];
//        [_iconButton setBackgroundImage:[UIImage imageWithColor:[UIColor colorGrayLine]] forState:UIControlStateHighlighted];
        [_iconButton addTarget:self action:@selector(iconButtonDown:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _iconButton;
}

- (UILabel *)titleLabel
{
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] init];
        [_titleLabel setFont:[UIFont systemFontOfSize:12.0f]];
        [_titleLabel setTextColor:[UIColor grayColor]];
    }
    return _titleLabel;
}


@end
