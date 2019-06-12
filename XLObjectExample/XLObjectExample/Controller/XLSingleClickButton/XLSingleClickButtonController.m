//
//  XLSingleClickButtonController.m
//  XLObjectExample
//
//  Created by GDXL2012 on 2019/6/11.
//  Copyright © 2019 GDXL2012. All rights reserved.
//

#import "XLSingleClickButtonController.h"
#import "XLButton.h"
#import "UIColor+XLCategory.h"
#import "XLSingleClickButton.h"
#import "UIButton+SingleClick.h"
#import "UIControl+SingleClick.h"

@interface XLSingleClickButtonController ()
@property (nonatomic, assign) NSInteger buttonClickCount;
@end

@implementation XLSingleClickButtonController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.automaticallyAdjustsScrollViewInsets = NO;
    if([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]){
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
    self.title = @"XLSingleClick";
    
//    [self initViewForXLButton];
//    [self initViewForXLSingleClickButton];
//    [self initViewForButtonCategory];
    [self initViewForUIControlCategory];
}

#pragma mark - Init

-(void)initViewForXLButton{
    [XLButton globalSingleClickButtonWithTimeInterval:4.0f];
    
    XLButton *button = [XLButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"XLButton" forState:UIControlStateNormal];
    button.backgroundColor = [UIColor colorWithHexString:@"19A0F2"];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    CGFloat xlScreenWidth = [UIScreen mainScreen].bounds.size.width;     // 屏幕宽度
    button.frame = CGRectMake(25.0f, 105.0f + 45.0f * 2 + 35.0f * 2, xlScreenWidth - 25.0f * 2, 45.0f);
    [self.view addSubview:button];
    [button addTarget:self action:@selector(xlButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [button addTarget:self action:@selector(xlButton2Click:) forControlEvents:UIControlEventTouchUpInside];
}

-(void)initViewForButtonCategory{
    [UIButton globalSingleClickButtonWithTimeInterval:4.0f];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"UIButtonCategory" forState:UIControlStateNormal];
    button.backgroundColor = [UIColor colorWithHexString:@"19A0F2"];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    CGFloat xlScreenWidth = [UIScreen mainScreen].bounds.size.width;     // 屏幕宽度
    button.frame = CGRectMake(25.0f, 105.0f + 45.0f * 2 + 35.0f * 2, xlScreenWidth - 25.0f * 2, 45.0f);
    [self.view addSubview:button];
    [button addTarget:self action:@selector(xlButtonCategoryClick:) forControlEvents:UIControlEventTouchUpInside];
    [button addTarget:self action:@selector(xlButton2Click:) forControlEvents:UIControlEventTouchUpInside];
}

-(void)initViewForUIControlCategory{
    [UIControl globalSingleClickButtonWithTimeInterval:4.0f];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"UIControlCategory" forState:UIControlStateNormal];
    button.backgroundColor = [UIColor colorWithHexString:@"#19A0F2"];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    CGFloat xlScreenWidth = [UIScreen mainScreen].bounds.size.width;     // 屏幕宽度
    button.frame = CGRectMake(25.0f, 105.0f + 45.0f * 2 + 35.0f * 2, xlScreenWidth - 25.0f * 2, 45.0f);
    [self.view addSubview:button];
    [button addTarget:self action:@selector(xlControlCategoryClick:) forControlEvents:UIControlEventTouchUpInside];
    [button addTarget:self action:@selector(xlButton2Click:) forControlEvents:UIControlEventTouchUpInside];
}

-(void)initViewForXLSingleClickButton{
    [XLSingleClickButton singleClickButtonWithTimeInterval:4.0f];
    
    XLSingleClickButton *button = [XLSingleClickButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"XLSingleClickButton" forState:UIControlStateNormal];
    button.backgroundColor = [UIColor colorWithHexString:@"#19A0F2"];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    CGFloat xlScreenWidth = [UIScreen mainScreen].bounds.size.width;     // 屏幕宽度
    button.frame = CGRectMake(25.0f, 105.0f + 45.0f * 2 + 35.0f * 2, xlScreenWidth - 25.0f * 2, 45.0f);
    [self.view addSubview:button];
    [button addTarget:self action:@selector(xlSingleClickButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [button addTarget:self action:@selector(xlButton2Click:) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark - Click

- (IBAction)xlButtonClick:(XLButton *)sender {
    NSLog(@"xlButtonClick click");
}

- (IBAction)xlSingleClickButtonClick:(XLSingleClickButton *)sender {
    NSLog(@"xlSingleClickButtonClick click");
}

-(void)xlButtonCategoryClick:(UIButton *)button{
    NSLog(@"xlButtonCategoryClick click");
}

-(void)xlControlCategoryClick:(UIButton *)button{
    NSLog(@"xlControlCategoryClick click");
}

-(void)xlButton2Click:(UIButton *)button{
    NSLog(@"xlButton2Click click");
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
