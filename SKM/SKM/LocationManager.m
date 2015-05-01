//
//  LocationManager.m
//  SKM
//
//  Created by Magda on 28.03.2015.
//  Copyright (c) 2015 madzia. All rights reserved.
//

#import "LocationManager.h"

@implementation LocationManager

+ (LocationManager *)sharedInstance {
    
    static LocationManager *sharedInstance;
    
    if (sharedInstance==nil) {
        sharedInstance = [[self alloc] init];
    }
    
    return sharedInstance;
}

-(instancetype)init {
    if (self=[super init]) {
        self.manager = [[CLLocationManager alloc] init]; //odwolanie do getera obiektu manager
        if ([self.manager respondsToSelector:@selector(requestAlwaysAuthorization)]) {
            [self.manager requestAlwaysAuthorization];
        }
        [self.manager startUpdatingLocation];
    }
    return self;
}

- (CLLocationCoordinate2D)getCurrentLocation {
    CLLocationCoordinate2D coord = self.manager.location.coordinate;
    return coord;
}

@end
