# LXBChooseDateView
## ☆☆☆ iOS日历、日期选择 ☆☆☆

#### 支持pod导入

> pod 'LXBChooseDateView','~> 1.0.0'

如果发现pod search LXBChooseDateView 搜索出来的不是最新版本，需要在终端执行cd转换文件路径命令退回到desktop，然后执行pod setup命令更新本地spec缓存（可能需要几分钟），然后再搜索就可以了

<img src="https://raw.githubusercontent.com/lianxingbo/LXBChooseDateView/master/DemoGif.gif"  width=200 height=350 />

```
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

```
