//
//  LXBChooseDateView.m
//  calender
//
//  Created by 连兴博 on 2016/6/13.
//  Copyright © 2016年 大博哥. All rights reserved.
//

#import "LXBChooseDateView.h"

#define kLeftBtn 200
#define kRightBtn 200
#define kDateBtnTag 10000
#define kViewGap 10
#define kBtnWidth (SCREEN_WIDTH-110)/7.0f
#define kBtnHeight kBtnWidth*0.83f

@interface LXBChooseDateView()

@property (nonatomic, strong) UIImage *dateImage;
@property (nonatomic, strong) UIImage *dateUnavailableImage;
@property (nonatomic, strong) UIImage *dateAlreadyImage;
@property (nonatomic, strong) UIImage *dateOutOfImage;
@property (nonatomic, strong) UILabel *headLabel;
@property (nonatomic, strong) UIColor *headColor;
@property (nonatomic, strong) UIButton *selectBtn;
@property (nonatomic, strong) NSMutableArray *dateBtnArray;
@property (nonatomic, strong) UIView *weekBg;
@property (nonatomic, strong) UIColor *weekDaysColor;

- (void)createCalendarViewWith:(NSDate *)date;

@end

@implementation LXBChooseDateView

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        [self setSize:CGSizeMake(SCREEN_WIDTH, SCREEN_WIDTH/320*260)];
        self.backgroundColor = [UIColor colorWithRed:0.94f green:0.94f blue:0.94f alpha:1.00f];
        [self setupNextAndLastMonthView];
    }
    return self;
}

- (void)setupNextAndLastMonthView
{
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.frame = CGRectMake(10, 10, 20, 20);
    [leftBtn setImage:[UIImage imageNamed:@"avoidParking_zuo"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(nextAndLastMonth:) forControlEvents:UIControlEventTouchUpInside];
    leftBtn.tag = 888;
    [self addSubview:leftBtn];
    
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(SCREEN_WIDTH - 30, 10, 20, 20);
    [rightBtn setImage:[UIImage imageNamed:@"avoidParking_you"] forState:UIControlStateNormal];
    rightBtn.tag = 999;
    [rightBtn addTarget:self action:@selector(nextAndLastMonth:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:rightBtn];
}

- (void)createCalendarViewWith:(NSDate *)date
{
    NSInteger daysInThisMonth = date.numberOfDaysInCurrentMonth;//date月天数
    NSInteger firstWeekday = date.weeklyOrdinality - 1;//date第一天是周几
    
    for (int i = 0; i < 42; i++)
    {
        UIButton *dayButton = self.dateBtnArray[i];
        NSInteger day = 0;
        
        if (i < firstWeekday || i > firstWeekday + daysInThisMonth - 1)
        {
            [self setStyle_BeyondThisMonth:dayButton];
        }else
        {
            day = i - firstWeekday + 1;
            
            [dayButton setTitle:[NSString stringWithFormat:@"%li", (long)day] forState:UIControlStateNormal];
            
            if (date.isThisMonth && date.isThisMonth)
            {
                NSInteger todayIndex = date.day + firstWeekday - 1;
                
                if (i < todayIndex)
                {
                    [self setStyle_Today:dayButton];
                }else
                {
                    [self setStyle_AfterToday:dayButton];
                }
            }else
            {
                [self setStyle_AfterToday:dayButton];
            }
        }
    }
}

#pragma mark - date button style

- (void)setStyle_BeyondThisMonth:(UIButton *)btn
{
    btn.enabled = NO;
    [btn setTitleColor:[UIColor clearColor] forState:UIControlStateNormal];
    [btn setBackgroundImage:nil forState:UIControlStateNormal];
}

- (void)setStyle_AfterToday:(UIButton *)btn
{
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [btn setTitleColor:[UIColor colorWithWhite:0.316 alpha:1.000] forState:UIControlStateNormal];
    for (NSString *str in self.unAvailableArr)
    {
        if ([str isEqualToString:btn.currentTitle])
        {
            [btn setBackgroundImage:self.dateUnavailableImage forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            btn.enabled = NO;
        }
    }
    
    NSString *key = [NSDate stringFromDate:self.date andNSDateFmt:NSDateFmtYYYYMM];
    
    if ([self.chooseDateDict objectForKey:key])
    {
        for (NSDate *chooseDate in [self.chooseDateDict objectForKey:key])
        {
            if (chooseDate.day == [btn.titleLabel.text integerValue]) {
                btn.selected = YES;
            }
        }
    }
}

- (void)setStyle_Today:(UIButton *)btn
{
    btn.enabled = NO;
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn setBackgroundImage:self.dateOutOfImage forState:UIControlStateNormal];
}


- (void)nextAndLastMonth:(UIButton *)button
{
    if (button.tag == 888)
    {
        if (self.changeMonthBlock)
        {
            if (!self.date.isThisMonth)
            {
                self.changeMonthBlock(self.date.dayInThePreviousMonth);
            }
        }
    }else
    {
        self.changeMonthBlock(self.date.dayInTheFollowingMonth);
    }
}

- (void)logDate:(UIButton *)dayBtn
{
    dayBtn.selected = !dayBtn.selected;
    NSMutableArray *selectDateBtnArr = [NSMutableArray array];;
    for (UIButton *btn in self.dateBtnArray)
    {
        if (btn.selected)
        {
            NSInteger day = [btn titleForState:UIControlStateNormal].integerValue;
            NSDate *chooseDate = [NSDate dateWithYear:self.date.year Month:self.date.month Day:day Hour:0 Minute:0 Second:0];
            [selectDateBtnArr addObject:chooseDate];
        }
    }
    self.calendarBlock(selectDateBtnArr);
}

#pragma mark - Setters and Getters

- (NSMutableArray *)dateBtnArray
{
    if (!_dateBtnArray)
    {
        _dateBtnArray = [NSMutableArray array];
        for (int i = 0; i < 42; i++)
        {
            UIButton *dayButton = [[UIButton alloc] init];
            dayButton.frame = CGRectMake(25 + (kBtnWidth + kViewGap ) * (i % 7), (i / 7) * (kBtnHeight + 7) + self.weekBg.bottom, kBtnWidth, kBtnHeight);
            dayButton.tag = kDateBtnTag + i;
            dayButton.titleLabel.font = [UIFont systemFontOfSize:13.0];
            dayButton.titleLabel.textAlignment = NSTextAlignmentCenter;
            [dayButton setBackgroundImage:self.dateImage forState:UIControlStateNormal];
            [dayButton setBackgroundImage:self.dateAlreadyImage forState:UIControlStateSelected];
            [dayButton setAdjustsImageWhenHighlighted:NO];
            [dayButton addTarget:self action:@selector(logDate:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:dayButton];
            [_dateBtnArray addObject:dayButton];
        }
    }
    return _dateBtnArray;
}

- (UIView *)weekBg
{
    if (!_weekBg)
    {
        _weekBg = [[UIView alloc] init];
        _weekBg.frame = CGRectMake(0, self.headLabel.bottom, SCREEN_WIDTH, 32);
        [self addSubview:_weekBg];
        NSArray *array = @[@"日", @"一", @"二", @"三", @"四", @"五", @"六"];
        for (int i = 0; i < 7; i++)
        {
            UILabel *week = [[UILabel alloc] init];
            week.text = array[i];
            week.font = [UIFont systemFontOfSize:14];
            week.frame = CGRectMake( 25 + (kBtnWidth + kViewGap )* i, 0, kBtnWidth, 32);
            week.textAlignment = NSTextAlignmentCenter;
            week.backgroundColor = [UIColor clearColor];
            week.textColor = self.weekDaysColor;
            [_weekBg addSubview:week];
        }
    }
    return _weekBg;
}

- (UILabel *)headLabel
{
    if (!_headColor)
    {
        _headLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH/9)];
        _headLabel.text = [NSString stringWithFormat:@"%li年%li月",(long)self.date.year,(long)self.date.month];
        _headLabel.font = [UIFont systemFontOfSize:14];
        _headLabel.textAlignment = NSTextAlignmentCenter;
        _headLabel.textColor = self.headColor;
        [self addSubview:_headLabel];
    }
    return _headLabel;
}

- (void)setDate:(NSDate *)date{
    _date = date;
    [self createCalendarViewWith:_date];
}

- (UIImage *)dateImage{
    if (!_dateImage) {
        _dateImage = [UIImage imageNamed:@"avoidParking_kexuan_da"];
    }
    return _dateImage;
}

- (UIImage *)dateUnavailableImage{
    if (!_dateUnavailableImage) {
        _dateUnavailableImage = [UIImage imageNamed:@"avoidParking_bukexuan_da"];
    }
    return _dateUnavailableImage;
}

- (UIImage *)dateAlreadyImage{
    if (!_dateAlreadyImage) {
        _dateAlreadyImage = [UIImage imageNamed:@"avoidParking_yixuan_da"];
    }
    return _dateAlreadyImage;
}

- (UIImage *)dateOutOfImage{
    if (!_dateOutOfImage) {
        _dateOutOfImage = [UIImage imageNamed:@"avoidParking_yiguoqi_da"];
    }
    return _dateOutOfImage;
}


- (UIColor *)headColor{
    if (_headColor) {
        _headColor = [UIColor orangeColor];
    }
    return _headColor;
}

- (UIColor *)weekDaysColor {
    if (!_weekDaysColor) {
        _weekDaysColor = [UIColor colorWithWhite:0.543 alpha:1.000];
    }
    return _weekDaysColor;
}

@end
