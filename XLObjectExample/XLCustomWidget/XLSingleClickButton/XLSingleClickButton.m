//
//  XLSingleClickButton.m
//  XLFamily
//
//  Created by GDXL2012 on 2019/6/11.
//  Copyright © 2019 xuelan. All rights reserved.
//

#import "XLSingleClickButton.h"
#import "NSString+XLCategory.h"
#import <objc/runtime.h>

// 全局变量，用于按钮点击判断
static CGFloat xlSingleClickButtonTimeInterval;

@interface XLSingleClickButton ()

@property (nonatomic, assign) NSTimeInterval lastClickTimestamp;    // 最近一次点击时间戳

@end

@implementation XLSingleClickButton

// 可以在load方法中调用
//+(void)load{
//    [self singleClickButtonWithTimeInterval:1.5s];
//}

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

-(void)xlInitViewData{
    _lastClickTimestamp = 0.0f;
}

/**
 配置单次点击按钮间隔:需要继承至XLSingleClickButton才会有效
 */
+(void)singleClickButtonWithTimeInterval:(CGFloat)interval{
    xlSingleClickButtonTimeInterval = interval;
}

/**
 覆盖父类方法

 @param action <#action description#>
 @param target <#target description#>
 @param event <#event description#>
 */
-(void)sendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event{
    // event.timestamp 系统从开机到事件触发时的时间
    if (self.lastClickTimestamp == event.timestamp) {
        // 时间戳相同，同一个点击事件，不做快速点击判断
        [super sendAction:action to:target forEvent:event];
    } else if(event.timestamp - self.lastClickTimestamp > xlSingleClickButtonTimeInterval){
        // 两个事件相隔时间戳大于设置时间
        // 此处如果只是需要屏蔽系统双击或者更多连击的话，也可以判断event事件中UITouch.tapCount点击次数,
        // 屏蔽数值大于1的点击事件
        [super sendAction:action to:target forEvent:event];
        // 时间戳更新
        self.lastClickTimestamp = event.timestamp;
    } else {
        // 如果是需要连续两次的点击时间间隔不能超过设定值，则时间戳在此处也需要更新
        // self.lastClickTimestamp = event.timestamp;
        NSLog(@"短时间内多次点击");
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
