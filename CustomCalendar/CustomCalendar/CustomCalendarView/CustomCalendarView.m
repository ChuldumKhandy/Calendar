//
//  CalenderView.m
//  Calendar
//
//  Created by user on 23.04.2022.
//

#import <Foundation/Foundation.h>
#import "CustomCalendarView.h"
#import "CustomDaysOfWeekView.h"
#import "CustomMonthView.h"
#import "DayCell.h"

@interface CustomCalendarView () <MonthViewProtocol> {
    NSMutableArray *numOfDaysInMonth;
    NSInteger currentMonthIndex;
    NSInteger currentYear;
    NSInteger presentMonthIndex;
    NSInteger presentYear;
    NSInteger todaysDate;
    NSInteger firstWeekDayOfMonth;
    
    UICollectionView *daysCollectionView;
    CustomDaysOfWeekView *weekView;
    CustomMonthView *monthView;
}

@end

@implementation CustomCalendarView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        numOfDaysInMonth = [NSMutableArray array];
        [numOfDaysInMonth addObject:[NSNumber numberWithInt:31]];
        [numOfDaysInMonth addObject:[NSNumber numberWithInt:28]];
        [numOfDaysInMonth addObject:[NSNumber numberWithInt:31]];
        [numOfDaysInMonth addObject:[NSNumber numberWithInt:30]];
        [numOfDaysInMonth addObject:[NSNumber numberWithInt:31]];
        [numOfDaysInMonth addObject:[NSNumber numberWithInt:30]];
        [numOfDaysInMonth addObject:[NSNumber numberWithInt:31]];
        [numOfDaysInMonth addObject:[NSNumber numberWithInt:31]];
        [numOfDaysInMonth addObject:[NSNumber numberWithInt:30]];
        [numOfDaysInMonth addObject:[NSNumber numberWithInt:31]];
        [numOfDaysInMonth addObject:[NSNumber numberWithInt:30]];
        [numOfDaysInMonth addObject:[NSNumber numberWithInt:31]];
        [self setupView];
        [self setBackgroundColor: UIColor.clearColor];
    }
     return self;
}

-(void)setupView{
    [self currentDate];

    monthView = ^CustomMonthView*() {
        CustomMonthView *view = [[CustomMonthView alloc] initWithFrame: CGRectZero];
        view.translatesAutoresizingMaskIntoConstraints = FALSE;
        return view;
    }();
    
    weekView = ^CustomDaysOfWeekView*(){
        CustomDaysOfWeekView *view = [[CustomDaysOfWeekView alloc] initWithFrame: CGRectZero];
        view.translatesAutoresizingMaskIntoConstraints = FALSE;
        return view;
    }();
    
    daysCollectionView = ^UICollectionView*(){
        UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout alloc];
        layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
        
        UICollectionView *collection = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        collection.showsHorizontalScrollIndicator = FALSE;
        [collection setBackgroundColor:UIColor.clearColor];
        collection.allowsMultipleSelection = FALSE;
        collection.translatesAutoresizingMaskIntoConstraints = FALSE;
        return collection;
    }();
    
    [self addSubview: monthView];
    [self addSubview: weekView];
    [self addSubview: daysCollectionView];
    [monthView.topAnchor constraintEqualToAnchor:self.topAnchor].active = YES;
    [monthView.heightAnchor constraintEqualToConstant:35].active = YES;
    [monthView.leadingAnchor constraintEqualToAnchor:self.leadingAnchor].active = YES;
    [monthView.trailingAnchor constraintEqualToAnchor:self.trailingAnchor].active = YES;
    monthView.delegate = self;
    
    [weekView.topAnchor constraintEqualToAnchor:monthView.bottomAnchor].active = YES;
    [weekView.heightAnchor constraintEqualToConstant:30].active = YES;
    [weekView.leadingAnchor constraintEqualToAnchor:self.leadingAnchor].active = YES;
    [weekView.trailingAnchor constraintEqualToAnchor:self.trailingAnchor].active = YES;
    
    [daysCollectionView.topAnchor constraintEqualToAnchor:weekView.bottomAnchor].active = YES;
    [daysCollectionView.bottomAnchor constraintEqualToAnchor:self.bottomAnchor].active = YES;
    [daysCollectionView.leadingAnchor constraintEqualToAnchor:self.leadingAnchor].active = YES;
    [daysCollectionView.trailingAnchor constraintEqualToAnchor:self.trailingAnchor].active = YES;
    [daysCollectionView setDataSource:self];
    [daysCollectionView setDelegate:self];
    [daysCollectionView registerClass: [DayCell class] forCellWithReuseIdentifier:@"DayCellIdentifier"];
}

-(void)currentDate{
    NSDate *date = NSDate.now;
    NSCalendar *calendar = NSCalendar.currentCalendar;
    NSDateComponents *components = [calendar components: (NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit) fromDate:date];
    todaysDate = components.day;
    currentMonthIndex = components.month;
    currentYear = components.year;
    firstWeekDayOfMonth = [self getFirstWeekDay];
    
    //for leap years, make february month of 29 days
    if ((currentMonthIndex == 2) && (currentYear % 4 == 0)) {
        numOfDaysInMonth[currentMonthIndex-1] = [NSNumber numberWithInt:29];
    }
    //end
    presentMonthIndex = currentMonthIndex;
    presentYear = currentYear;
}

-(NSInteger *)getFirstWeekDay{
    NSString *dateString = [NSString stringWithFormat:@"%ld-%ld-01", (long)currentYear, (long)currentMonthIndex];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *date = [dateFormatter dateFromString:dateString];
    
    NSCalendar *calendar = NSCalendar.currentCalendar;
    NSDateComponents *components = [calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth) fromDate:date];
    NSDate *dateWeekDay = [calendar dateFromComponents:components];
    NSInteger *day = [calendar component: NSCalendarUnitWeekday fromDate:dateWeekDay];
    
    return day;
}

-(BOOL)checkDateActivites:(NSInteger *)currentDay :(NSInteger *)currentMonth :(NSInteger *)currentYear{
    NSMutableArray *dates =[[NSMutableArray alloc]init];
    [dates addObject:@"2022-01-01"];
    [dates addObject:@"2022-02-06"];
    [dates addObject:@"2022-03-18"];
    [dates addObject:@"2022-03-20"];
    [dates addObject:@"2022-03-30"];
    [dates addObject:@"2022-04-01"];
    [dates addObject:@"2022-04-04"];
    [dates addObject:@"2022-04-07"];
    
    NSString *currentDateString = [NSString stringWithFormat:@"%i-%i-%i", currentYear, currentMonth, currentDay];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *currentDate = [dateFormatter dateFromString:currentDateString];
    
    for (int index = 0; index < dates.count; index++) {
        NSDate *activityDate = [dateFormatter dateFromString:dates[index]];
        if (currentDate == activityDate) {
            return TRUE;
        }
    }
    return FALSE;
}


#pragma mark - MonthViewProtocol
- (void)didChangeMonth:(NSInteger *)monthIndex :(NSInteger *)year{
    NSInteger calMonth = monthIndex;
    NSInteger calYear = year;
    
    currentMonthIndex = calMonth + 1;
    currentYear = calYear;
    
    //for leap year, make february month of 29 days
    if (calMonth == 1) {
        if (currentYear % 4 == 0) {
            numOfDaysInMonth[calMonth] = [NSNumber numberWithInt:29];
        } else {
            numOfDaysInMonth[calMonth] = [NSNumber numberWithInt:28];
        }
    }
    //end
    
    firstWeekDayOfMonth = [self getFirstWeekDay];
    [daysCollectionView reloadData];
}


#pragma mark - Collection View data source, delegate

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    NSInteger daysInMonth = [numOfDaysInMonth[currentMonthIndex - 1] integerValue];
    return daysInMonth + firstWeekDayOfMonth - 1;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    DayCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"DayCellIdentifier" forIndexPath:indexPath];
    
    if (indexPath.item <= firstWeekDayOfMonth - 2) {
        [cell setHidden: TRUE];
    } else {
        NSInteger calcDate = indexPath.row - firstWeekDayOfMonth + 2;
        [cell setHidden: FALSE];
        cell.dateLabel.text = [NSString stringWithFormat:@"%i", calcDate];
        if ([self checkDateActivites:calcDate :currentMonthIndex :currentYear]) {
            [cell setBackgroundColor: UIColor.cyanColor];
        } else {
            [cell setBackgroundColor: UIColor.clearColor];
        }
    }
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(collectionView.frame.size.width / 7 - 7, collectionView.frame.size.width / 7 - 7);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 8.0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 8.0;
}

@end
