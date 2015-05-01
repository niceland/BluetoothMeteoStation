//
//  NetworkManager.h
//  SKM
//
//  Created by Magda on 28.03.2015.
//  Copyright (c) 2015 madzia. All rights reserved.
//

#import <Foundation/Foundation.h>
@import CoreLocation;
#import "WeatherData.h"

@protocol NetworkManagerDelegate <NSObject>

- (void)networkManagerDidDonloadWeatherData:(WeatherData *)data;

@end

@interface NetworkManager : NSObject

@property (nonatomic) id<NetworkManagerDelegate>delegate;

-(void)getWeatherDataForLocationWithCoordinates:(CLLocationCoordinate2D)coord;

@end
