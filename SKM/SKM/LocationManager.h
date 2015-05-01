//
//  LocationManager.h
//  SKM
//
//  Created by Magda on 28.03.2015.
//  Copyright (c) 2015 madzia. All rights reserved.
//

#import <Foundation/Foundation.h>
@import CoreLocation;


@interface LocationManager : NSObject

@property (nonatomic, strong) CLLocationManager *manager;

+ (LocationManager *)sharedInstance;
- (CLLocationCoordinate2D)getCurrentLocation;


@end
