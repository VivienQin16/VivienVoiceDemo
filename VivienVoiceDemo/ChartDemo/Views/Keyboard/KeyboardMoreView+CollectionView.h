//
//  KeyboardMoreView+CollectionView.h
//  VivienVoiceDemo
//
//  Created by Vivien on 2016/12/20.
//  Copyright © 2016年 Vivien. All rights reserved.
//

#import "KeyboardMoreView.h"

@interface KeyboardMoreView (CollectionView)<UICollectionViewDelegate,UICollectionViewDataSource>

- (void)registerCellClass;

@end
