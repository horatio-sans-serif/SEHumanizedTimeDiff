//
//  NSDate+HumanizedTime.m
//  HumanizedTimeDemo
//
//  Created by Sarp Erdag on 2/29/12.
//  Copyright (c) 2012 Sarp Erdag. All rights reserved.
//

#import "NSDate+HumanizedTime.h"

static NSString * const SEHumanizedTimeTable = @"Localizable";

@implementation NSDate (HumanizedTime)

- (NSBundle *)_SEHumanizedTimeBundle {
    NSString* path = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"SEHumanizedTime.bundle"];
    return [NSBundle bundleWithPath:path];
}

- (NSString *) stringWithHumanizedTimeDifference {
    
    NSTimeInterval timeInterval = [self timeIntervalSinceNow];
    
    int secondsInADay = 3600*24;
    int secondsInAYear = 3600*24*365;
    int yearsDiff = abs(timeInterval/secondsInAYear); 
    int daysDiff = abs(timeInterval/secondsInADay);
    int hoursDiff = abs((abs(timeInterval) - (daysDiff * secondsInADay)) / 3600);
    int minutesDiff = abs((abs(timeInterval) - ((daysDiff * secondsInADay) + (hoursDiff * 60))) / 60);
    //int secondsDiff = (abs(timeInterval) - ((daysDiff * secondsInADay) + (hoursDiff * 3600) + (minutesDiff * 60)));
    
    NSString *positivity = [NSString stringWithFormat:@"%@", timeInterval < 0 ? NSLocalizedStringFromTableInBundle(@"AgoKey", SEHumanizedTimeTable, [self _SEHumanizedTimeBundle], nil):NSLocalizedStringFromTableInBundle(@"LaterKey", SEHumanizedTimeTable, [self _SEHumanizedTimeBundle], nil)];
    
    
    //Some languages don't need whitespeces between words.
    NSArray *languagesWithNoSpace = [NSArray arrayWithObjects:@"zh-Hans",@"ja", nil];
    NSString* spaceBetweenWords = @" ";
    for (NSString* languageWithNoSpace in languagesWithNoSpace) {
        if ([[[NSLocale preferredLanguages] objectAtIndex:0] isEqualToString:languageWithNoSpace]) {
            spaceBetweenWords = @"";
        }
    }
    
    if (yearsDiff > 1)
        return [NSString stringWithFormat:@"%d%@%@%@%@", yearsDiff, spaceBetweenWords, NSLocalizedStringFromTableInBundle(@"YearsKey", SEHumanizedTimeTable, [self _SEHumanizedTimeBundle], nil), spaceBetweenWords, positivity];
    else if (yearsDiff == 1)
        return [NSString stringWithFormat:@"%@%@%@", NSLocalizedStringFromTableInBundle(@"YearKey", SEHumanizedTimeTable, [self _SEHumanizedTimeBundle], nil), spaceBetweenWords, positivity];
    
    if (daysDiff > 0) {
        if (hoursDiff == 0)
            return [NSString stringWithFormat:@"%d%@%@%@%@", daysDiff, spaceBetweenWords, daysDiff == 1 ? NSLocalizedStringFromTableInBundle(@"DayKey", SEHumanizedTimeTable, [self _SEHumanizedTimeBundle], nil):NSLocalizedStringFromTableInBundle(@"DaysKey", SEHumanizedTimeTable, [self _SEHumanizedTimeBundle], nil), spaceBetweenWords, positivity];
        else
            return [NSString stringWithFormat:@"%d%@%@%@%d%@%@%@%@", daysDiff, spaceBetweenWords, daysDiff == 1 ? NSLocalizedStringFromTableInBundle(@"DayKey", SEHumanizedTimeTable, [self _SEHumanizedTimeBundle], nil):NSLocalizedStringFromTableInBundle(@"DaysKey", SEHumanizedTimeTable, [self _SEHumanizedTimeBundle], nil), spaceBetweenWords, hoursDiff, spaceBetweenWords, NSLocalizedStringFromTableInBundle(@"HoursKey", SEHumanizedTimeTable, [self _SEHumanizedTimeBundle], nil), spaceBetweenWords, positivity];
    }
    else {
        if (hoursDiff == 0) {
            if (minutesDiff == 0)
                return [NSString stringWithFormat:@"%@%@%@", NSLocalizedStringFromTableInBundle(@"SecondKey", SEHumanizedTimeTable, [self _SEHumanizedTimeBundle], nil), spaceBetweenWords, positivity];
            else 
                return [NSString stringWithFormat:@"%d%@%@%@%@", minutesDiff, spaceBetweenWords, minutesDiff == 1 ? NSLocalizedStringFromTableInBundle(@"MinuteKey", SEHumanizedTimeTable, [self _SEHumanizedTimeBundle], nil):NSLocalizedStringFromTableInBundle(@"MinutesKey", SEHumanizedTimeTable, [self _SEHumanizedTimeBundle], nil), spaceBetweenWords, positivity];
        }
        else {
            if (hoursDiff == 1)
                return [NSString stringWithFormat:@"%@%@%@%@%@", NSLocalizedStringFromTableInBundle(@"AboutKey", SEHumanizedTimeTable, [self _SEHumanizedTimeBundle], nil), spaceBetweenWords, NSLocalizedStringFromTableInBundle(@"HourKey", SEHumanizedTimeTable, [self _SEHumanizedTimeBundle], nil), spaceBetweenWords, positivity];
            else
                return [NSString stringWithFormat:@"%d%@%@%@%@", hoursDiff, spaceBetweenWords, NSLocalizedStringFromTableInBundle(@"HoursKey", SEHumanizedTimeTable, [self _SEHumanizedTimeBundle], nil), spaceBetweenWords, positivity];
        }
    }
}

@end