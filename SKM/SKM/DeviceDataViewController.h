//
//  SecondViewController.h
//  SKM
//
//  Created by Magda on 12.04.2015.
//  Copyright (c) 2015 madzia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BluetoothCentralManageer.h"

@interface DeviceDataViewController : UIViewController <BluetoothCentralManagerDelegate>

@property (nonatomic, assign) IBOutlet UILabel *temp;
@property (nonatomic, assign) IBOutlet UILabel *pressure;
@property (nonatomic, assign) IBOutlet UILabel *humidity;
@property (nonatomic, assign) IBOutlet UILabel *gasConcentration;
@property (nonatomic, strong) BluetoothCentralManageer *centralManager;


-(IBAction)backDidClick:(id)sender;


@end
