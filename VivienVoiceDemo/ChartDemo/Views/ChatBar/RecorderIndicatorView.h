//
//  RecorderIndicatorView.h
//  VivienVoiceDemo
//
//  Created by Vivien on 2016/12/20.
//  Copyright © 2016年 Vivien. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChatBaseView.h"
typedef NS_ENUM(NSInteger, RecorderStatus) {
    RecorderStatusRecording,
    RecorderStatusWillCancel,
    RecorderStatusTooShort,
};

@interface RecorderIndicatorView : ChatBaseView

@property (nonatomic, assign) RecorderStatus status;

/**
 *  音量大小，取值（0-1）
 */
@property (nonatomic, assign) CGFloat volume;

@end
