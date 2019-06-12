//
//  XLButton.m
//  XLXLFamily
//
//  Created by liyj on 2018/9/18.
//  Copyright © 2018年 xuelan. All rights reserved.
//

#import "XLButton.h"
#import "NSString+XLCategory.h"
#import <objc/runtime.h>

// 全局变量，用于按钮点击判断
static CGFloat xlSingleClickButtonTimeInterval = 0;

@interface XLButton ()

@property (nonatomic, assign) NSTimeInterval lastClickTimestamp;    // 最近一次点击时间戳

@end

@implementation XLButton

// 可以在load方法中调用
//+(void)load{
//    [XLButton globalSingleClickButton];
//}

+(instancetype)buttonWithColor:(UIColor *)color{
    XLButton *button = [super buttonWithType:UIButtonTypeCustom];
    button.backgroundColor = color;
    return button;
}

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self xlInitViewData];
    }
    return self;
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self xlInitViewData];
    }
    return self;
}

-(void)xlInitViewData{
    _lastClickTimestamp = 0.0f;
}


/**
 避免title显示nil等异常情况

 @param title <#title description#>
 @param state <#state description#>
 */
-(void)setTitle:(NSString *)title forState:(UIControlState)state{
    if ([NSString isNilString:title]) {
        title = @"";
    }
    [super setTitle:title forState:state];
}

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
        Method sendMethod   = class_getInstanceMethod([XLButton class], sendSel);
        Method xlSendmethod = class_getInstanceMethod([XLButton class], xlSendSel);
        method_exchangeImplementations(sendMethod, xlSendmethod);
    });
}

/**
 配置单次点击按钮间隔:x需要继承至XLSingleClickButton才会有效
 */
+(void)singleClickButtonWithTimeInterval:(CGFloat)interval{
    xlSingleClickButtonTimeInterval = interval;
}

/**
 重要：该方法一定要实现，否则替换的就是父类UIButton中的方法，
 则系统中其他继承自UIButton的类可能也会执行xlSendAction:to:forEvent:方法导致访问xlButtonClickAble出现异常

 @param action <#action description#>
 @param target <#target description#>
 @param event <#event description#>
 */
-(void)sendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event{
    [super sendAction:action to:target forEvent:event];
}

/**
 全局按钮配置后，用于替换按钮自身的 sendAction:to:forEvent: 方法

 @param action <#action description#>
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
