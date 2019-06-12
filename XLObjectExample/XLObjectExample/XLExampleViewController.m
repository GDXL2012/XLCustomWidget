//
//  ViewController.m
//  XLObjectExample
//
//  Created by GDXL2012 on 2019/5/24.
//  Copyright © 2019 GDXL2012. All rights reserved.
//

#import "XLExampleViewController.h"

@interface XLExampleViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, copy) NSArray *dataSource;

@property (nonatomic, strong) UITableView *xlTableView;
@end

@implementation XLExampleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initViewData];
    [self initViewDisplay];
}

-(void)initViewData{
    _dataSource = @[@[@"单点按钮", @"XLSingleClickButtonController"],
                    @[@"XLSingleClick", @"XLSingleClickButtonController"]];
}

-(void)initViewDisplay{
    self.title = @"XLCustomWidget";
    
    _xlTableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _xlTableView.delegate = self;
    _xlTableView.dataSource = self;
    _xlTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [self.view addSubview:_xlTableView];
    _xlTableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    CGFloat xlScreenWidth = [UIScreen mainScreen].bounds.size.width;
    CGRect minRect = CGRectMake(0, 0, xlScreenWidth, CGFLOAT_MIN);
    _xlTableView.tableHeaderView = [[UIView alloc] initWithFrame:minRect];
    _xlTableView.tableFooterView = [[UIView alloc] initWithFrame:minRect];
    
    // iOS 11 适配
    if(@available(iOS 11.0, *)) {
        _xlTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        _xlTableView.estimatedRowHeight = 0;
        _xlTableView.estimatedSectionFooterHeight = 0;
        _xlTableView.estimatedSectionHeaderHeight = 0;
    }
    self.automaticallyAdjustsScrollViewInsets = NO;
    if([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]){
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
}

#pragma mark - UITableViewDelegate, UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 45.0f;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"UITableViewCellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    NSArray *dataArray = self.dataSource[indexPath.row];
    NSString *title = dataArray[0];
    cell.textLabel.text = title;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    NSArray *dataArray = self.dataSource[indexPath.row];
    NSString *controllerName = dataArray[1];
    UIViewController * controller =[[NSClassFromString(controllerName) alloc] init];
    controller.hidesBottomBarWhenPushed = NO;
    [self.navigationController pushViewController:controller animated:YES];
}

@end
