//
//  LXBChooseDateView.h
//  calender
//
//  Created by 连兴博 on 2016/6/13.
//  Copyright © 2016年 大博哥. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NSDate+DaboExtension.h"
#import "UIView+LayoutMethods.h"

typedef void(^CalendarBlock)(NSMutableArray *selectDateBtnArr);

typedef void(^ChangeMonthBlock)(NSDate *date);

@interface LXBChooseDateView : UIView

@property (nonatomic, strong) NSDate *date;//显示的时间

@property (nonatomic, strong) NSArray *unAvailableArr;//不可选日期

@property (nonatomic, strong) NSMutableDictionary *chooseDateDict;//已选择的日期

@property (nonatomic, copy) ChangeMonthBlock changeMonthBlock;//月份改变回调

@property (nonatomic, copy) CalendarBlock calendarBlock;//返回选择的日期数组

@end
