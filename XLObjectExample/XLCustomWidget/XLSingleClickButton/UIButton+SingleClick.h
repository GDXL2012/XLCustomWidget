//
//  UIButton+SingleClick.h
//  XLObjectExample
//
//  Created by GDXL2012 on 2019/6/11.
//  Copyright © 2019 GDXL2012. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIButton (SingleClick)

/**
 开启全局按钮单点限制：配置单次点击时间间隔默认1.5s，程序运行期间所有的按钮都将有单次点击限制
 */
+(void)globalSingleClickButton;

/**
 开启全局按钮单点限制：配置单次点击时间间隔，程序运行期间所有的按钮都将有单次点击限制
 */
+(void)globalSingleClickButtonWithTimeInterval:(CGFloat)interval;

@end

NS_ASSUME_NONNULL_END
