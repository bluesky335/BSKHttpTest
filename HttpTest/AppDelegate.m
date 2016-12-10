//
//  AppDelegate.m
//  HttpTest
//
//  Created by 刘万林 on 2016/11/12.
//  Copyright © 2016年 刘万林. All rights reserved.
//

#import "AppDelegate.h"
#import "BSKAboutViewController.h"
#import "BSKWindowController.h"
@interface AppDelegate ()

@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application
}


- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}

- (IBAction)helpAction:(id)sender {
      [[NSWorkspace sharedWorkspace] openURL:[NSURL URLWithString:@"http://bluesky335.oschina.io/PC/index.html"]];
}
- (IBAction)linkToWebSite:(id)sender {
}
- (IBAction)aboutAction:(id)sender {
    [[[[NSApp keyWindow] windowController] contentViewController] presentViewControllerAsModalWindow:[[BSKAboutViewController alloc] init]];
}

@end
