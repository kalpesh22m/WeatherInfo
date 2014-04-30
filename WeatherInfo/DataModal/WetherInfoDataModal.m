//
//  WetherInfoDataModal.m
//  WeatherInfo
//
//  Created by Kalpesh Mahajan on 29/04/14.
//  Copyright (c) 2014 Kalpesh Mahajan. All rights reserved.
//

#import "WetherInfoDataModal.h"

@implementation WetherInfoDataModal
@synthesize cityName,countryName,dayTemp,eveTemp,humidty,maxTemp,minTemp,morTemp,nightTemp,wehtherDate,wehtherDesc;
-(id)initwithDictionary:(NSDictionary *)data
{
    wehtherDate=[self getDate:[[data valueForKey:@"dt"] doubleValue]];
    humidty=[NSString stringWithFormat:@"%d%%",[[data valueForKey:@"humidity"] integerValue]];
    
    NSDictionary *tempDict=[data valueForKey:@"temp"];
    dayTemp=[self convertKelvinToCelcius:[[tempDict valueForKey:@"day"] doubleValue]];
    eveTemp=[self convertKelvinToCelcius:[[tempDict valueForKey:@"eve"] doubleValue]];
    maxTemp=[self convertKelvinToCelcius:[[tempDict valueForKey:@"max"] doubleValue]];
    minTemp=[self convertKelvinToCelcius:[[tempDict valueForKey:@"min"] doubleValue]];
    morTemp=[self convertKelvinToCelcius:[[tempDict valueForKey:@"morn"] doubleValue]];
    nightTemp=[self convertKelvinToCelcius:[[tempDict valueForKey:@"night"] doubleValue]];
    
    NSArray *wehtherDescArr=[data valueForKey:@"weather"];
   
    NSDictionary *wehtherDescDict=[wehtherDescArr objectAtIndex:0];
    wehtherDesc=[wehtherDescDict valueForKey:@"description"];

    return self;
}
-(NSString *)convertKelvinToCelcius:(double)temp
{
    double celcius =temp-273.15;
    return [NSString stringWithFormat:@"%.2f°",celcius];
}
-(NSString*)getDate:(double)dt
{
    NSTimeInterval interval=dt;
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:interval];
    NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
    [formatter setLocale:[NSLocale currentLocale]];
    [formatter setDateFormat:@"dd.MM.yyyy"];
   return([formatter stringFromDate:date]);
    
}
@end
