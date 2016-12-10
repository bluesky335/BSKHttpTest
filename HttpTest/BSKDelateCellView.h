//
//  BSKDelateCellView.h
//  HttpTest
//
//  Created by 刘万林 on 16/12/5.
//  Copyright © 2016年 刘万林. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface BSKDelateCellView : NSTableCellView
@property (strong) IBOutlet NSButton *delateButton;
@property(copy,nonatomic) void(^delateCallBack)(BSKDelateCellView * cellView);
@end
