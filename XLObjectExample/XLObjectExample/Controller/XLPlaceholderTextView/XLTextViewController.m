//
//  XLTextViewController.m
//  XLObjectExample
//
//  Created by GDXL2012 on 2020/1/18.
//  Copyright © 2020 GDXL2012. All rights reserved.
//

#import "XLTextViewController.h"
#import "XLTextView.h"

@interface XLTextViewController ()

@property (nonatomic, strong) XLTextView *placeholderTextView;

@end

@implementation XLTextViewController

-(void)viewDidLoad{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor lightGrayColor];
    CGRect frame = [UIScreen mainScreen].bounds;
    CGFloat leftMagin = 15.0f;
    _placeholderTextView = [[XLTextView alloc] initWithFrame:CGRectMake(leftMagin, 150.0f, frame.size.width - leftMagin * 2, 150.0f)];
    [self.view addSubview:_placeholderTextView];
    
    _placeholderTextView.textColor = [UIColor blackColor];
    _placeholderTextView.placeholderColor = [UIColor grayColor];
    _placeholderTextView.placeholder = @"请输入文本";
}

@end
