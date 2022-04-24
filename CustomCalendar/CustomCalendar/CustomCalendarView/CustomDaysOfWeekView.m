//
//  CustomDaysOfWeekView.m
//  CustomCalendar
//
//  Created by user on 24.04.2022.
//

#import "CustomDaysOfWeekView.h"

@interface CustomDaysOfWeekView () {
    UIStackView *daysOfWeekStackView;
}

@end

@implementation CustomDaysOfWeekView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupView];
        [self setBackgroundColor: UIColor.clearColor];
    }
     return self;
}

-(void)setupView{
    daysOfWeekStackView = ^UIStackView*() {
        UIStackView *sv = [[UIStackView alloc] initWithFrame: CGRectZero];
        sv.spacing = 8.0;
        sv.distribution = UIStackViewDistributionFillEqually;
        sv.translatesAutoresizingMaskIntoConstraints = FALSE;
        return sv;
    }();
    
    UILabel *suLabel = ^UILabel*() {
        UILabel *lbl = [[UILabel alloc] initWithFrame: CGRectZero];
        lbl.text = @"Su";
        lbl.textAlignment = NSTextAlignmentCenter;
        [lbl setTextColor:UIColor.blackColor];
        return lbl;
    }();
    UILabel *moLabel = ^UILabel*() {
        UILabel *lbl = [[UILabel alloc] initWithFrame: CGRectZero];
        lbl.text = @"Mo";
        lbl.textAlignment = NSTextAlignmentCenter;
        [lbl setTextColor:UIColor.blackColor];
        return lbl;
    }();
    UILabel *tuLabel = ^UILabel*() {
        UILabel *lbl = [[UILabel alloc] initWithFrame: CGRectZero];
        lbl.text = @"Tu";
        lbl.textAlignment = NSTextAlignmentCenter;
        [lbl setTextColor:UIColor.blackColor];
        return lbl;
    }();
    UILabel *weLabel = ^UILabel*() {
        UILabel *lbl = [[UILabel alloc] initWithFrame: CGRectZero];
        lbl.text = @"We";
        lbl.textAlignment = NSTextAlignmentCenter;
        [lbl setTextColor:UIColor.blackColor];
        return lbl;
    }();
    UILabel *thLabel = ^UILabel*() {
        UILabel *lbl = [[UILabel alloc] initWithFrame: CGRectZero];
        lbl.text = @"Th";
        lbl.textAlignment = NSTextAlignmentCenter;
        [lbl setTextColor:UIColor.blackColor];
        return lbl;
    }();
    UILabel *frLabel = ^UILabel*() {
        UILabel *lbl = [[UILabel alloc] initWithFrame: CGRectZero];
        lbl.text = @"Fr";
        lbl.textAlignment = NSTextAlignmentCenter;
        [lbl setTextColor:UIColor.blackColor];
        return lbl;
    }();
    UILabel *saLabel = ^UILabel*() {
        UILabel *lbl = [[UILabel alloc] initWithFrame: CGRectZero];
        lbl.text = @"Sa";
        lbl.textAlignment = NSTextAlignmentCenter;
        [lbl setTextColor:UIColor.blackColor];
        return lbl;
    }();
    [daysOfWeekStackView addArrangedSubview:suLabel];
    [daysOfWeekStackView addArrangedSubview:moLabel];
    [daysOfWeekStackView addArrangedSubview:tuLabel];
    [daysOfWeekStackView addArrangedSubview:weLabel];
    [daysOfWeekStackView addArrangedSubview:thLabel];
    [daysOfWeekStackView addArrangedSubview:frLabel];
    [daysOfWeekStackView addArrangedSubview:saLabel];
    
    [self addSubview: daysOfWeekStackView];
    [daysOfWeekStackView.topAnchor constraintEqualToAnchor:self.topAnchor].active = YES;
    [daysOfWeekStackView.bottomAnchor constraintEqualToAnchor:self.bottomAnchor].active = YES;
    [daysOfWeekStackView.leadingAnchor constraintEqualToAnchor:self.leadingAnchor].active = YES;
    [daysOfWeekStackView.trailingAnchor constraintEqualToAnchor:self.trailingAnchor].active = YES;
}

@end
