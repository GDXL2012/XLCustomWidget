//
//  UIButton+SingleClick.m
//  XLObjectExample
//
//  Created by GDXL2012 on 2019/6/11.
//  Copyright © 2019 GDXL2012. All rights reserved.
//

#import "UIButton+SingleClick.h"
#import <objc/runtime.h>

// 全局变量，用于按钮点击判断
static CGFloat xlSingleClickButtonTimeInterval = 0;

@implementation UIButton (SingleClick)

// 可以在load方法中调用
//+(void)load{
//    [UIButton globalSingleClickButton];
//}

/**
 开启全局按钮单点限制：配置单次点击时间间隔默认1.5s，程序运行期间所有的按钮都将有单次点击限制
 */
+(void)globalSingleClickButton{
    xlSingleClickButtonTimeInterval = 1.5f;
    [self exchangeImplementations];
}

/**
 开启全局按钮单点限制：配置单次点击时间间隔，程序运行期间所有的按钮都将有单次点击限制
 */
+(void)globalSingleClickButtonWithTimeInterval:(CGFloat)interval{
    xlSingleClickButtonTimeInterval = interval;
    [self exchangeImplementations];
}

/**
 方法交换
 */
+(void)exchangeImplementations{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        SEL sendSel     = @selector(sendAction:to:forEvent:);
        SEL xlSendSel   = @selector(xlSendAction:to:forEvent:);
        Method sendMethod   = class_getInstanceMethod([UIButton class], sendSel);
        Method xlSendmethod = class_getInstanceMethod([UIButton class], xlSendSel);
        method_exchangeImplementations(sendMethod, xlSendmethod);
    });
}

// 绑定属性
static const char XLSingleClickTimeIntervalKey = '\0';
-(NSTimeInterval)lastClickTimestamp{
    NSNumber *number = objc_getAssociatedObject(self, &XLSingleClickTimeIntervalKey);
    if (!number) {
        number = [NSNumber numberWithDouble:0];
    }
    return [number doubleValue];
}

-(void)setLastClickTimestamp:(NSTimeInterval)lastClickTimestamp{
    NSNumber *number = [NSNumber numberWithDouble:lastClickTimestamp];
    objc_setAssociatedObject(self, &XLSingleClickTimeIntervalKey, number, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

/**
 重要：该方法一定要实现，否则替换的就是父类UIControl中的方法，
 则系统中其他继承自UIButton的类可能也会执行xlSendAction:to:forEvent:方法导致访问lastClickTimestamp出现异常
 从调试的现象看，UIButton似乎没有重写改方法，添加该方法不会导致Button中方法覆盖，但后续不知是否有问题
 
 @param action <#action description#>
 @param target <#target description#>
 @param event <#event description#>
 */
-(void)sendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event{
    [super sendAction:action to:target forEvent:event];
}

/**
 全局按钮配置后，用于替换按钮自身的 sendAction:to:forEvent: 方法
 
 @param action action description
 @param target <#target description#>
 @param event <#event description#>
 */
-(void)xlSendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event{
    // event.timestamp 系统从开机到事件触发时的时间
    if (self.lastClickTimestamp == event.timestamp) {
        // 时间戳相同，同一个点击事件，不做快速点击判断
        [self xlSendAction:action to:target forEvent:event];
    } else if(event.timestamp - self.lastClickTimestamp > xlSingleClickButtonTimeInterval){
        // 两个事件相隔时间戳大于设置时间
        // 此处如果只是需要屏蔽系统双击或者更多连击的话，也可以判断event事件中UITouch.tapCount点击次数,
        // 屏蔽数值大于1的点击事件
        [self xlSendAction:action to:target forEvent:event];
        // 时间戳更新
        self.lastClickTimestamp = event.timestamp;
    } else {
        // 如果是需要连续两次的点击时间间隔不能超过设定值，则时间戳在此处也需要更新
        // self.lastClickTimestamp = event.timestamp;
        NSLog(@"短时间内多次点击");
    }
}
@end
