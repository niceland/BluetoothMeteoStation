//
//  SecondViewController.m
//  SKM
//
//  Created by Magda on 12.04.2015.
//  Copyright (c) 2015 madzia. All rights reserved.
//

#import "DeviceDataViewController.h"

@interface DeviceDataViewController ()

@end

@implementation DeviceDataViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.centralManager = [BluetoothCentralManageer sharedInstance];
    self.centralManager.delegate = self;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}


-(IBAction)backDidClick:(id)sender {

    [self.navigationController popViewControllerAnimated:YES];
}

- (void)centralManagerDidUpdateSensorReading:(NSDictionary *)data {
    NSLog(@"%@", data);
    
    //self.temp.text = [NSString stringWithFormat:@"Temperatura: %d", [[data objectForKey:kIntTemperatureKey] intValue]];
    self.temp.text = [NSString stringWithFormat:@"Temperatura: %0.02f °C", [[data objectForKey:kIntTemperatureKey] intValue] + ([[data objectForKey:kFloatTemperatureKey] floatValue]/1000)];
    self.pressure.text = [NSString stringWithFormat:@"Ciśnienie: %0.0f hPa", [[data objectForKey:kPressureKey] floatValue]];
    self.humidity.text = [NSString stringWithFormat:@"Wilgotność: %d", [[data objectForKey:kHumidityKey] intValue]];
    self.gasConcentration.text = [NSString stringWithFormat:@"Stężenie CO2: %0.0f", [[data objectForKey:kGasConcentrationKey] floatValue]];
    
    
    //    kFloatTemperatureKey;
    //    kHumidityKey;
    //    kGasConcentrationKey;
    //    kIntTemperatureKey;
    //    kPressureKey;
    
    
    // i tutaj przychodzi Ci dictionary, z ktorego trzeba wyciagnac dane i zrobic update UI ;)
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
