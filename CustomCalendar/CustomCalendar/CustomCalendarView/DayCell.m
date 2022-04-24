//
//  DayCell.m
//  CustomCalendar
//
//  Created by user on 24.04.2022.
//

#import "DayCell.h"

@implementation DayCell

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.layer.cornerRadius = frame.size.height / 2;
        self.layer.masksToBounds = TRUE;
        
        self.dateLabel = ^UILabel*(){
            UILabel *lbl = [[UILabel alloc] initWithFrame: CGRectZero];
            lbl.text = @"0";
            lbl.textAlignment = NSTextAlignmentCenter;
            [lbl setTextColor:UIColor.blackColor];
            lbl.translatesAutoresizingMaskIntoConstraints = FALSE;
            return lbl;
        }();
        
        [self.contentView addSubview: self.dateLabel];
        [self.dateLabel.centerYAnchor constraintEqualToAnchor:self.centerYAnchor].active = YES;
        [self.dateLabel.centerXAnchor constraintEqualToAnchor:self.centerXAnchor].active = YES;
        
    }
    return self;
}


@end
