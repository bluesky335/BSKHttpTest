//
//  BSKSaveActionViewController.m
//  HttpTest
//
//  Created by 刘万林 on 16/12/5.
//  Copyright © 2016年 刘万林. All rights reserved.
//

#import "BSKSaveActionViewController.h"

@interface BSKSaveActionViewController ()
@property (strong) IBOutlet NSTextField *noteTextField;

@end

@implementation BSKSaveActionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.
}
- (IBAction)cancelAction:(id)sender {
    [self dismissViewController:self];
}
- (IBAction)saveAction:(id)sender {
    
    NSMutableDictionary * mdic = [self.dic mutableCopy];
    if(_noteTextField.stringValue&&![_noteTextField.stringValue isEqualToString:@""]){
        mdic[@"note"] = [_noteTextField.stringValue copy];
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:@"saveDic" object:mdic userInfo:nil];
    [self dismissViewController:self];
}

@end
