//
//  NSString+XLCategory.h
//  XLXLFamily
//
//  Created by liyj on 2018/5/31.
//  Copyright © 2018年 xuelan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (XLCategory)

/**
 是否为空字符串：不过滤空格

 @param string <#string description#>
 @return <#return value description#>
 */
+(BOOL)isNilString:(NSString *)string;

/**
 是否为空字符串：不过滤空格, 字符串长度
 
 @param string <#string description#>
 @return <#return value description#>
 */
+(BOOL)isEmptyString:(NSString *)string;

/**
 字符串是否为空
 
 @param string 目标字符串
 @return YES 空
 */
+(BOOL)isEmpty:(NSString *)string;

/**
 手机号码过滤特殊字符

 @param phone <#phone description#>
 @return <#return value description#>
 */
+(NSString *)filterCharacterForPone:(NSString *)phone;

/** 数字转字符串 */
+(NSString*)stringWithInt:(int)value;
+(NSString*)stringWithLong:(long)value;
+(NSString*)stringWithFloat:(float)value;
// 只支持0-4位
+(NSString*)stringWithFloat:(float)value decimal:(long)decimal;
+(NSString*)stringWithDouble:(double)value;
// 只支持0-4位
+(NSString*)stringWithDouble:(double)value decimal:(long)decimal;
+(NSString*)stringWithInterger:(NSInteger)value;
+(NSString*)stringWithLongLong:(long long)value;

@end
