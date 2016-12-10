//
//  BSKTableViewController.m
//  HttpTest
//
//  Created by 刘万林 on 2016/12/1.
//  Copyright © 2016年 刘万林. All rights reserved.
//

#import "BSKTableViewController.h"
#import "BSKDelateCellView.h"
@interface BSKTableViewController ()<NSTableViewDelegate,NSTableViewDataSource>
@property (weak) IBOutlet NSTableView *dataTableView;
@property (strong, nonatomic) NSMutableArray * data;
@end

@implementation BSKTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSMutableArray * array = [[NSUserDefaults standardUserDefaults] objectForKey:@"data"];
    if(!array){
        self.data = [NSMutableArray array];
    }else{
        self.data = [array mutableCopy];
        [self.dataTableView reloadData];
    }
    self.dataTableView.dataSource = self;
    self.dataTableView.delegate = self;
    self.dataTableView.target=self;
    [self.dataTableView setDoubleAction:@selector(doubleClickTableView:)];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(saveAction:) name:@"saveDic" object:nil];
    // Do view setup here.
}
-(void)saveAction:(NSNotification *)notify{
    [self.data addObject:notify.object];
    [self.dataTableView reloadData];
}

-(void)viewDidDisappear{
    [[NSUserDefaults standardUserDefaults] setObject:self.data forKey:@"data"];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"saveDic" object:nil];
    [[NSApplication sharedApplication] terminate:self];
}

-(void)doubleClickTableView:(id)sender{
    
    NSLog(@"%ld",self.dataTableView.clickedRow);
    if (self.dataTableView.clickedRow<0) {
        return;
    }
    
    NSDictionary * dic =self.data[self.dataTableView.clickedRow];
    NSLog(@"++=%@",dic[@"parameters"]);
    
    [[NSNotificationCenter defaultCenter]postNotificationName:@"selectedData" object:dic userInfo:nil];
}


-(NSInteger)numberOfRowsInTableView:(NSTableView *)tableView{
    return self.data.count;
}

-(NSView *)tableView:(NSTableView *)tableView viewForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row{
    if ([tableColumn.identifier isEqualToString:@"baseurl"]) {
        NSTableCellView * cell = [tableView makeViewWithIdentifier:@"baseurl" owner:nil];
        
        cell.textField.stringValue = self.data[row][@"baseurl"];
        return cell;
    }else  if ([tableColumn.identifier isEqualToString:@"url"]) {
        NSTableCellView * cell = [tableView makeViewWithIdentifier:@"url" owner:nil];
        
        cell.textField.stringValue = self.data[row][@"url"];
        return cell;
    }else if ([tableColumn.identifier isEqualToString:@"note"]) {
        NSTableCellView * cell = [tableView makeViewWithIdentifier:@"note" owner:nil];
        
        cell.textField.stringValue = self.data[row][@"note"];
        return cell;
    }else if ([tableColumn.identifier isEqualToString:@"parameters"]) {
        NSTableCellView * cell = [tableView makeViewWithIdentifier:@"parameters" owner:nil];
        
        NSString * str = [self.data[row][@"parameters"] copy];
        cell.textField.stringValue = [str stringByReplacingOccurrencesOfString:@"\n" withString:@";"];
        return cell;
    }else if ([tableColumn.identifier isEqualToString:@"delateAction"]) {
        BSKDelateCellView * cell = [tableView makeViewWithIdentifier:@"delateAction" owner:nil];
        [cell setDelateCallBack:^(BSKDelateCellView *view) {
            
            
            [_data removeObjectAtIndex:[_dataTableView rowForView:view]];
            [_dataTableView reloadData];
        }];
        return cell;
    }
    return nil;
}


@end
