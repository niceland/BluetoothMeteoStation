//
//  BluetoothCentralManageer.m
//  SKM
//
//  Created by Magda on 11.04.2015.
//  Copyright (c) 2015 madzia. All rights reserved.
//

#import "BluetoothCentralManageer.h"

@implementation BluetoothCentralManageer

+ (BluetoothCentralManageer *)sharedInstance {
    
    static BluetoothCentralManageer *sharedInstance;
    
    if (sharedInstance==nil) {
        sharedInstance = [[self alloc] init];
    }
    
    return sharedInstance;
}

- (instancetype)init {
    if (self = [super init]) {
//         dispatch_queue_t
        self.manager = [[CBCentralManager alloc] initWithDelegate:self queue:dispatch_get_global_queue(0, 0) options:nil];
    }
    return self;
}

- (void)centralManagerDidUpdateState:(CBCentralManager *)central {
    
    NSString *errorMessage = @"Unexpected error occured";
    BOOL wasError = NO;
    switch (central.state) {
        case CBCentralManagerStatePoweredOff:
            errorMessage = @"turn on bluetooth";
            wasError = YES;
            break;
        case CBCentralManagerStatePoweredOn:
            [self.manager scanForPeripheralsWithServices:nil options: @{CBCentralManagerScanOptionAllowDuplicatesKey : @YES}];
            break;
        case CBCentralManagerStateUnsupported:
            errorMessage = @"device dont have bluetooth 4.0";
            wasError = YES;
            break;
        case CBCentralManagerStateUnknown:
            wasError = YES;
            break;
        default:
            break;
    }
}

- (void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary *)advertisementData RSSI:(NSNumber *)RSSI {
    
    NSLog(@"%@",advertisementData);
    
    NSData *sensorData = [advertisementData objectForKey:@"kCBAdvDataManufacturerData"];//@"kCBAdvDataManufacturerData"];
    NSString *str = nil;
    if ([sensorData isKindOfClass:[NSString class]]) {
        str = (NSString *)sensorData;
    }
    else  {
        str = [self hexadecimalStringFromData:sensorData];
    }
    
    if (![self validateDevice:str]) {
        return;
    }
    
    NSDictionary *dictData = [self convertHexadecimalString:str];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
      [self.delegate centralManagerDidUpdateSensorReading:dictData];
        
    });
    
}

//- (BOOL)validateDevice:(NSString *)deviceData {
  //  if (deviceData.length < 10) {
    //    return NO;
    //}
    //NSString *subString = [deviceData substringWithRange:NSMakeRange(6, 4)];
    //if ([[subString lowercaseString] isEqualToString:@"oab3"]) {
       // return YES;
    //}
    //return NO;
//}

- (BOOL)validateDevice:(NSString *)deviceData {
    if ([deviceData rangeOfString:@"0ab3"].location != NSNotFound) {
        return YES;
        }
    return NO;
}

- (NSDictionary *)convertHexadecimalString:(NSString *)string {

    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    
    NSString *tempInt = [string substringWithRange:NSMakeRange(10, 2)];
    int temp = [self intFromHexString:tempInt];
    [dict setObject:[NSNumber numberWithInt:temp] forKey:kIntTemperatureKey];

    NSString *tempFloat = [string substringWithRange:NSMakeRange(12, 4)];
    float tempAccurate = [self intFromHexString:tempFloat];
    [dict setObject:[NSNumber numberWithFloat:tempAccurate] forKey:kFloatTemperatureKey];
    
    NSString *pressure = [string substringWithRange:NSMakeRange(16, 4)];
    float press = [self intFromHexString:pressure];
    [dict setObject:[NSNumber numberWithFloat:press] forKey:kPressureKey];
    
    NSString *humidity = [string substringWithRange:NSMakeRange(20, 2)];
    int hum = [self intFromHexString:humidity];
    [dict setObject:[NSNumber numberWithFloat:hum] forKey:kHumidityKey];
    
    NSString *gasConcentration = [string substringWithRange:NSMakeRange(22, 4)];
    float gas = [self intFromHexString:gasConcentration];
    [dict setObject:[NSNumber numberWithFloat:gas] forKey:kGasConcentrationKey];
    
    return [dict copy];
}

- (int)intFromHexString:(NSString *)hex {
    unsigned result = 0;
    NSScanner *scanner = [NSScanner scannerWithString:hex];
    
    [scanner setScanLocation:0];
    [scanner scanHexInt:&result];

    return result;
}

-(float)floatFromHex:(NSString *)hex {
    float result = 0.0;
    NSScanner *scanner = [NSScanner scannerWithString:hex];
    
    [scanner setScanLocation:0];
    [scanner scanHexFloat:&result];
    
    return result;
}

- (NSString *)hexadecimalStringFromData:(NSData *)data
{
    /* Returns hexadecimal string of NSData. Empty string if data is empty.   */
    
    const unsigned char *dataBuffer = (const unsigned char *)[data bytes];
    
    if (!dataBuffer)
    {
        return [NSString string];
    }
    
    NSUInteger          dataLength  = [data length];
    NSMutableString     *hexString  = [NSMutableString stringWithCapacity:(dataLength * 2)];
    
    for (int i = 0; i < dataLength; ++i)
    {
        [hexString appendFormat:@"%02x", (unsigned int)dataBuffer[i]];
    }
    
    return [NSString stringWithString:hexString];
}

@end
