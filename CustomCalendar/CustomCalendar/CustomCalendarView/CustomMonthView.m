//
//  CustomMonthView.m
//  CustomCalendar
//
//  Created by user on 24.04.2022.
//

#import "CustomMonthView.h"

@interface CustomMonthView () {
    NSArray <NSString *> *months;
    NSInteger currentMonthIndex;
    NSInteger currentYear;
    
    UILabel *monthLabel;
    UIButton *yearAheadButton;
    UIButton *monthAgoButton;
    UIButton *monthAhead;
}

@end

@implementation CustomMonthView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        months = @[@"January",
                   @"February",
                   @"March",
                   @"April",
                   @"May",
                   @"June",
                   @"July",
                   @"August",
                   @"September",
                   @"October",
                   @"November",
                   @"December"];
        
        [self currentDate];
        [self setupView];
        [self setBackgroundColor: UIColor.blueColor];
    }
     return self;
}

-(void)currentDate{
    NSDate *date = NSDate.now;
    NSCalendar *calendar = NSCalendar.currentCalendar;
    NSDateComponents *components = [calendar components: (NSYearCalendarUnit | NSMonthCalendarUnit) fromDate:date];
    currentMonthIndex = components.month;
    currentYear = components.year;
    
}

-(void)setupView{
    monthLabel = ^UILabel*() {
        UILabel *lbl = [[UILabel alloc] initWithFrame: CGRectZero];
        lbl.text = @"Month";
        [lbl sizeToFit];
        lbl.translatesAutoresizingMaskIntoConstraints = FALSE;
        return lbl;
    }();
    
    yearAheadButton = ^UIButton*(){
        UIButton *btn = [[UIButton alloc] initWithFrame: CGRectZero];
        [btn setTitle:@">" forState:normal];
        [btn setTitleColor:UIColor.blackColor forState:normal];
        [btn addTarget:self action:@selector(tappedYear) forControlEvents:UIControlEventTouchUpInside];
        btn.translatesAutoresizingMaskIntoConstraints = FALSE;
        return btn;
    }();
    
    monthAgoButton = ^UIButton*(){
        UIButton *btn = [[UIButton alloc] initWithFrame: CGRectZero];
        [btn setTitle:@"<" forState:normal];
        [btn setTitleColor:UIColor.blackColor forState:normal];
        [btn addTarget:self action:@selector(tappedMonth) forControlEvents:UIControlEventTouchUpInside];
        btn.translatesAutoresizingMaskIntoConstraints = FALSE;
        return btn;
    }();
    
    monthAhead = ^UIButton*(){
        UIButton *btn = [[UIButton alloc] initWithFrame: CGRectZero];
        [btn setTitle:@">" forState:normal];
        [btn setTitleColor:UIColor.blackColor forState:normal];
        [btn addTarget:self action:@selector(tappedMonth) forControlEvents:UIControlEventTouchUpInside];
        btn.translatesAutoresizingMaskIntoConstraints = FALSE;
        return btn;
    }();
    
    [self addSubview: monthLabel];
    [self addSubview: yearAheadButton];
    [self addSubview: monthAgoButton];
    [self addSubview: monthAhead];
    
    [monthLabel.topAnchor constraintEqualToAnchor:self.topAnchor].active = YES;
    [monthLabel.bottomAnchor constraintEqualToAnchor:self.bottomAnchor].active = YES;
    [monthLabel.leadingAnchor constraintEqualToAnchor:self.leadingAnchor constant:8.0].active = YES;
    
    [yearAheadButton.topAnchor constraintEqualToAnchor:self.topAnchor].active = YES;
    [yearAheadButton.bottomAnchor constraintEqualToAnchor:self.bottomAnchor].active = YES;
    [yearAheadButton.leadingAnchor constraintEqualToAnchor:monthLabel.trailingAnchor].active = YES;
    
    [monthAgoButton.topAnchor constraintEqualToAnchor:self.topAnchor].active = YES;
    [monthAgoButton.bottomAnchor constraintEqualToAnchor:self.bottomAnchor].active = YES;
    [monthAgoButton.trailingAnchor constraintEqualToAnchor:monthAhead.leadingAnchor].active = YES;
    
    [monthAhead.topAnchor constraintEqualToAnchor:self.topAnchor].active = YES;
    [monthAhead.bottomAnchor constraintEqualToAnchor:self.bottomAnchor].active = YES;
    [monthAhead.trailingAnchor constraintEqualToAnchor:self.trailingAnchor].active = YES;
}

-(void)tappedMonth:(UIButton *) sender{
    if (sender == monthAhead){
        currentMonthIndex += 1;
        if (currentMonthIndex > 11) {
            currentMonthIndex = 0;
            currentYear += 1;
        }
    } else {
        currentMonthIndex -= 1;
        if (currentMonthIndex < 0) {
            currentMonthIndex = 11;
            currentYear -= 1;
        }
    }
    
    monthLabel.text = [NSString stringWithFormat:@"%@ %i", months[currentMonthIndex], currentYear];
    [self.delegate didChangeMonth:currentMonthIndex :currentYear];
}

-(void)tappedYear:(UIButton *) sender{
    currentYear += 1;
    monthLabel.text = [NSString stringWithFormat:@"%@ %i", months[currentMonthIndex], currentYear];
    [self.delegate didChangeMonth:currentMonthIndex :currentYear];
}

@end

