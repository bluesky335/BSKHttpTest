//
//  BSKAboutViewController.m
//  HttpTest
//
//  Created by 刘万林 on 2016/12/10.
//  Copyright © 2016年 bluesky335. All rights reserved.
//

#import "BSKAboutViewController.h"

@interface BSKAboutViewController ()
@property (weak) IBOutlet NSImageView *headerImageView;

@end

@implementation BSKAboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setLayer:[[CALayer alloc] init]];
    self.headerImageView.layer.cornerRadius = 60;
    
    self.view.layer.backgroundColor = [NSColor whiteColor].CGColor;
    self.view.layer.frame = self.view.bounds;
    
}
- (IBAction)mailAction:(NSButton *)sender {
    sender.state = NSOffState;
     [[NSWorkspace sharedWorkspace] openURL:[NSURL URLWithString:@"mailto:chinabluesky335@gmail.com"]];
}
- (IBAction)websiteAction:(NSButton *)sender {
    sender.state = NSOffState;
     [[NSWorkspace sharedWorkspace] openURL:[NSURL URLWithString:@"http://httptest.liuwanlin.tk"]];
    
}
- (IBAction)codeAction:(NSButton *)sender {
    sender.state = NSOffState;
     [[NSWorkspace sharedWorkspace] openURL:[NSURL URLWithString:@"https://github.com/bluesky335/BSKHttpTest"]];
}

@end
