//
//  NSDictionary+Log.m
//  Xcode NSDictionary and NSArray Unicode to Chinese
//
//  Created by 刘万林 on 2016/10/28.
//  Copyright © 2016年 刘万林. All rights reserved.
//

#import <Foundation/Foundation.h>

@implementation NSDictionary (BSKLog)
- (NSString *)description
{
    NSMutableString *string = [NSMutableString string];
    
    // 开头有个{
    
    [string appendString:@"{\n"];
    
    // 遍历所有的键值对
    [self enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        [string appendFormat:@"\"%@\"", [key description]];
        [string appendString:@" : "];
        [string appendFormat:@"%@ , \n", [NSDictionary getDescriptionByObj:obj Mode:0]];
    }];
    
    // 结尾有个}
    [string appendString:@"}"];
    
    // 查找最后一个逗号
    NSRange range = [string rangeOfString:@"," options:NSBackwardsSearch];
    if (range.location != NSNotFound)
        [string deleteCharactersInRange:range];
    
    return string;
}

+(NSString *)getDescriptionByObj:(id)obj Mode:(NSInteger)mode{
    
    NSMutableString * mstr = [NSMutableString string];
    NSArray * strs =[[obj description] componentsSeparatedByString:@"\n"];
    
    NSString * t=@"";
    NSString * e=@"";
    if ([obj isKindOfClass:NSString.self]) {
        t=@"\t ";
        e=@"\"";
    }
    
    if(mode==1){
        t=@" ";
    }
    
    for (NSInteger i = 0; i<strs.count; i++) {
        if (i==0) {
            if (strs.count==1) {
                [mstr appendString:[NSString stringWithFormat:@"%@%@%@",e,strs[i],e]];
            }
            else{
                if (mode==0&&[obj isKindOfClass:NSString.self]) {
                    [mstr appendString:[NSString stringWithFormat:@"\n\t\t%@%@\n",e,strs[i]]];
                }else{
                    [mstr appendString:[NSString stringWithFormat:@"%@%@\n",e,strs[i]]];
                }
            }
        }
        else if(i==strs.count-1){
            [mstr appendString:[NSString stringWithFormat:@"\t%@%@%@",t,strs[i],e]];
        }
        else{
            [mstr appendString:[NSString stringWithFormat:@"\t%@%@\n",t,strs[i]]];
        }
    }
    return [mstr copy];
}

@end

@implementation NSArray (BSKLog)

- (NSString *)description
{
    NSMutableString *string = [NSMutableString string];
    
    // 开头有个[
    [string appendString:@"[\n"];
    
    // 遍历所有的元素
    [self enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            [string appendFormat:@"%@ , \n",[NSDictionary getDescriptionByObj:obj Mode:1]];
    }];
    
    // 结尾有个]
    [string appendString:@"]"];
    // 查找最后一个逗号
    NSRange range = [string rangeOfString:@"," options:NSBackwardsSearch];
    if (range.location != NSNotFound)
        [string deleteCharactersInRange:range];
    return string;
}
@end
