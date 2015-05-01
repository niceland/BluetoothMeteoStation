//
//  NetworkManager.m
//  SKM
//
//  Created by Magda on 28.03.2015.
//  Copyright (c) 2015 madzia. All rights reserved.
//


//pobieram tutaj dane o pogodzie

#import "NetworkManager.h"

@implementation NetworkManager

-(void)getWeatherDataForLocationWithCoordinates:(CLLocationCoordinate2D)coord {

    
    // http://api.openweathermap.org/data/2.5/weather?lat=35&lon=139
    
    NSString *urlString = [NSString stringWithFormat:@"http://api.openweathermap.org/data/2.5/weather?lat=%f&lon=%f", coord.latitude, coord.longitude];
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue new] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        //NSLog(@"%@", [NSJSONSerialization JSONObjectWithData:data options:0 error:nil]);
        NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        WeatherData *weather = [[WeatherData alloc] initWithDictionary:dictionary];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
          [self.delegate networkManagerDidDonloadWeatherData:weather];
        });
        
    }];
}



@end
