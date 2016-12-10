//
//  ViewController.m
//  HttpTest
//
//  Created by 刘万林 on 2016/11/12.
//  Copyright © 2016年 刘万林. All rights reserved.
//

#import "ViewController.h"
#import "AFNetworking.h"
#import "BSKSaveActionViewController.h"
#import "BSKWindowController.h"
@interface ViewController ()<NSTextViewDelegate>
@property (weak) IBOutlet NSTextField *urlTextField;
@property (unsafe_unretained) IBOutlet NSTextView *responseTextField;
@property (unsafe_unretained) IBOutlet NSTextView *parametersTextView;

@property (strong, nonatomic) NSData * responseData;
@property (weak) IBOutlet NSButton *JsonTypeButtonNormal;
@property (weak) IBOutlet NSButton *JsonTypeButtonBSK;
@property (weak) IBOutlet NSTextField *BaseURLTextField;

@property (assign, nonatomic) BOOL JsonTypeBSK;
@property (strong, nonatomic) NSDataDetector * dataDetector;//链接
@property (strong, nonatomic) NSRegularExpression * stringExpression;//引号中的字符串
@property (strong, nonatomic) NSRegularExpression * valueExpression;//键值对中的value
@property (strong, nonatomic) NSRegularExpression * bracesExpression;//大括号
@property (strong, nonatomic) NSRegularExpression * bracketExpression;//中括号
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setLayer:[[CALayer alloc] init]];
    self.view.layer.backgroundColor = [NSColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1].CGColor;
    self.responseTextField.delegate = self;
    self.responseTextField.automaticQuoteSubstitutionEnabled = NO;
    self.parametersTextView.automaticQuoteSubstitutionEnabled = NO;
    self.JsonTypeBSK = [[NSUserDefaults standardUserDefaults] boolForKey:@"JsonTypeBSK"];
    if(self.JsonTypeBSK){
        [self.JsonTypeButtonBSK setState:NSOnState];
    }
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didSelectedDataAction:) name:@"selectedData" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange:) name:NSTextDidChangeNotification object:self.responseTextField];
    NSError *error = NULL;
    self.dataDetector = [NSDataDetector dataDetectorWithTypes:NSTextCheckingTypeLink error:&error];
    if (error) {
         self.dataDetector=nil;
    }
    error = nil;
    self.stringExpression = [[NSRegularExpression alloc]initWithPattern:@"\".*?\"" options:NSRegularExpressionCaseInsensitive error:&error];
    if (error) {
        self.stringExpression = nil;
    }
    error = nil;
    self.valueExpression = [[NSRegularExpression alloc]initWithPattern:@"\".*?\" :" options:NSRegularExpressionCaseInsensitive error:&error];
    if (error) {
        self.valueExpression = nil;
    }
    error = nil;
    self.bracesExpression = [[NSRegularExpression alloc]initWithPattern:@"\\{|\\}" options:NSRegularExpressionCaseInsensitive error:&error];
    if (error) {
        self.bracesExpression = nil;
    }
    error = nil;
    self.bracketExpression = [[NSRegularExpression alloc]initWithPattern:@"\\[|\\]" options:NSRegularExpressionCaseInsensitive error:&error];
    if (error) {
        self.bracketExpression = nil;
    }
}

#pragma mark responseToNotification

-(void)textDidChange:(NSNotification *)notification{
    
    
    NSString *string = [self.responseTextField.textStorage string];
    NSArray * strMatchs = nil;
    NSArray * valueMatchs = nil;
    NSArray * bracesMatches = nil;
    NSArray * bracketMatches = nil;
    NSArray * linkMatchs = nil;
    if(!self.JsonTypeBSK){
        [self.responseTextField.textStorage beginEditing];
        [self.responseTextField.textStorage removeAttribute:NSForegroundColorAttributeName range:NSMakeRange(0, [string length])];
        [self.responseTextField.textStorage removeAttribute:NSLinkAttributeName range:NSMakeRange(0, [string length])];
        [self.responseTextField.textStorage endEditing];
        return;
    }
    if ( self.dataDetector) {
        linkMatchs = [ self.dataDetector matchesInString:string options:0 range:NSMakeRange(0, [string length])];
    }
    if ( self.stringExpression) {
        strMatchs = [ self.stringExpression matchesInString:string options:0 range:NSMakeRange(0, [string length])];
    }
    if ( self.valueExpression) {
        valueMatchs = [ self.valueExpression matchesInString:string options:0 range:NSMakeRange(0, [string length])];
    }
    if ( self.bracketExpression) {
        bracketMatches = [ self.bracketExpression matchesInString:string options:0 range:NSMakeRange(0, [string length])];
    }
    if ( self.bracesExpression) {
        bracesMatches = [ self.bracesExpression matchesInString:string options:0 range:NSMakeRange(0, [string length])];
    }
    [self.responseTextField.textStorage beginEditing];
    [self.responseTextField.textStorage removeAttribute:NSForegroundColorAttributeName range:NSMakeRange(0, [string length])];
    [self.responseTextField.textStorage removeAttribute:NSLinkAttributeName range:NSMakeRange(0, [string length])];
    if (strMatchs) {
        for (NSTextCheckingResult *match in strMatchs) {
            NSRange matchRange = [match range];
                [self.responseTextField.textStorage removeAttribute:NSForegroundColorAttributeName range:matchRange];
                [self.responseTextField.textStorage addAttributes:@{NSForegroundColorAttributeName:[NSColor colorWithRed:0.34 green:0.70 blue:0.21 alpha:1.00]} range:matchRange];
        }
    }
    if (valueMatchs) {
        for (NSTextCheckingResult *match in valueMatchs) {
            NSRange matchRange = [match range];
            [self.responseTextField.textStorage removeAttribute:NSForegroundColorAttributeName range:matchRange];
            [self.responseTextField.textStorage addAttributes:@{NSForegroundColorAttributeName:[NSColor colorWithRed:0.89 green:0.00 blue:0.19 alpha:1.00]} range:matchRange];
        }
    }
    if (bracesMatches) {
        for (NSTextCheckingResult *match in bracesMatches) {
            NSRange matchRange = [match range];
            [self.responseTextField.textStorage removeAttribute:NSForegroundColorAttributeName range:matchRange];
            [self.responseTextField.textStorage addAttributes:@{NSForegroundColorAttributeName:[NSColor colorWithRed:0.64 green:0.16 blue:0.62 alpha:1.00]} range:matchRange];
        }
    }
    if (bracketMatches) {
        for (NSTextCheckingResult *match in bracketMatches) {
            NSRange matchRange = [match range];
            [self.responseTextField.textStorage removeAttribute:NSForegroundColorAttributeName range:matchRange];
            [self.responseTextField.textStorage addAttributes:@{NSForegroundColorAttributeName:[NSColor colorWithRed:0.88 green:0.36 blue:1.00 alpha:1.00]} range:matchRange];
        }
    }
    
    if (linkMatchs) {
         for (NSTextCheckingResult *match in linkMatchs) {
             NSRange matchRange = [match range];
             if ([match resultType] == NSTextCheckingTypeLink) {
                NSURL *url = [match URL];
                [self.responseTextField.textStorage removeAttribute:NSForegroundColorAttributeName range:matchRange];
                [self.responseTextField.textStorage removeAttribute:NSLinkAttributeName range:matchRange];
                [self.responseTextField.textStorage addAttributes:@{NSLinkAttributeName:url.absoluteString} range:matchRange];
            }
         }
    }
   
    [self.responseTextField.textStorage endEditing];
   
}


-(void)didSelectedDataAction:(NSNotification *)notify{
    NSDictionary * dic = notify.object;
    self.BaseURLTextField.stringValue = dic[@"baseurl"];
    self.urlTextField.stringValue = dic[@"url"];
    self.parametersTextView.string = dic[@"parameters"];
    if (![dic[@"responseData"] isKindOfClass:[NSString class]]) {
        self.responseData = dic[@"responseData"];
    }else{
        self.responseData = nil;
    }
    [self FormatJsonAction:nil];
}

- (IBAction)saveAction:(id)sender {
    
    BSKSaveActionViewController * vc = [[BSKSaveActionViewController alloc] init];
    vc.dic = @{@"note":@"无备注",
               @"baseurl":self.BaseURLTextField.stringValue,
               @"url":self.urlTextField.stringValue,
               @"parameters":[self.parametersTextView.string copy],
               @"responseData":self.responseData?self.responseData:@"null"};
    
    [self presentViewControllerAsSheet:vc];
    
}

- (IBAction)actionGetButton:(id)sender {
   NSDictionary * dic = [self getParameters];
    if (dic) {
        [self netGetWithURL:[self getUrl] Parameters:dic];
    }
}
- (IBAction)actionPostButton:(id)sender {
    NSDictionary * dic = [self getParameters];
    if (dic) {
        [self netPostWithURL:[self getUrl] Parameters:dic];
    }
}
- (IBAction)actionClearButton:(id)sender {
    self.responseData = nil;
    self.responseTextField.string = @"";
}


- (void)FormatJsonAction:(NSButton *)sender {
    NSError * error = nil;
    if (!_responseData) {
        _responseTextField.string = @"";
        return;
    }
    NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:_responseData options:NSJSONReadingMutableContainers error:&error];
    if (!error) {
        if (_JsonTypeButtonBSK.state==NSOnState) {
        _responseTextField.string = [NSString stringWithFormat:@"%@",[dic description]];
        }else{
            NSError * error2 = nil;
            NSData * jsondata = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&error2];
            NSString * jsonString = [[NSString alloc]initWithData:jsondata encoding:NSUTF8StringEncoding];
            if (!error2) {
                _responseTextField.string =[jsonString stringByReplacingOccurrencesOfString:@"\\/" withString:@"/"];
            }else{
                _responseTextField.string = [NSString stringWithFormat:@"不是Json数据或Json格式错误：%@",error2];
                _responseData=nil;
            }
        }
    }else{
        _responseTextField.string = [[NSString alloc] initWithData:_responseData encoding:NSUTF8StringEncoding];
    }
    [[NSNotificationCenter defaultCenter]postNotificationName:NSTextDidChangeNotification object:self.responseTextField];
}
- (IBAction)JsonTypeAction:(id)sender {
    self.JsonTypeBSK =(_JsonTypeButtonBSK.state==NSOnState);
    [[NSUserDefaults standardUserDefaults] setBool:self.JsonTypeBSK forKey:@"JsonTypeBSK"];
    [self FormatJsonAction:nil];
}


- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];
    
    // Update the view, if already loaded.
}


#pragma mark - 拼接url

-(NSString * )getUrl{
    NSString * url = nil;
    NSString * baseURL =[self.BaseURLTextField.stringValue stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString * secondUrl = [self.urlTextField.stringValue stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if([baseURL isEqualToString:@""]){
        url = secondUrl;
    }else if([baseURL hasPrefix:@"/"]){
        url = [baseURL stringByAppendingString:secondUrl];
    }else{
        url = [NSString stringWithFormat:@"%@/%@",baseURL,secondUrl];
    }
    return url;
}

#pragma mark - 拼接参数

-(NSDictionary *)getParameters{
    
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    
    NSString * parametersString = self.parametersTextView.string;
    
    NSArray * keyValueArray = [parametersString componentsSeparatedByString:@"\n"];
    
    NSMutableArray * errorArray = [NSMutableArray array];
    
    for (NSString * str in keyValueArray) {
        if (![str isEqualToString:@""]) {
             NSString * str2 = [str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
            NSArray * array = [str2 componentsSeparatedByString:@"="];
            if (array.count!=2||[array[0] isEqualToString:@""]) {
                [errorArray addObject:[str copy]];
            }
            else{
                NSString * str1 = [array[1] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
                NSString * str2 = [array[0] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
                [dic setObject:str1 forKey:str2];
            }
        }
    }
    
    if (errorArray.count>0) {
        [self alertWithTitle:[NSString stringWithFormat:@"参数格式错误:  \n\
              %@\
              \n\
              请按如下格式书写参数：\n\
              \n\
              key1=123\n\
              key2=abc\n\
              key4=value\n",[errorArray componentsJoinedByString:@"\n"]]];
        return nil;
    }
    else {
        return dic;
    }
}

#pragma mark - messageBox

-(void)alertWithTitle:(NSString *)title{
    NSAlert *alert = [[NSAlert alloc] init];
    [alert setMessageText:title];
    [alert runModal];
}

#pragma mark - NetWorking

- (void)netGetWithURL:(NSString *)url Parameters:(NSDictionary *) dic {
    // 请求
    NSString * aurl = url;
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager GET:url parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        _responseData = responseObject;
        [self FormatJsonAction:nil];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        _responseTextField.string = [NSString stringWithFormat:@"网络请求失败：\nURL:%@\n错误信息：%@",aurl,error];
        _responseData=nil;
    }];
}
- (void)netPostWithURL:(NSString *)url Parameters:(NSDictionary *) dic {
    NSString * aurl = url;
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:url parameters:dic progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        _responseData = responseObject;
        
        [self FormatJsonAction:nil];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
      _responseTextField.string = [NSString stringWithFormat:@"网络请求失败：\nURL:%@\n错误信息：%@",aurl,error];
        _responseData=nil;
    }];
}


@end
