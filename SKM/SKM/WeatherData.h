//
//  WeatherData.h
//  SKM
//
//  Created by Magda on 28.03.2015.
//  Copyright (c) 2015 madzia. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WeatherData : NSObject

 //property daje zawsze jak chce zdefiniowac nowa zmienna (property automatycznie tworzy getera i setera)
@property (nonatomic) int clouds;
@property (nonatomic) long dt;
@property (nonatomic) int humidity;
@property (nonatomic) long pressure;
@property (nonatomic) float temp;
@property (nonatomic) float tempMax;
@property (nonatomic) float tempMin;
@property (nonatomic, strong) NSString* name;
@property (nonatomic) float rain;
@property (nonatomic) float snow;
@property (nonatomic) long sunrise;
@property (nonatomic) long sunset;
@property (nonatomic, strong) NSString* weatherDescription;
@property (nonatomic) float windDeg;
@property (nonatomic) float windGust;
@property (nonatomic) float windSpeed;
@property (nonatomic, strong) NSString* iconName;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;


@end
