//
//  XLButton.h
//  XLXLFamily
//
//  Created by liyj on 2018/9/18.
//  Copyright © 2018年 xuelan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XLButton : UIButton

+(instancetype)buttonWithColor:(UIColor *)color;

/**
 开启全局按钮单点限制：配置单次点击时间间隔默认1.5s，程序运行期间所有的按钮都将有单次点击限制
 */
+(void)globalSingleClickButton;

/**
 开启全局按钮单点限制：配置单次点击时间间隔，程序运行期间所有的按钮都将有单次点击限制
 */
+(void)globalSingleClickButtonWithTimeInterval:(CGFloat)interval;

@end
