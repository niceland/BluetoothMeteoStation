//
//  BluetoothPeripheralManager.m
//  SKM
//
//  Created by Magda on 28.03.2015.
//  Copyright (c) 2015 madzia. All rights reserved.
//

#import "BluetoothPeripheralManager.h"


@implementation BluetoothPeripheralManager

-(instancetype)init {
    if (self=[super init]) {
        
    }
    return self;
}

-(void)setupPeripheralWithData:(NSString *)value {
    
    self.currentValue = value;
    self.peripheralManager = [[CBPeripheralManager alloc]initWithDelegate:self queue:dispatch_get_main_queue()];
    
}

-(void)setupCharacteristic {
    
    CBMutableService *service = [[CBMutableService alloc] initWithType:[CBUUID UUIDWithString:@"D3496D23-3DBF-436B-B789-3967E9870EDB"] primary:YES];
    
    self.weatherCharacteristic = [[CBMutableCharacteristic alloc]initWithType:[CBUUID UUIDWithString:@"D4496D23-3DBF-436B-B789-3967E9870EDB"] properties:CBCharacteristicPropertyRead | CBCharacteristicPropertyNotify value:nil permissions:CBAttributePermissionsReadable];
    
    self.locationCharacteristic = [[CBMutableCharacteristic alloc]initWithType:[CBUUID UUIDWithString:@"D5496D23-3DBF-436B-B789-3967E9870EDB"] properties:CBCharacteristicPropertyRead | CBCharacteristicPropertyNotify value:nil permissions:CBAttributePermissionsReadable];
    
    self.windCharacteristic = [[CBMutableCharacteristic alloc]initWithType:[CBUUID UUIDWithString:@"D6496D23-3DBF-436B-B789-3967E9870EDB"] properties:CBCharacteristicPropertyRead | CBCharacteristicPropertyNotify value:nil permissions:CBAttributePermissionsReadable];
    
    service.characteristics = @[self.weatherCharacteristic, self.locationCharacteristic, self.windCharacteristic];
    [self.peripheralManager addService:service];
}

-(void)writeWeatherDescriptionToCharacteristic:(NSString *)weatherInfo {
    NSData *data = [weatherInfo dataUsingEncoding:NSUTF8StringEncoding];
    if (data != nil)
        [self.peripheralManager updateValue:data forCharacteristic:self.weatherCharacteristic onSubscribedCentrals:nil];
}

-(void)writeLocationToCharacteristic:(NSString *)locationInfo {
    NSData *data = [locationInfo dataUsingEncoding:NSUTF8StringEncoding];
    if (data != nil)
        [self.peripheralManager updateValue:data forCharacteristic:self.locationCharacteristic onSubscribedCentrals:nil];
}

-(void)writeWindToCharacteristic:(NSString *)windInfo {
    NSData *data = [windInfo dataUsingEncoding:NSUTF8StringEncoding];
    if (data != nil)
        [self.peripheralManager updateValue:data forCharacteristic:self.windCharacteristic onSubscribedCentrals:nil];
}

- (void)peripheralManagerDidUpdateState:(CBPeripheralManager *)peripheral
{
    NSString *state;
    switch (self.peripheralManager.state)
    {
            case CBPeripheralManagerStateUnsupported:
            state = @"This device does not support Bluetooth Low Energy.";
            break;
            case CBPeripheralManagerStateUnauthorized:
            state = @"This app is not authorized to use Bluetooth Low Energy.";
            break;
            case CBPeripheralManagerStatePoweredOff:
            state = @"Bluetooth on this device is currently powered off.";
            break;
            case CBPeripheralManagerStateResetting:
            state = @"The BLE Manager is resetting; a state update is pending.";
            break;
            case CBPeripheralManagerStatePoweredOn: {
                state = @"Bluetooth LE is turned on and ready for communication.";
                [self setupCharacteristic];
                NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
                
                if(self.currentValue != nil){
                
                [dict setObject:self.currentValue forKey:CBAdvertisementDataLocalNameKey];
                }
                //[dict setObject:@"value" forKey:CBAdvertisementDataServiceDataKey];
                //[dict setObject:@"agh" forKey:CBAdvertisementDataServiceUUIDsKey];
                    [self.peripheralManager startAdvertising:dict];
            }
            break;
            case CBPeripheralManagerStateUnknown:
            state = @"The state of the BLE Manager is unknown.";
            break;
            default:
            state = @"The state of the BLE Manager is unknown.";
        }
    NSLog(@"%@", state);
}

//- (NSData *) stringToHex:(NSString *)command
//{
//    command = [command stringByReplacingOccurrencesOfString:@" " withString:@""];
//    NSMutableData *commandToSend= [[NSMutableData alloc] init];
//    unsigned char whole_byte;
//    char byte_chars[3] = {'\0','\0','\0'};
//    int i;
//    for (i=0; i < [command length]/2; i++) {
//        byte_chars[0] = [command characterAtIndex:i*2];
//        byte_chars[1] = [command characterAtIndex:i*2+1];
//        whole_byte = strtol(byte_chars, NULL, 16);
//        [commandToSend appendBytes:&whole_byte length:1];
//    }
//    return [commandToSend copy];
//}
@end
