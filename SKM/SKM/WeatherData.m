//
//  WeatherData.m
//  SKM
//
//  Created by Magda on 28.03.2015.
//  Copyright (c) 2015 madzia. All rights reserved.
//

#import "WeatherData.h"

@implementation WeatherData

-(instancetype)initWithDictionary:(NSDictionary *)dictionary {
    if (self=[super init]) {
        self.dt = [[dictionary objectForKey:@"dt"] longValue];
        self.clouds = [[[dictionary objectForKey:@"clouds"] objectForKey:@"all"] intValue];
        self.humidity = [[[dictionary objectForKey:@"main"] objectForKey:@"humidity"] intValue];
        self.pressure = [[[dictionary objectForKey:@"main"] objectForKey:@"pressure"] longValue];
        self.temp = [[[dictionary objectForKey:@"main"] objectForKey:@"temp"] floatValue];
        self.tempMax = [[[dictionary objectForKey:@"main"] objectForKey:@"temp_max"] floatValue];
        self.tempMin = [[[dictionary objectForKey:@"main"] objectForKey:@"temp_min"] floatValue];
        self.name = [dictionary objectForKey:@"name"];
        self.rain = [[[dictionary objectForKey:@"rain"] objectForKey:@"3h"] floatValue];
        self.snow = [[[dictionary objectForKey:@"snow"] objectForKey:@"3h"] floatValue];
        self.sunrise = [[[dictionary objectForKey:@"sys"] objectForKey:@"sunrise"] longValue];
        self.sunset = [[[dictionary objectForKey:@"sys"] objectForKey:@"sunset"] longValue];
        self.weatherDescription = [[[dictionary objectForKey:@"weather"] objectAtIndex:0] objectForKey:@"description"];
        self.windDeg = [[[dictionary objectForKey:@"wind"] objectForKey:@"deg"] floatValue];
        self.windGust = [[[dictionary objectForKey:@"wind"] objectForKey:@"gust"] floatValue];
        self.windSpeed = [[[dictionary objectForKey:@"wind"] objectForKey:@"speed"] floatValue];
        self.iconName = [[[dictionary objectForKey:@"weather"] objectAtIndex:0] objectForKey:@"icon"];
    }
    return self;    
}


@end
