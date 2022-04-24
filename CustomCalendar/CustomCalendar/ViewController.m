//
//  ViewController.m
//  CustomCalendar
//
//  Created by user on 24.04.2022.
//

#import "ViewController.h"
#import "CustomCalendarView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CustomCalendarView *calendar = [[CustomCalendarView alloc] initWithFrame: CGRectMake(50, 300, 300, 300)];
    [self.view addSubview: calendar];
}


@end
