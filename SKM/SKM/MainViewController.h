//
//  ViewController.h
//  SKM
//
//  Created by Magda on 28.03.2015.
//  Copyright (c) 2015 madzia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LocationManager.h"
#import "NetworkManager.h"
#import "BluetoothPeripheralManager.h"
#import "BluetoothCentralManageer.h"
#import "DeviceDataViewController.h"


@interface MainViewController : UIViewController <NetworkManagerDelegate, BluetoothCentralManagerDelegate>

@property (nonatomic, strong) BluetoothPeripheralManager *bluetoothManager;
@property (nonatomic, strong) BluetoothCentralManageer *centralManager;
@property (nonatomic, strong) WeatherData *currentWeather;


@property (nonatomic, assign) IBOutlet UILabel *city;
@property (nonatomic, assign) IBOutlet UILabel *weatherDescription;
@property (nonatomic, assign) IBOutlet UILabel *wind;
@property (nonatomic, assign) IBOutlet UIImageView *weatherIcon;
@property (nonatomic, assign) IBOutlet UILabel *sunrise;
@property (nonatomic, assign) IBOutlet UILabel *sunset;
@property (nonatomic, assign) IBOutlet UILabel *temperature;
@property (nonatomic, assign) IBOutlet UILabel *temperatureMax;
@property (nonatomic, assign) IBOutlet UILabel *temperatureMin;
@property (nonatomic, assign) IBOutlet UILabel *rain;
@property (nonatomic, assign) IBOutlet UILabel *snow;



@end

