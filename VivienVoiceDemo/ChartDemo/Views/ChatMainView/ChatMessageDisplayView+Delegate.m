//
//  ChatMessageDisplayView+Delegate.m
//  VivienVoiceDemo
//
//  Created by Vivien on 2016/12/19.
//  Copyright © 2016年 Vivien. All rights reserved.
//

#import "ChatMessageDisplayView+Delegate.h"

@implementation ChatMessageDisplayView (Delegate)


#pragma mark --LogTable Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
     return self.data.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 30;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Create
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    cell.selectionStyle = NO;
    cell.backgroundColor =[UIColor whiteColor];

    cell.textLabel.font = [UIFont systemFontOfSize:15];
    
    return cell;
}

@end
