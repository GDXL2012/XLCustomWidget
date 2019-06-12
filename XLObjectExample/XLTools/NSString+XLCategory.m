//
//  NSString+XLCategory.m
//  XLXLFamily
//
//  Created by liyj on 2018/5/31.
//  Copyright © 2018年 xuelan. All rights reserved.
//

#import "NSString+XLCategory.h"

@implementation NSString (XLCategory)

/**
 是否为空字符串：不过滤空格
 
 @param string <#string description#>
 @return <#return value description#>
 */
+(BOOL)isNilString:(NSString *)string{
    if (string == nil) {
        return YES;
    }
    if (string == NULL) {
        return YES;
    }
    if ([string isKindOfClass:[NSNull class]]) {
        return YES;
    }
    return NO;
}

/**
 是否为空字符串：不过滤空格, 字符串长度
 
 @param string <#string description#>
 @return <#return value description#>
 */
+(BOOL)isEmptyString:(NSString *)string{
    if (string == nil) {
        return YES;
    }
    if (string == NULL) {
        return YES;
    }
    if ([string isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if (string.length == 0) {
        return YES;
    }
    return NO;
}

/**
 字符串是否为空
 
 @param string 目标字符串
 @return YES 空
 */
+ (BOOL)isEmpty:(NSString *)string{
    if (string == nil) {
        return YES;
    }
    if (string == NULL) {
        return YES;
    }
    if ([string isKindOfClass:[NSNull class]]) {
        return YES;
    }
    // 去除字符串两端空格
    if ([string isKindOfClass:[NSString class]] && [[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length]==0) {
        return YES;
    }
    return NO;
}

/**
 手机号码过滤特殊字符
 
 @param phone <#phone description#>
 @return <#return value description#>
 */
+(NSString *)filterCharacterForPone:(NSString *)phone{
    NSCharacterSet *setForRemoe = [[NSCharacterSet characterSetWithCharactersInString:@"0123456789"] invertedSet];
    NSArray *characters = [phone componentsSeparatedByCharactersInSet:setForRemoe];
    phone = [characters componentsJoinedByString:@""];
    if ([phone hasPrefix:@"86"]) {
        phone = [phone substringFromIndex:2];
    } else if ([phone hasPrefix:@"+86"] || [phone hasPrefix:@"086"]) {
        phone = [phone substringFromIndex:3];
    } else if ([phone hasPrefix:@"0086"]) {
        phone = [phone substringFromIndex:4];
    }
    return phone;
}

/** 数字转字符串 */
+(NSString*)stringWithInt:(int)value{
    return [NSString stringWithFormat:@"%ld", (long)value];
}
+(NSString*)stringWithLong:(long)value{
    return [NSString stringWithFormat:@"%ld", value];
}
+(NSString*)stringWithFloat:(float)value{
    return [NSString stringWithFormat:@"%f", value];
}
+(NSString*)stringWithFloat:(float)value decimal:(long)decimal{
    NSString *format = @"%f";
    if (decimal == 0) {
        format = @"%.0f";
    } else if (decimal == 1){
        format = @"%.1f";
    } else if (decimal == 2){
        format = @"%.2f";
    } else if (decimal == 3){
        format = @"%.3f";
    } else if (decimal == 4){
        format = @"%.4f";
    }
    
    return [NSString stringWithFormat:format, value];
}

+(NSString*)stringWithDouble:(double)value{
    // 避免显示无意义的0
    NSString *dStr      = [NSString stringWithFormat:@"%f", value];
    NSDecimalNumber *dn = [NSDecimalNumber decimalNumberWithString:dStr];
    return [dn stringValue];
}

+(NSString*)stringWithDouble:(double)value decimal:(long)decimal{
    NSString *format = @"%f";
    if (decimal == 0) {
        format = @"%.0f";
    } else if (decimal == 1){
        format = @"%.1f";
    } else if (decimal == 2){
        format = @"%.2f";
    } else if (decimal == 3){
        format = @"%.3f";
    } else if (decimal == 4){
        format = @"%.4f";
    }
    
    return [NSString stringWithFormat:format, value];
}

+(NSString*)stringWithInterger:(NSInteger)value{
    return [NSString stringWithFormat:@"%ld", (long)value];
}
+(NSString*)stringWithLongLong:(long long)value{
    return [NSString stringWithFormat:@"%lld", value];
}

@end
