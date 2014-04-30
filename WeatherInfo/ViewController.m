//
//  ViewController.m
//  WeatherInfo
//
//  Created by Kalpesh Mahajan on 29/04/14.
//  Copyright (c) 2014 Kalpesh Mahajan. All rights reserved.
//

#import "ViewController.h"
#import "Parser.h"
#import "wetherInfoCell.h"
#import "WetherInfoDataModal.h"
@interface ViewController ()<ParserDelgate>
{
    Parser *parserObj;
    CLLocationManager *locationManager;

    NSString *cityName;
    NSString *countryName;
    NSMutableArray *dataArray;
    
}
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [activityIndicator stopAnimating];
    dataArray=[[NSMutableArray alloc]init];
    cityName=[[NSString alloc]init];
    countryName=[[NSString alloc]init];

    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    
    [locationManager startUpdatingLocation];
    //[self getWhetherInfo:@""];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
    // Dispose of any resources that can be recreated.
}
#pragma mark IBActions
-(IBAction)getInfoBtnClicked:(id)sender
{
    if (textfieldCityName.text.length==0) {
        return;
    }
    [textfieldCityName resignFirstResponder];
    [self getWhetherInfo:[textfieldCityName.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet] ]];
}

#pragma mark UITextField Delgate
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    textfieldCityName.text=@"";
    return YES;
}
#pragma mark CLlocation Manager Delgate
#pragma mark - CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"didFailWithError: %@", error);
    UIAlertView *errorAlert = [[UIAlertView alloc]
                               initWithTitle:@"Error" message:@"Failed to Get Your Location" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [errorAlert show];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    NSLog(@"didUpdateToLocation: %@", newLocation);
    CLLocation *currentLocation = newLocation;
    
    if (currentLocation != nil)
    {

        [self getWehterInfoUsingCurrentLocation: [NSString stringWithFormat:@"%.8f", currentLocation.coordinate.latitude] Lontitude:[NSString stringWithFormat:@"%.8f", currentLocation.coordinate.longitude]];
    }
}
#pragma mark Json Parser Method
#pragma mark Call WebServiced
-(void)getWehterInfoUsingCurrentLocation:(NSString *)lat Lontitude:(NSString*)lont
{
    if (parserObj==nil) {
        [activityIndicator startAnimating];
        parserObj=[[Parser alloc]init];
        [parserObj parseData:[NSString stringWithFormat:@"http://api.openweathermap.org/data/2.5/forecast/daily?lat=%@&lon=%@&cnt=14&mode=json",lat,lont]];
        parserObj.delegate=self;
        
    }
}
-(void)getWhetherInfo:(NSString *)_cityName
{
    if (parserObj==nil) {
        [activityIndicator startAnimating];
        parserObj=[[Parser alloc]init];
        [parserObj parseData:[NSString stringWithFormat:@"http://api.openweathermap.org/data/2.5/forecast/daily?q=%@&cnt=14&APPID=xxxxx",_cityName]];
        parserObj.delegate=self;

    }
    
}
#pragma mark Parser Delgate Methods
-(void)DidFinish:(id)data
{
    [locationManager stopUpdatingLocation];

    [activityIndicator stopAnimating];

    parserObj=Nil;
    parserObj.delegate=nil;
    [dataArray removeAllObjects];
    
    NSDictionary *cityInfo=[data valueForKey:@"city"];
    cityName=[cityInfo valueForKey:@"name"];
    countryName=[cityInfo valueForKey:@"country"];
    textfieldCityName.text=cityName;
    NSArray *listArr =[data valueForKey:@"list"];
    for (NSMutableDictionary *dict in listArr) {
        
        WetherInfoDataModal *modal=[[WetherInfoDataModal alloc]initwithDictionary:dict];
        [dataArray addObject:modal];
    }
    [tblWetherInfo reloadData];
    [tblWetherInfo scrollRectToVisible:CGRectMake(0, 0, 1, 1) animated:YES];

}
-(void)DidFail:(NSString *)errorstr
{
    
    [activityIndicator stopAnimating];

    parserObj=Nil;
    parserObj.delegate=nil;

    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Error" message:errorstr delegate:Nil cancelButtonTitle:Nil otherButtonTitles:@"Ok", nil];
    [alert show];
}

#pragma mark UITableview Methods
#pragma UITableview Datasource Methods
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section==0) {
        return [NSString stringWithFormat:@"City: %@ Country:%@",cityName,countryName];
    }
    else
        return nil;
}- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return [dataArray count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    wetherInfoCell *cell=[tableView dequeueReusableCellWithIdentifier:@"wetherInfoCell"];
    WetherInfoDataModal *modal=[dataArray objectAtIndex:indexPath.row];
    cell.lblDate.text=modal.wehtherDate;
    cell.lblDay.text=modal.dayTemp;
    cell.lblDesc.text=modal.wehtherDesc;
    cell.lblEve.text=modal.eveTemp;
    cell.lblHumidity.text=modal.humidty;
    cell.lblMax.text=modal.maxTemp;
    cell.lblMin.text=modal.minTemp;
    cell.lblMor.text=modal.morTemp;
    cell.lblNight.text=modal.nightTemp;

    return cell;
}

@end
