//
//  ChatMessageDisplayView+Delegate.m
//  VivienVoiceDemo
//
//  Created by Vivien on 2016/12/19.
//  Copyright © 2016年 Vivien. All rights reserved.
//

#import "ChatMessageDisplayView+Delegate.h"
#import "EcoMessageCell.h"
#import "EcoLinkMessageCell.h"
#import "EcoMessage.h"
@implementation ChatMessageDisplayView (Delegate)

#pragma mark - # Public Methods
- (void)registerCellClassForTableView:(UITableView *)tableView
{
    [tableView registerClass:[EcoMessageCell class] forCellReuseIdentifier:@"EcoMessageCell"];
    [tableView registerClass:[EcoLinkMessageCell class] forCellReuseIdentifier:@"EcoLinkMessageCell"];
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"EmptyCell"];
}


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

    EcoMessage * message = self.dataArr[indexPath.row];
    return message.messageFrame.height;
    
    //    return 60;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    EcoMessage * message = self.dataArr[indexPath.row];
    static NSString *CellIdentifier = @"Cell";
    EcoBaseMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if( message.messageType == MessageTypeText || message.messageType == MessageTypeVoiceText )
    {
        if (cell == nil) {
            cell = [[EcoMessageCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        }
        [cell setMessage:message];
        return  cell;
        
    }
    else if (message.messageType == MessagetTypeLinkText)
    {
        cell = [[EcoLinkMessageCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
//        EcoLinkMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"EcoLinkMessageCell"];
        [cell setMessage:message];
        
        return cell;
    }
    
    return [tableView dequeueReusableCellWithIdentifier:@"EmptyCell"];;
}

@end
