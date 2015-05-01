//
//  BluetoothPeripheralManager.h
//  SKM
//
//  Created by Magda on 28.03.2015.
//  Copyright (c) 2015 madzia. All rights reserved.
//

#import <Foundation/Foundation.h>
@import CoreBluetooth;


@interface BluetoothPeripheralManager : NSObject <CBPeripheralManagerDelegate>

@property (nonatomic, strong) CBPeripheralManager *peripheralManager;

@property (nonatomic, strong) CBMutableCharacteristic *weatherCharacteristic;

@property (nonatomic, strong) CBMutableCharacteristic *locationCharacteristic;

@property (nonatomic, strong) CBMutableCharacteristic *windCharacteristic;

@property (nonatomic, copy) void(^writeCallback)(void);

@property (nonatomic, strong) NSString *currentValue;

- (instancetype)init;
-(void)setupPeripheralWithData:(NSString *)currentValue;
-(void)writeWeatherDescriptionToCharacteristic:(NSString *)weatherInfo;
-(void)writeLocationToCharacteristic:(NSString *)locationInfo;
-(void)writeWindToCharacteristic:(NSString *)windInfo;


@end
