//
//  CustomMonthView.h
//  CustomCalendar
//
//  Created by user on 24.04.2022.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol MonthViewProtocol <NSObject>

-(void)didChangeMonth:(NSInteger *) monthIndex :(NSInteger *) year;

@end

@interface CustomMonthView : UIView

@property (weak, nonatomic) id <MonthViewProtocol> delegate;

@end
