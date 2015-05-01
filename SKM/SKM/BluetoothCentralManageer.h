//
//  BluetoothCentralManageer.h
//  SKM
//
//  Created by Magda on 11.04.2015.
//  Copyright (c) 2015 madzia. All rights reserved.
//

#define kIntTemperatureKey  @"tempaerture"
#define kFloatTemperatureKey  @"floattemperature"
#define kPressureKey @"atmoPressure"
#define kHumidityKey @"humidity"
#define kGasConcentrationKey @"gasConcentration"

#import <Foundation/Foundation.h>
@import CoreBluetooth;
@class BluetoothCentralManageer;

@protocol BluetoothCentralManagerDelegate <NSObject>

- (void)centralManagerDidUpdateSensorReading:(NSDictionary *)data;

@end

@interface BluetoothCentralManageer : NSObject <CBCentralManagerDelegate>

@property (nonatomic, strong) CBCentralManager *manager;

@property (nonatomic) id<BluetoothCentralManagerDelegate> delegate;

+ (BluetoothCentralManageer *)sharedInstance;

@end
