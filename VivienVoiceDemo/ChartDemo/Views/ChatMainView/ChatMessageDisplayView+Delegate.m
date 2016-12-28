//
//  ChatMessageDisplayView+Delegate.m
//  VivienVoiceDemo
//
//  Created by Vivien on 2016/12/19.
//  Copyright © 2016年 Vivien. All rights reserved.
//

#import "ChatMessageDisplayView+Delegate.h"
#import "EcoMessageCell.h"
@implementation ChatMessageDisplayView (Delegate)


#pragma mark --LogTable Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
     return self.dataArr.count;
}



- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{

//    static EcoMessageCell *cell = nil;
//    if (!cell){
//        cell = [[EcoMessageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
//    }
//
////    [cell setMessage:self.dataArr[indexPath.row]];
//    [cell updateConstraintsIfNeeded];
//    [cell setNeedsLayout];
//    
//    CGFloat height = [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
//    NSLog(@"height:%f",height);
//            
//    return height + 1;
    return 60;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Create
    static NSString *CellIdentifier = @"Cell";
    EcoMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[EcoMessageCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }


    cell.textLabel.font = [UIFont systemFontOfSize:15];
    
    EcoMessage *message = self.dataArr[indexPath.row];
    [cell setMessage:message];
    
    return cell;
}

@end
