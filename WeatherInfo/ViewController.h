//
//  ViewController.h
//  WeatherInfo
//
//  Created by Kalpesh Mahajan on 29/04/14.
//  Copyright (c) 2014 Kalpesh Mahajan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
@interface ViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,CLLocationManagerDelegate,UITextFieldDelegate>
{
    __weak IBOutlet UITextField *textfieldCityName;
    __weak IBOutlet UITableView *tblWetherInfo;
    __weak IBOutlet UIActivityIndicatorView *activityIndicator;
   
}
-(IBAction)getInfoBtnClicked:(id)sender;
@end
