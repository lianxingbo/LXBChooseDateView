//
//  ViewController.m
//  calender
//
//  Created by 连兴博 on 2016/6/13.
//  Copyright © 2016年 大博哥. All rights reserved.
//

#import "ViewController.h"
#import "UIView+LayoutMethods.h"
#import "LXBChooseDateView.h"

@interface ViewController ()

@property (nonatomic, strong) UIButton *sureBtn;

@property (nonatomic, strong) NSDate *date;

@property (nonatomic, strong) LXBChooseDateView *lxbChooseDateView;

@property (nonatomic, strong) NSArray *unAvailableArr;

@property (nonatomic, strong) UIView *threeCarsBackView;

@property (nonatomic, strong) UIButton *carNumBackBtn;

@property (nonatomic, strong) NSMutableDictionary *chooseDateDict;

@end

@implementation ViewController

#pragma mark - life cycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"选择日期";
    [self setupCalendarView];
}

#pragma mark - private method

- (void)setupCalendarView
{
    [self.lxbChooseDateView removeFromSuperview];
    LXBChooseDateView *lxbChooseDateView = [[LXBChooseDateView alloc] init];
    [lxbChooseDateView setY:self.threeCarsBackView.bottom];
    lxbChooseDateView.unAvailableArr = self.unAvailableArr;
    lxbChooseDateView.chooseDateDict = self.chooseDateDict;
    lxbChooseDateView.date = self.date;
    [self.view addSubview:lxbChooseDateView];
    self.lxbChooseDateView = lxbChooseDateView;
    
    [self changeSureBtnEnable];
    
    typeof(self) __weak weakSelf = self;
    
    //选择日期回调
    lxbChooseDateView.calendarBlock =  ^(NSMutableArray *chooseDateDict){
        if (chooseDateDict.count)
        {
            NSDate *chooseDate = chooseDateDict.lastObject;
            NSString *selectDateBtnArrKey = [NSDate stringFromDate:chooseDate andNSDateFmt:NSDateFmtYYYYMM];
            [weakSelf.chooseDateDict setObject:chooseDateDict forKey:selectDateBtnArrKey];
        }else{
            NSString *selectDateBtnArrKey = [NSDate stringFromDate:weakSelf.date andNSDateFmt:NSDateFmtYYYYMM];
            [weakSelf.chooseDateDict removeObjectForKey:selectDateBtnArrKey];
        }
        [weakSelf changeSureBtnEnable];
    };
    
    //改变月份回调
    lxbChooseDateView.changeMonthBlock = ^(NSDate *date){
        weakSelf.date = date;
        //这里可以请求数据 更新不可选日期 然后调用setupCalendarView
        [weakSelf setupCalendarView];
    };
}

- (void)changeSureBtnEnable
{
    UIColor *normalColor = [UIColor colorWithRed:0.01f green:0.62f blue:0.91f alpha:1.00f];
    UIColor *highLightColor = [UIColor colorWithRed:0.76f green:0.76f blue:0.76f alpha:1.00f];
    self.sureBtn.backgroundColor = self.chooseDateDict.count ? normalColor : highLightColor;
}

- (void)sureBtnClick
{
    NSLog(@"确认日期\n%@",self.chooseDateDict);
}

#pragma mark - setters and getters

- (UIView *)threeCarsBackView
{
    if (!_threeCarsBackView)
    {
        UIView *threeCarsBackView = [[UIView alloc] initWithFrame:(CGRect){0,64,SCREEN_WIDTH,SCREEN_WIDTH/320*32}];
        threeCarsBackView.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:threeCarsBackView];
        
        NSArray *carImgName = @[@"avoidParking_kexuan_xiao",@"avoidParking_yixuan_xiao",@"avoidParking_bukexuan_xiao"];
        NSArray *carLabelText = @[@"可选",@"已选",@"不可选"];
        
        for (int i = 0; i < 3; i++)
        {
            UIImageView *carImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:carImgName[i]]];
            carImageView.frame = CGRectMake(20+i*(25+40+5+(SCREEN_WIDTH-25*3-40*3-20*2-5*3)/2), 5, 25, 20);
            [threeCarsBackView addSubview:carImageView];
            UILabel *carNameLabel = [[UILabel alloc] initWithFrame:(CGRect){carImageView.right + 5,11,42,12}];
            carNameLabel.font = [UIFont systemFontOfSize:13];
            carNameLabel.textColor = [UIColor lightGrayColor];
            carNameLabel.text = carLabelText[i];
            [threeCarsBackView addSubview:carNameLabel];
        }
        _threeCarsBackView = threeCarsBackView;
    }
    return _threeCarsBackView;
}

- (UIButton *)sureBtn
{
    if (!_sureBtn)
    {
        CGFloat sureBtnHight = 54;
        UIButton *sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        sureBtn.frame = CGRectMake(0, SCREEN_HEIGHT-sureBtnHight, SCREEN_WIDTH, sureBtnHight);
        [sureBtn setTitle:@"确认日期" forState:UIControlStateNormal];
        [sureBtn addTarget:self action:@selector(sureBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [sureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        sureBtn.titleLabel.font = [UIFont systemFontOfSize:17];
        [self.view addSubview:sureBtn];
        _sureBtn = sureBtn;
    }
    return _sureBtn;
}

- (NSMutableDictionary *)chooseDateDict{
    if (!_chooseDateDict) {
        _chooseDateDict = [NSMutableDictionary dictionary];
    }
    return _chooseDateDict;
}

- (NSDate *)date{
    if (!_date) {
        _date = [NSDate date];
    }
    return _date;
}

- (NSArray *)unAvailableArr{
    if (!_unAvailableArr) {
        _unAvailableArr = @[@"11",@"24",@"25",@"5"];
    }
    return _unAvailableArr;
}

@end

