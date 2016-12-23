//
//  KeyboardMoreView.h
//  VivienVoiceDemo
//
//  Created by Vivien on 2016/12/20.
//  Copyright © 2016年 Vivien. All rights reserved.
//

#import "ChatBaseView.h"

@interface KeyboardMoreView : ChatBaseView

@property (nonatomic, strong) UICollectionView *collectionView;

- (void)showInView:(UIView *)view withAnimation:(BOOL)animation;

- (void)dismissWithAnimation:(BOOL)animation;

@end
