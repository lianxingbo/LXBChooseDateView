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
#define kBtnHeight kBtnWidth //*0.83f

@interface LXBChooseDateView()

@property (nonatomic, strong) UIImage *dateImage;
@property (nonatomic, strong) UIImage *dateUnavailableImage;
@property (nonatomic, strong) UIImage *dateAlreadyImage;
@property (nonatomic, strong) UIImage *dateOutOfImage;
@property (nonatomic, strong) UILabel *headLabel;
@property (nonatomic, strong) UIButton *selectBtn;
@property (nonatomic, strong) NSMutableArray *dateBtnArray;
@property (nonatomic, strong) NSMutableArray *selectDateBtnArr;
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
        [self setSize:CGSizeMake(SCREEN_WIDTH, SCREEN_WIDTH/320*295)];
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
    
    UIButton *selectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [selectBtn setSize:CGSizeMake(100, 30)];
    [selectBtn setCenterY:(self.height - selectBtn.height/2)];
    [selectBtn setX:(self.width - selectBtn.width - 10)];
    [selectBtn setTitle:@"可选日期全选" forState:UIControlStateNormal];
    [selectBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [selectBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateSelected];
    [selectBtn setImage:[UIImage imageNamed:@"weigouxuan"] forState:UIControlStateNormal];
    [selectBtn setImage:[UIImage imageNamed:@"yigouxuan"] forState:UIControlStateSelected];
    [selectBtn addTarget:self action:@selector(selectBtnClick:) forControlEvents:UIControlEventTouchUpInside];
//    selectBtn setImageEdgeInsets:(UIEdgeInsets)
    selectBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    selectBtn.adjustsImageWhenHighlighted = NO;
    [self addSubview:selectBtn];
    self.selectBtn = selectBtn;
}

- (void)createCalendarViewWith:(NSDate *)date
{
    NSString *key = [NSDate stringFromDate:date andNSDateFmt:NSDateFmtYYYYMM];
    NSMutableArray *chooseDateDictForArr = [self.chooseDateDict objectForKey:key];
    NSInteger dateDay = date.isThisMonth && date.isThisYear ? date.day - 1 : 0;
    NSInteger choosableInteger = date.numberOfDaysInCurrentMonth - dateDay - self.unAvailableArr.count;
    self.selectBtn.selected = (choosableInteger == chooseDateDictForArr.count);
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
            
            if (date.isThisMonth && date.isThisYear)
            {
                //日期索引 天数所在42个button中的索引
                NSInteger todayIndex = date.day + firstWeekday - 1;
                
                //过期日 例如今天十号  0-9号都是过期的
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

//不显示的日期
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


#pragma mark - event response

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

    NSInteger dateDay = self.date.isThisMonth && self.date.isThisYear ? self.date.day - 1 : 0;
    self.selectBtn.selected = (self.date.numberOfDaysInCurrentMonth - dateDay - self.unAvailableArr.count == self.selectDateBtnArr.count);
    self.calendarBlock(self.selectDateBtnArr);
}

- (void)selectBtnClick:(UIButton *)button
{
    button.selected = !button.selected;
    for (UIButton *btn in self.dateBtnArray){
        if (btn.enabled) {
            btn.selected = button.selected;
        }
    }
    self.calendarBlock(self.selectDateBtnArr);
}

- (NSMutableArray *)selectDateBtnArr{
    if (!_selectDateBtnArr) {
        _selectDateBtnArr = [NSMutableArray array];
    }
    [_selectDateBtnArr removeAllObjects];
    for (UIButton *btn in self.dateBtnArray)
    {
        if (btn.selected)
        {
            NSInteger day = [btn titleForState:UIControlStateNormal].integerValue;
            NSDate *chooseDate = [NSDate dateWithYear:self.date.year Month:self.date.month Day:day Hour:0 Minute:0 Second:0];
            [_selectDateBtnArr addObject:chooseDate];
        }
    }
    return _selectDateBtnArr;
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
            dayButton.layer.cornerRadius = kBtnWidth/2.0;
            dayButton.layer.masksToBounds = YES;
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
    if (!_headLabel)
    {
        _headLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH/9)];
        _headLabel.text = [NSString stringWithFormat:@"%li年%li月",(long)self.date.year,(long)self.date.month];
        _headLabel.font = [UIFont systemFontOfSize:14];
        _headLabel.textAlignment = NSTextAlignmentCenter;
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
        _dateImage = [self imageWithColor:[UIColor whiteColor]];
    }
    return _dateImage;
}

- (UIImage *)dateUnavailableImage{
    if (!_dateUnavailableImage) {
        _dateUnavailableImage = [self imageWithColor:[UIColor grayColor]];
    }
    return _dateUnavailableImage;
}

- (UIImage *)dateAlreadyImage{
    if (!_dateAlreadyImage) {
        _dateAlreadyImage = [self imageWithColor:[UIColor greenColor]];
    }
    return _dateAlreadyImage;
}

- (UIImage *)dateOutOfImage{
    if (!_dateOutOfImage) {
        _dateOutOfImage = [self imageWithColor:[UIColor colorWithRed:0.83f green:0.83f blue:0.83f alpha:1.00f]];
    }
    return _dateOutOfImage;
}

- (UIColor *)weekDaysColor {
    if (!_weekDaysColor) {
        _weekDaysColor = [UIColor colorWithWhite:0.543 alpha:1.000];
    }
    return _weekDaysColor;
}

- (UIImage *)imageWithColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

@end
