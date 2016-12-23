//
//  KeyboardMoreView.m
//  VivienVoiceDemo
//
//  Created by Vivien on 2016/12/20.
//  Copyright © 2016年 Vivien. All rights reserved.
//

#import "KeyboardMoreView.h"
#import "KeyboardMoreView+CollectionView.h"

@implementation KeyboardMoreView




- (void)showInView:(UIView *)view withAnimation:(BOOL)animation
{
    [view addSubview:self];
    [self mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.mas_equalTo(view);
        make.height.mas_equalTo(HEIGHT_CHAT_KEYBOARD);
        make.bottom.mas_equalTo(view).mas_offset(HEIGHT_CHAT_KEYBOARD);
    }];
    
     [view layoutIfNeeded];
    
    if (animation) {
        [UIView animateWithDuration:0.1 animations:^{
            [self mas_updateConstraints:^(MASConstraintMaker *make) {
                make.bottom.mas_equalTo(view);
            }];
            [view layoutIfNeeded];
//            if (self.keyboardDelegate && [self.keyboardDelegate respondsToSelector:@selector(chatKeyboard:didChangeHeight:)]) {
//                [self.keyboardDelegate chatKeyboard:self didChangeHeight:view.height - self.y];
//            }
        } completion:^(BOOL finished) {
//            if (self.keyboardDelegate && [self.keyboardDelegate respondsToSelector:@selector(chatKeyboardDidShow:animated:)]) {
//                [self.keyboardDelegate chatKeyboardDidShow:self animated:animation];
//            }
        }];
    }
    
}

- (void)dismissWithAnimation:(BOOL)animation
{
    
    [UIView animateWithDuration:0.1 animations:^{
        [self mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(self.superview).mas_offset(HEIGHT_CHAT_KEYBOARD);
        }];
        [self.superview layoutIfNeeded];
//        if (self.keyboardDelegate && [self.keyboardDelegate respondsToSelector:@selector(chatKeyboard:didChangeHeight:)]) {
//            [self.keyboardDelegate chatKeyboard:self didChangeHeight:self.superview.height - self.y];
//        }
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
//        if (self.keyboardDelegate && [self.keyboardDelegate respondsToSelector:@selector(chatKeyboardDidDismiss:animated:)]) {
//            [self.keyboardDelegate chatKeyboardDidDismiss:self animated:animation];
//        }
    }];
    
}

- (void)initSubviews
{
    [self addSubview:self.collectionView];
    [self registerCellClass];
    
}


- (void)setSubviewsLayout
{
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self);
        make.left.and.right.mas_equalTo(self);
        make.bottom.mas_equalTo(-25);
    }];
}

#pragma mark - # Getter
- (UICollectionView *)collectionView
{
    if (_collectionView == nil) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        [layout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
        layout.minimumLineSpacing = 0;
        layout.minimumInteritemSpacing = 0;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        [_collectionView setBackgroundColor:[UIColor clearColor]];
        [_collectionView setPagingEnabled:YES];
        [_collectionView setDataSource:self];
        [_collectionView setDelegate:self];
        [_collectionView setShowsHorizontalScrollIndicator:NO];
        [_collectionView setShowsHorizontalScrollIndicator:NO];
        
        [_collectionView setScrollsToTop:NO];
    }
    return _collectionView;
}


@end
