//
//  KeyboardMoreView+CollectionView.m
//  VivienVoiceDemo
//
//  Created by Vivien on 2016/12/20.
//  Copyright © 2016年 Vivien. All rights reserved.
//

#import "KeyboardMoreView+CollectionView.h"
#import "KeyBoardMoreCell.h"

@implementation KeyboardMoreView (CollectionView)

- (void)registerCellClass
{
    [self.collectionView registerClass:[KeyBoardMoreCell class] forCellWithReuseIdentifier:@"KeyboardMoreCell"];
}


- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 2;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 4;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    KeyBoardMoreCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"KeyboardMoreCell"  forIndexPath:indexPath];
    [cell sizeToFit];
    if (!cell) {
        NSLog(@"无法创建CollectionViewCell时打印，自定义的cell就不可能进来了。");
    }
    [self configureCell:cell atIndexPath:indexPath];
    
    return cell;
}


- (void)configureCell:(KeyBoardMoreCell *)cell atIndexPath:(NSIndexPath*)indexPath
{
    
//    int index =  indexPath.row *2 + indexPath.section;
//    cell.section = indexPath.section;
//    [cell setEnableImage:UIResourceBundleSubDevice(imageOpenArr[index])];
//    [cell setDisableImage:UIResourceBundleSubDevice(imageCloseArr[index])];
    // [cell  setImage:UIResourceBundleSubDevice(imageOpenArr[index])];
    
    
//    [cell setNameText:titleArr[index]];
    
//    [cell setDeviceNum:[devCountArr[index]integerValue]];
    [cell setNeedsUpdateConstraints];
    [cell updateConstraintsIfNeeded];
}


-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    return CGSizeMake(kScreenWidth/4, collectionView.frame.size.height/2);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    // NSLog(@"cell #%d was selected  %d", indexPath.row,indexPath.section);
    
}


@end
