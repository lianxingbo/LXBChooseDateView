//
//  NSDate+DaboExtension.h
//  NSDateDemo
//
//  Created by lianxingbo on 15/8/20.
//  Copyright (c) 2015年 daboge. All rights reserved.
//

//  参考
//  iOS开发之格式化日期时间 http://www.cnblogs.com/Cristen/p/3599922.html
//  时间与日期处理 http://www.cnblogs.com/wayne23/archive/2013/03/25/2981009.html

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger,NSDateFmtWithFormatter)
{
    NSDateFmtYYYYMM,                // @"YYYY-MM"
    NSDateFmtYYYYMMdd,              // @"YYYY-MM-dd"
    NSDateFmtYYYYMMddHHmmss,        // @"YYYY-MM-dd HH:mm:ss"
    NSDateFmtMMddHHmm,              // @"MM-dd HH:mm"
    NSDateFmtHHmm,                  // @"HH:mm"
    NSDateFmtYYMMChinese,           // @"YY年MM月"
    NSDateFmtMMddHHmmChinese,       // @"MM月dd日 HH:mm"
    NSDateFmtYYYYMMddHHmmChiness,   // @"YYYY年MM月dd日 HH:mm"
};

@interface NSDate (DaboExtension)

//是否为今年
- (BOOL)isThisYear;

//是否为本月
- (BOOL)isThisMonth;

//是否为昨天
- (BOOL)isYesterday;

//是否为今天
- (BOOL)isToday;

//是否为明天
- (BOOL)isTomorrow;

//判断与某一天是否为同一天
- (BOOL)sameDayWithDate:(NSDate *)otherDate;

//判断与某一天是否为同一周
- (BOOL)sameWeekWithDate:(NSDate *)otherDate;

//判断与某一天是否为同一月
- (BOOL)sameMonthWithDate:(NSDate *)otherDate;

//判断与某一天是否为同一年
- (BOOL)sameYearWithDate:(NSDate *)otherDate;

//  -------------------------- Compare ---------------------------

//两个时间比较返回NSDateComponents
+ (NSDateComponents *)dateComponents:(NSCalendarUnit)unit fromDate:(NSDate *)fromDate toDate:(NSDate *)toDate;

//两个时间之间相差几天 可以根据需求返回相差几月、几周、几年
+ (int)getDayNumbertoDay:(NSDate *)today beforDay:(NSDate *)beforday;

//  --------------------------NSDate Get---------------------------

//根据年份、月份、日期、小时数、分钟数、秒数返回NSDate
+ (NSDate *)dateWithYear:(NSUInteger)year
                   Month:(NSUInteger)month
                     Day:(NSUInteger)day
                    Hour:(NSUInteger)hour
                  Minute:(NSUInteger)minute
                  Second:(NSUInteger)second;

//NSString转NSDate formatter为枚举
+ (NSDate *)dateFromString:(NSString *)dateString andNSDateFmt:(NSDateFmtWithFormatter)formatter;

//NSDate转NSString formatter为枚举
+ (NSString *)stringFromDate:(NSDate *)date andNSDateFmt:(NSDateFmtWithFormatter)formatter;

//NSString转NSDate formatter为字符串
+ (NSDate *)dateFromString:(NSString *)dateString andNSDateFormatter:(NSString *)formatter;

//NSDate转NSString formatter为字符串
+ (NSString *)stringFromDate:(NSDate *)date andNSDateFormatter:(NSString *)formatter;

//获取年月日时分秒NSDateComponents
- (NSDateComponents *)components;

//获得NSDate的年份
- (NSUInteger)year;

//获得NSDate的月份
- (NSUInteger)month;

//获得NSDate的日期
- (NSUInteger)day;

//获得NSDate的小时数
- (NSUInteger)hour;

//获得NSDate的分钟数
- (NSUInteger)minute;

//获得NSDate的秒数
- (NSUInteger)second;

//获得NSDate对应的星期
- (NSUInteger)weekday;

//获取NSDate对应的星期 以@“周一”、@“周二”方式返回
- (NSString *)weekdayStr;

//获取当天是当年的第几周
- (NSUInteger)weekOfDayInYear;

//获取一小时后的时间
- (NSDate *)oneHourLater;

//获取当前星期 以1.Sun. 2.Mon. 3.Thes. 4.Wed. 5.Thur. 6.Fri. 7.Sat.返回
+ (NSInteger)whatDayTheWeekInt;

//获取当前星期 以@“周一”、@“周二”方式返回
+ (NSString *)whatDayTheWeekStr;

//根据数字返回星期几 以@“周一”、@“周二”方式返回
+ (NSString *)getWeekStringFromInteger:(NSInteger)week;

//多久以前 1分钟内 1分钟前 1小时前 1天前等
- (NSString *)whatTimeAgo;

//判断日期是今天,明天,后天,周几
- (NSString *)compareIfTodayWithDate;

//时间日期的描述 凌晨 上午 早晨等
- (NSString *)whatTimeBefore;

//计算当前NSdate有多少天
- (NSUInteger)numberOfDaysInCurrentMonth;

//计算当前NSdate有多少周
- (NSUInteger)numberOfWeeksInCurrentMonth;

//计算当前NSDate当月的第一天是礼拜几 返回1.Sun. 2.Mon. 3.Thes. 4.Wed. 5.Thur. 6.Fri. 7.Sat.
- (NSUInteger)weeklyOrdinality;

//获取当前NSDate月最开始的一天
- (NSDate *)firstDayOfCurrentMonth;

//获取当前NSDate月最后的一天
- (NSDate *)lastDayOfCurrentMonth;

//获取当前NSDate的上一个月
- (NSDate *)dayInThePreviousMonth;

//获取当前NSDate的下一个月
- (NSDate *)dayInTheFollowingMonth;

//获取当前NSDate的前一天
- (NSDate *)dayInThePreviousDay;

//获取当前NSDate的后一天
- (NSDate *)dayInTheFollowingDay;

//获取当前NSDate前/后几个月
- (NSDate *)dayInTheFollowingMonth:(int)month;

//获取当前NSDate前/后几天
- (NSDate *)dayInTheFollowingDay:(int)day;

@end

