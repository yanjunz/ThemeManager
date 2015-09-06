//
//  ViewController.m
//  ThemeManager
//
//  Created by Yanjun Zhuang on 14/6/15.
//  Copyright (c) 2015 Tencent. All rights reserved.
//

#import "ViewController.h"
#import "ThemeManager.h"
#import "UIView+Theme.h"

@interface ViewController () <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, copy) NSArray *data;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.data = @[@{@"title" : @"Classic", @"image" : @"browser"},
                  @{@"title" : @"Night", @"image" : @"files"},
                  @{@"title" : @"Classic", @"image" : @"hardware"},
                  @{@"title" : @"Night", @"image" : @"downloads"},
                  @{@"title" : @"Classic", @"image" : @"browser"},
                  @{@"title" : @"Night", @"image" : @"files"},
                  @{@"title" : @"Classic", @"image" : @"browser"},
                  @{@"title" : @"Night", @"image" : @"files"}
                  ];
    self.tableView = ({
        UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        tableView.themeMap = @{kThemeMapKeyColorName : @"table_bg"};
        [self.view addSubview:tableView];
        tableView;
    });
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width-100, 100)];
    headerView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    UISlider *slider = [[UISlider alloc] initWithFrame:CGRectMake(0, 0, headerView.frame.size.width - 100, 100)];
    slider.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    slider.maximumValue = 100;
    slider.minimumValue = 10;
    slider.themeMap = @{kThemeMapKeyMinTrackTintColorName : @"slider_min",
                        kThemeMapKeyMaxTrackTintColorName : @"slider_max",};
    [headerView addSubview:slider];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [btn setTitle:@"Change" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(onClickAuto:) forControlEvents:UIControlEventTouchUpInside];
    [headerView addSubview:btn];
    btn.frame = CGRectMake(headerView.frame.size.width - 100, 0, 100, 100);
    btn.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin;
    self.tableView.tableHeaderView = headerView;
    
    /*
     // Test Performance
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 100)];
    footerView.backgroundColor = [UIColor grayColor];
    for (int i = 0; i < 10000; i++) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(i * 20, 10, 20, 50)];
        label.backgroundColor = [UIColor redColor];
        label.themeMap = @{kThemeMapKeyColorName : @"slider_min"};
        label.text = [@(i) stringValue];
        label.hidden = i % 2;
        [footerView addSubview:label];
    }
    self.tableView.tableFooterView = footerView;
     */
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onClickAuto:(id)sender
{
    NSDate *date = [NSDate date];
    NSInteger skinID = [ThemeManager sharedInstance].skinInstance.skinID;
    skinID = (skinID == THEME_STYLE_CLASSIC ? THEME_STYLE_NIGHT : THEME_STYLE_CLASSIC);
    [[ThemeManager sharedInstance] switchToStyleByID:skinID];
    NSTimeInterval interval = [[NSDate date] timeIntervalSinceDate:date];
    NSLog(@"Time: %f", interval);
}

#pragma mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"cellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.backgroundColor = [UIColor clearColor];
    }
    NSDictionary *item = self.data[indexPath.row];
    NSString *imageName = item[@"image"];
    imageName = [NSString stringWithFormat:@"tabbar_%@", imageName];
    
    cell.textLabel.text = item[@"title"];
    
    // Apply theme text color for textLabel
    cell.textLabel.themeMap = @{kThemeMapKeyColorName : @"left_tabbar_cell_title"};
    // Apply theme image for imageView
    cell.imageView.themeMap = @{kThemeMapKeyImageName : imageName};
    
    return cell;
}

#pragma mark UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row % 2 == 0) {
        [[ThemeManager sharedInstance] switchToStyleByID:THEME_STYLE_CLASSIC];
    }
    else {
        [[ThemeManager sharedInstance] switchToStyleByID:THEME_STYLE_NIGHT];
    }
}

@end
