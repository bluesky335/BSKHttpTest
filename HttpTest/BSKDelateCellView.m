//
//  BSKDelateCellView.m
//  HttpTest
//
//  Created by 刘万林 on 16/12/5.
//  Copyright © 2016年 刘万林. All rights reserved.
//

#import "BSKDelateCellView.h"

@implementation BSKDelateCellView

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    
    // Drawing code here.
}
- (IBAction)delateAction:(id)sender {
    NSLog(@"delate!!!");
    if(self.delateCallBack){
        self.delateCallBack(self);
    }
    
}

@end
