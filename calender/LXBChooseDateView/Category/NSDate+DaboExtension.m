//
//  NSDate+DaboExtension.m
//  NSDateDemo
//
//  Created by lianxingbo on 15/8/20.
//  Copyright (c) 2015年 daboge. All rights reserved.
//


#import "NSDate+DaboExtension.h"

@implementation NSDate (DaboExtension)

//是否为今年
- (BOOL)isThisYear
{
    return self.year == [NSDate date].year;
}

//是否为本月
- (BOOL)isThisMonth
{
    return [self.calendar components:NSCalendarUnitMonth|NSCalendarUnitDay fromDate:self.ymdDate toDate:[NSDate date].ymdDate options:0].month == 0;
}

//是否为昨天
- (BOOL)isYesterday
{
    return [self.calendar components:NSCalendarUnitDay fromDate:self.ymdDate toDate:[NSDate date].ymdDate options:0].day == 1;
}

//是否为今天
- (BOOL)isToday
{
    return [self.calendar components:NSCalendarUnitDay fromDate:self.ymdDate toDate:[NSDate date].ymdDate options:0].day == 0;
}

//是否为明天
- (BOOL)isTomorrow
{
    return [self.calendar components:NSCalendarUnitDay fromDate:self.ymdDate toDate:[NSDate date].ymdDate options:0].day == -1;
}

//判断与某一天是否为同一天
- (BOOL)sameDayWithDate:(NSDate *)otherDate
{
    BOOL res = (self.year == otherDate.year && self.month == otherDate.month && self.day == otherDate.day);
    return res;
}

//判断与某一天是否为同一周
- (BOOL)sameWeekWithDate:(NSDate *)otherDate
{
    BOOL res = (self.year == otherDate.year && self.month == otherDate.month && self.weekOfDayInYear == otherDate.weekOfDayInYear);
    return res;
}

//判断与某一天是否为同一月
- (BOOL)sameMonthWithDate:(NSDate *)otherDate
{
    BOOL res = (self.year == otherDate.year && self.month == otherDate.month);
    return res;
}

//判断与某一天是否为同一年
- (BOOL)sameYearWithDate:(NSDate *)otherDate
{
    return self.year == otherDate.year;
}

//  --------------------------NSDate Get---------------------------

//根据年份、月份、日期、小时数、分钟数、秒数返回NSDate
+ (NSDate *)dateWithYear:(NSUInteger)year
                   Month:(NSUInteger)month
                     Day:(NSUInteger)day
                    Hour:(NSUInteger)hour
                  Minute:(NSUInteger)minute
                  Second:(NSUInteger)second
{
    NSDateComponents *dateComponents = [[NSCalendar currentCalendar] components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond fromDate:[NSDate date]];
    dateComponents.year = year;
    dateComponents.month = month;
    dateComponents.day = day;
    dateComponents.hour = hour;
    dateComponents.minute = minute;
    dateComponents.second = second;
    
    return [[NSCalendar currentCalendar] dateFromComponents:dateComponents];
}

//NSString转NSDate formatter为枚举
+ (NSDate *)dateFromString:(NSString *)dateString andNSDateFmt:(NSDateFmtWithFormatter)formatter
{
    return [NSDate dateFromString:dateString andNSDateFormatter:[NSDate formatterStr:formatter]];
}

//NSDate转NSString formatter为枚举
+ (NSString *)stringFromDate:(NSDate *)date andNSDateFmt:(NSDateFmtWithFormatter)formatter
{
    return [NSDate stringFromDate:date andNSDateFormatter:[NSDate formatterStr:formatter]];
}

//NSString转NSDate formatter为字符串
+ (NSDate *)dateFromString:(NSString *)dateString andNSDateFormatter:(NSString *)formatter
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:formatter];
    NSDate *destDate= [dateFormatter dateFromString:dateString];
    return destDate;
}

//NSDate转NSString formatter为字符串
+ (NSString *)stringFromDate:(NSDate *)date andNSDateFormatter:(NSString *)formatter
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:formatter];
    NSString *destDateString = [dateFormatter stringFromDate:date];
    return destDateString;
}

//获得NSDate对应的年份
- (NSUInteger)year
{
    return self.components.year;
}

//获得NSDate对应的月份
- (NSUInteger)month
{
    return self.components.month;
}

//获得NSDate对应的日期
- (NSUInteger)day
{
    return self.components.day;
}

//获得NSDate对应的小时数
- (NSUInteger)hour
{
    return self.components.hour;
}

//获得NSDate对应的分钟数
- (NSUInteger)minute
{
    return self.components.minute;
}

//获得NSDate对应的秒数
- (NSUInteger)second
{
    return self.components.second;
}

//获得NSDate对应的星期
- (NSUInteger)weekday
{
    return self.components.weekday;
}

//获取NSDate对应的星期 以@“周一”、@“周二”方式返回
- (NSString *)weekdayStr
{
    return [NSDate getWeekStringFromInteger:self.weekday];
}

//获取一小时后的时间
- (NSDate *)oneHourLater
{
    return [NSDate dateWithTimeInterval:3600 sinceDate:self];
}

//获取当前星期 以 1、2 方式返回
+ (NSInteger)whatDayTheWeekInt
{
    return [NSDate date].weekday;
}

//获取当前星期 以 @“周一”、@“周二” 方式返回
+ (NSString *)whatDayTheWeekStr
{
    return [NSDate getWeekStringFromInteger:[NSDate date].weekday];
}

//根据传入的数字返回对应的星期 以 @“周一”、@“周二” 方式返回
+ (NSString *)getWeekStringFromInteger:(NSInteger)week
{
    NSString *str_week;
    
    switch (week) {
        case 1:
            str_week = @"周日";
            break;
        case 2:
            str_week = @"周一";
            break;
        case 3:
            str_week = @"周二";
            break;
        case 4:
            str_week = @"周三";
            break;
        case 5:
            str_week = @"周四";
            break;
        case 6:
            str_week = @"周五";
            break;
        case 7:
            str_week = @"周六";
            break;
    }
    
    return str_week;
}

//当天是当年的第几周
- (NSUInteger)weekOfDayInYear
{
    return [self.calendar ordinalityOfUnit:NSCalendarUnitWeekOfYear inUnit:NSCalendarUnitYear forDate:self];
}

//多久以前 1分钟内 1分钟前 1小时前 1天前等
- (NSString *)whatTimeAgo
{
    if (self == nil) {
        return @"";
    }
    NSTimeInterval timeInterval = -[self timeIntervalSinceNow];
    long temp = 0;
    NSString *result;
    if (timeInterval < 60) {
        result = [NSString stringWithFormat:@"1分钟内"];
    } else if ((temp = timeInterval / 60) < 60) {
        result = [NSString stringWithFormat:@"%ld分钟前", temp];
    } else if ((temp = temp / 60) < 24) {
        result = [NSString stringWithFormat:@"%ld小时前", temp];
    } else if ((temp = temp / 24) < 30) {
        result = [NSString stringWithFormat:@"%ld天前", temp];
    } else if ((temp = temp / 30) < 12) {
        result = [NSString stringWithFormat:@"%ld个月前", temp];
    } else {
        temp = temp / 12;
        result = [NSString stringWithFormat:@"%ld年前", temp];
    }
    return result;
}

//判断日期是今天,明天,后天,周几
- (NSString *)compareIfTodayWithDate
{
    NSDate *todate = [NSDate date];//今天
    NSDateComponents *comps_today= todate.components;
    NSDateComponents *comps_other= self.components;
    
    //获取星期对应的数字
    int weekIntValue = (int)self.weekday;
    
    //也可以判断是上一个月 下一个月等
    if (self.isToday) {
        return @"今天";
        
    }else if (comps_today.year == comps_other.year &&
              comps_today.month == comps_other.month &&
              (comps_today.day - comps_other.day) == -1){
        return @"明天";
        
    }else if (comps_today.year == comps_other.year &&
              comps_today.month == comps_other.month &&
              (comps_today.day - comps_other.day) == -2){
        return @"后天";
        
    }else{
        //直接返回当时日期的字符串(这里让它返回空)
        return [NSDate getWeekStringFromInteger:weekIntValue];//周几
    }
}

//时间日期的描述 凌晨 上午 早晨等
- (NSString *)whatTimeBefore
{
    //凌晨(3：00—6：00) 早上(6：00—8：00) 上午(8：00—11：00) 中午(11：00—14：00) 下午(14：00—19：00) 晚上(19：00—24：00)  深夜0：00—3：00) JE准则
    if (self == nil) {
        return @"";
    }
    NSDate *yesterday = [NSDate date].dayInThePreviousDay;
    NSDateComponents *Compareday = self.components;
    NSDateComponents *Yesterday = yesterday.components;
    NSDateComponents *Today = [NSDate date].components;

    NSString *hour = [NSDate stringFromDate:self andNSDateFormatter:@"HH"];
    NSString *minute = [NSDate stringFromDate:self andNSDateFormatter:@"mm"];
    NSString *sunormoon = @"";
    NSInteger Hour = [hour integerValue];
    
    if (Hour >= 3 && Hour < 6) {
        sunormoon = @"凌晨";
    } else if (Hour >= 6 && Hour < 8) {
        sunormoon = @"早上";
    } else if (Hour >= 8 && Hour < 11) {
        sunormoon = @"上午";
    } else if (Hour >= 11 && Hour < 14) {
        sunormoon = @"中午";
    } else if (Hour >= 14 && Hour < 19) {
        sunormoon = @"下午";
    } else if (Hour >= 19 /*&& Hour < 23*/) {
        sunormoon = @"晚上";
    } else if (Hour >= 0 && Hour < 3) {
        sunormoon = @"深夜";
    }
    
    if (Hour > 12) {
        Hour = Hour - 12;
    }
    
    NSString *Mon_Day = [NSDate stringFromDate:self andNSDateFormatter:@"MM-dd"];
    NSString *Hou_Min = [NSString stringWithFormat:@"%@ %d:%@", sunormoon, (int) Hour, minute];
    NSString *Week = self.weekdayStr;
    NSTimeInterval oldtime = [self timeIntervalSince1970];
    NSTimeInterval nowTime = [[NSDate date] timeIntervalSince1970];
    
    if ([[[NSCalendar autoupdatingCurrentCalendar] components:NSCalendarUnitYear fromDate:self] year] != [[[NSCalendar autoupdatingCurrentCalendar] components:NSCalendarUnitYear fromDate:[NSDate date]] year]) {
        Mon_Day = [NSDate stringFromDate:self andNSDateFormatter:self.NSDateFmtYYYYMMdd];
    }
    
    if ([Today day] == [Compareday day]) {
        return [NSString stringWithFormat:@"%@", Hou_Min];
    }
    
    if ([Yesterday day] == [Compareday day]) {
        return [NSString stringWithFormat:@"昨天  %@", Hou_Min];
    }
    
    if ((nowTime - oldtime) / 60 / 60 / 24 >= 7) {
        return [NSString stringWithFormat:@"%@   %@", Mon_Day, Hou_Min];
    }
    
    if ((nowTime - oldtime) / 60 / 60 / 24 < 7) {
        return [NSString stringWithFormat:@"%@  %@", Week, Hou_Min];
    }
    
    return [NSString stringWithFormat:@"%@   %@", Mon_Day, Hou_Min];
}

//计算当前NSDate有多少天
- (NSUInteger)numberOfDaysInCurrentMonth
{
    return [self.calendar rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:self].length;
}

//计算当前NSDate有多少周
- (NSUInteger)numberOfWeeksInCurrentMonth
{
    NSUInteger weekday = [[self firstDayOfCurrentMonth] weeklyOrdinality];
    NSUInteger days = [self numberOfDaysInCurrentMonth];
    NSUInteger weeks = 0;
    
    if (weekday > 1) {
        weeks += 1, days -= (7 - weekday + 1);
    }
    
    weeks += days / 7;
    weeks += (days % 7 > 0) ? 1 : 0;
    
    return weeks;
}

//计算当前NSDate当月的第一天是礼拜几
- (NSUInteger)weeklyOrdinality
{
    NSDate *firstDayOfMonthDate = self.firstDayOfCurrentMonth;
    return firstDayOfMonthDate.weekday;
}

//获取当前NSDate月最开始的一天
- (NSDate *)firstDayOfCurrentMonth
{
    NSDate *startDate = nil;
    BOOL ok = [self.calendar rangeOfUnit:NSCalendarUnitMonth startDate:&startDate interval:NULL forDate:self];
    return ok ? startDate : nil;
}

//获取当前NSDate月最后的一天
- (NSDate *)lastDayOfCurrentMonth
{
    NSCalendarUnit calendarUnit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
    NSDateComponents *dateComponents = [self.calendar components:calendarUnit fromDate:self];
    dateComponents.day = [self numberOfDaysInCurrentMonth];
    return [self.calendar dateFromComponents:dateComponents];
}

//获取当前NSDate的上一个月
- (NSDate *)dayInThePreviousMonth
{
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    dateComponents.month = -1;
    return [self.calendar dateByAddingComponents:dateComponents toDate:self options:0];
}

//获取当前NSDate的下一个月
- (NSDate *)dayInTheFollowingMonth
{
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    dateComponents.month = 1;
    return [self.calendar dateByAddingComponents:dateComponents toDate:self options:0];
}

//获取当前NSDate的前一天
- (NSDate *)dayInThePreviousDay
{
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    dateComponents.day = -1;
    return [self.calendar dateByAddingComponents:dateComponents toDate:self options:0];
}

//获取当前NSDate的后一天
- (NSDate *)dayInTheFollowingDay
{
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    dateComponents.day = 1;
    return [self.calendar dateByAddingComponents:dateComponents toDate:self options:0];
}

//获取当前NSDate前/后几个月   例：month=2  当前时间 2016-10-8 返回 2016-12-8
- (NSDate *)dayInTheFollowingMonth:(int)month
{
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    //这里根据设置month的正负，可以获取NSDate前/后几个月 正为往后 负为往前
    dateComponents.month = month;
    return [self.calendar dateByAddingComponents:dateComponents toDate:self options:0];
}

//获取当前NSDate前/后几天   例：day=2 当前时间 2016-10-8 返回 2016-10-10
- (NSDate *)dayInTheFollowingDay:(int)day
{
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    //这里根据设置day的正负，可以获取NSDate前/后几天 正为往后 负为往前
    dateComponents.day = day;
    return [self.calendar dateByAddingComponents:dateComponents toDate:self options:0];
}

//  -------------------------- Compare ---------------------------

//两个时间比较 根据NSCalendarUnit 返回NSDateComponents
+ (NSDateComponents *)dateComponents:(NSCalendarUnit)unit fromDate:(NSDate *)fromDate toDate:(NSDate *)toDate
{
    return [fromDate.calendar components:unit fromDate:fromDate toDate:toDate options:0];
}

//两个时间之间相差几天 可以根据需求返回相差几月、几周、几年
//+ (int)getDayNumbertoDay:(NSDate *)today beforDay:(NSDate *)beforday
//{
//    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
//    NSDateComponents *components = [calendar components:NSCalendarUnitDay fromDate:today toDate:beforday options:0];
//    //  NSDateComponents *components = [calendar components:NSMonthCalendarUnit|NSDayCalendarUnit fromDate:today toDate:beforday options:0];
//    int day = (int)[components day];//两个日历之间相差多少月//    NSInteger days = [components month];//两个之间相差几月
//    return day;
//}

//  -------------------------- Private Method ---------------------------

//获取年月日时分秒NSDateComponents
- (NSDateComponents *)components
{
    //定义成分
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond | NSCalendarUnitWeekday;
    
    return [self.calendar components:unit fromDate:self];
}

//获取日历
- (NSCalendar *)calendar
{
    return [NSCalendar currentCalendar];
}

//清空时分秒，保留年月日
- (NSDate *)ymdDate
{
    NSString *dateString = [NSDate stringFromDate:self andNSDateFmt:NSDateFmtYYYYMMdd];
    NSDate *date = [NSDate dateFromString:dateString andNSDateFmt:NSDateFmtYYYYMMdd];
    return date;
}

//  -------------------------- Format ---------------------------

/**
 NSDateFmtYYYYMM
 NSDateFmtYYYYMMdd,
 NSDateFmtYYYYMMddHHmmss,
 NSDateFmtMMddHHmm,
 NSDateFmtHHmm,
 NSDateFmtMMddHHmmChinese,
 NSDateFmtYYYYMMddHHmmChiness,
 */

//@“YYYY-MM-dd” 比较常用，单拎出来
- (NSString *)NSDateFmtYYYYMMdd
{
    return [NSDate formatterStr:NSDateFmtYYYYMMdd];
}

//根据NSDateFmtWithFormatter返回对应的格式化字符串
+ (NSString *)formatterStr:(NSDateFmtWithFormatter)NSDateFmt
{
    NSArray *formatterArr = @[
                              @"yyyy-MM",
                              @"yyyy-MM-dd",
                              @"yyyy-MM-dd HH:mm:ss",
                              @"MM-dd HH:mm",
                              @"HH:mm",
                              @"yy年MM月",
                              @"MM月dd日 HH:mm",
                              @"yyyy年MM月dd日 HH:mm"
                              ];
    
    return formatterArr[NSDateFmt];
}

@end

