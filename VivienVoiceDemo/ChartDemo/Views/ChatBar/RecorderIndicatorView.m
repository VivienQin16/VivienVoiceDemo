//
//  RecorderIndicatorView.m
//  VivienVoiceDemo
//
//  Created by Vivien on 2016/12/20.
//  Copyright © 2016年 Vivien. All rights reserved.
//

#import "RecorderIndicatorView.h"

#define     STR_RECORDING       @"手指上滑，取消发送"
#define     STR_CANCEL          @"手指松开，取消发送"
#define     STR_REC_SHORT       @"说话时间太短"

@interface RecorderIndicatorView ()

@property (nonatomic, strong) UIView *backgroundView;

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UIView *titleBackgroundView;

@property (nonatomic, strong) UIImageView *recImageView;

@property (nonatomic, strong) UIImageView *centerImageView;

@property (nonatomic, strong) UIImageView *volumeImageView;

@end

@implementation RecorderIndicatorView

- (void)initSubviews
{
    self.backgroundColor = [UIColor greenColor];
    [self addSubview:self.backgroundView];
    [self addSubview:self.recImageView];
    [self addSubview:self.volumeImageView];
    [self addSubview:self.centerImageView];
    [self addSubview:self.titleBackgroundView];
    [self addSubview:self.titleLabel];
    
}

#pragma mark - # Private Methods
- (void)setSubviewsLayout
{
    [self.backgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
    [self.recImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(15);
        make.left.mas_equalTo(21);
    }];
    [self.volumeImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.height.mas_equalTo(self.recImageView);
        make.right.mas_equalTo(-21);
    }];
    [self.centerImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(0);
        make.top.mas_equalTo(15);
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(0);
        make.bottom.mas_equalTo(-15);
    }];
    [self.titleBackgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.titleLabel).mas_offset(UIEdgeInsetsMake(-2, -5, -2, -5)).priorityLow();
    }];
}

- (void)setStatus:(RecorderStatus)status
{
    if (status == RecorderStatusWillCancel) {
        [self.centerImageView setHidden:NO];
        [self.centerImageView setImage:[UIImage imageNamed:@"chat_record_cancel"]];
        [self.titleBackgroundView setHidden:NO];
        [self.recImageView setHidden:YES];
        [self.volumeImageView setHidden:YES];
        [self.titleLabel setText:STR_CANCEL];
    }
    else if (status == RecorderStatusRecording) {
        [self.centerImageView setHidden:YES];
        [self.titleBackgroundView setHidden:YES];
        [self.recImageView setHidden:NO];
        [self.volumeImageView setHidden:NO];
        [self.titleLabel setText:STR_RECORDING];
    }
    else if (status == RecorderStatusTooShort) {
        [self.centerImageView setHidden:NO];
        [self.centerImageView setImage:[UIImage imageNamed:@"chat_record_cancel"]];
        [self.titleBackgroundView setHidden:YES];
        [self.recImageView setHidden:YES];
        [self.volumeImageView setHidden:YES];
        [self.titleLabel setText:STR_REC_SHORT];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            if (status == RecorderStatusTooShort) {
                [self removeFromSuperview];
            }
        });
    }
}

- (void)setVolume:(CGFloat)volume
{
    _volume = volume;
    NSInteger picId = 10 * (volume < 0 ? 0 : (volume > 1.0 ? 1.0 : volume));
    picId = picId > 8 ? 8 : picId;
    [self.volumeImageView setImage:[UIImage imageNamed:[NSString stringWithFormat:@"chat_record_signal_%ld", picId]]];
}



#pragma mark - # Getter
- (UIView *)backgroundView
{
    if (_backgroundView == nil) {
        _backgroundView = [[UIView alloc] init];
        [_backgroundView setBackgroundColor:[UIColor blackColor]];
        [_backgroundView setAlpha:0.6f];
        [_backgroundView.layer setMasksToBounds:YES];
        [_backgroundView.layer setCornerRadius:5.0f];
    }
    return _backgroundView;
}

- (UILabel *)titleLabel
{
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] init];
        [_titleLabel setFont:[UIFont systemFontOfSize:14.0f]];
        [_titleLabel setTextAlignment:NSTextAlignmentCenter];
        [_titleLabel setTextColor:[UIColor whiteColor]];
        [_titleLabel setText:STR_RECORDING];
    }
    return _titleLabel;
}

- (UIView *)titleBackgroundView
{
    if (_titleBackgroundView == nil) {
        _titleBackgroundView = [[UIView alloc] init];
        [_titleBackgroundView setHidden:YES];
        [_titleBackgroundView setBackgroundColor:[UIColor redColor]];
        [_titleBackgroundView.layer setMasksToBounds:YES];
        [_titleBackgroundView.layer setCornerRadius:2.0f];
    }
    return _titleBackgroundView;
}

- (UIImageView *)recImageView
{
    if (_recImageView == nil) {
        _recImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"RecordingBkg"]];
    }
    return _recImageView;
}

- (UIImageView *)centerImageView
{
    if (_centerImageView == nil) {
        _centerImageView = [[UIImageView alloc] init];
        [_centerImageView setHidden:YES];
    }
    return _centerImageView;
}

- (UIImageView *)volumeImageView
{
    if (_volumeImageView == nil) {
        _volumeImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"chat_record_signal_1"]];
    }
    return _volumeImageView;
}

@end
