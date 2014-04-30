//
//  WetherInfoDataModal.h
//  WeatherInfo
//
//  Created by Kalpesh Mahajan on 29/04/14.
//  Copyright (c) 2014 Kalpesh Mahajan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WetherInfoDataModal : NSObject
@property(nonatomic,strong)NSString *cityName;
@property(nonatomic,strong)NSString *countryName;
@property(nonatomic,strong)NSString *wehtherDate;
@property(nonatomic,strong)NSString *wehtherDesc;
@property(nonatomic,strong)NSString *humidty;
@property(nonatomic,strong)NSString *dayTemp;
@property(nonatomic,strong)NSString *minTemp;
@property(nonatomic,strong)NSString *maxTemp;
@property(nonatomic,strong)NSString *nightTemp;
@property(nonatomic,strong)NSString *eveTemp;
@property(nonatomic,strong)NSString *morTemp;

-(id)initwithDictionary:(NSDictionary *)data;
@end
