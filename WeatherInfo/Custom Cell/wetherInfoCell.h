//
//  wetherInfoCell.h
//  WeatherInfo
//
//  Created by Kalpesh Mahajan on 29/04/14.
//  Copyright (c) 2014 Kalpesh Mahajan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface wetherInfoCell : UITableViewCell
@property(nonatomic,weak)IBOutlet UILabel *lblDate;
@property(nonatomic,weak)IBOutlet UILabel *lblDesc;
@property(nonatomic,weak)IBOutlet UILabel *lblHumidity;
@property(nonatomic,weak)IBOutlet UILabel *lblDay;
@property(nonatomic,weak)IBOutlet UILabel *lblMin;
@property(nonatomic,weak)IBOutlet UILabel *lblMax;
@property(nonatomic,weak)IBOutlet UILabel *lblEve;
@property(nonatomic,weak)IBOutlet UILabel *lblNight;
@property(nonatomic,weak)IBOutlet UILabel *lblMor;

@end
