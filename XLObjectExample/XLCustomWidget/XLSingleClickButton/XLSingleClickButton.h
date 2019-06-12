//
//  XLSingleClickButton.h
//  XLFamily
//
//  Created by GDXL2012 on 2019/6/11.
//  Copyright © 2019 xuelan. All rights reserved.
//

#import "XLButton.h"

NS_ASSUME_NONNULL_BEGIN

/**
 单点按钮：避免快速连续点击
 */
@interface XLSingleClickButton : XLButton

/**
 配置单次点击按钮间隔:需要继承至XLSingleClickButton才会有效
 */
+(void)singleClickButtonWithTimeInterval:(CGFloat)interval;

@end

NS_ASSUME_NONNULL_END
