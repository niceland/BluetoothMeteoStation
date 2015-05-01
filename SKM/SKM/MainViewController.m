//
//  ViewController.m
//  SKM
//
//  Created by Magda on 28.03.2015.
//  Copyright (c) 2015 madzia. All rights reserved.
//

#import "MainViewController.h"


@interface MainViewController ()

@property (nonatomic, strong) NetworkManager* networkManager;
@property (nonatomic, strong) NSDateFormatter* dateFormatter;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //NSLog(@"%f, %f", [[LocationManager sharedInstance] getCurrentLocation].latitude, [[LocationManager sharedInstance] getCurrentLocation].longitude);
    self.bluetoothManager = [[BluetoothPeripheralManager alloc]init];
    [self.bluetoothManager setupPeripheralWithData:@""];
    self.networkManager = [[NetworkManager alloc]init];
    self.networkManager.delegate = self;
    
    self.centralManager = [BluetoothCentralManageer sharedInstance];
    self.centralManager.delegate = self;
    
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{ //zakladam nowy watek, zeby mi sie to robilo gdzies tam i mi nie blokowalo
        [self updateWeatherData]; //wywolanie metody, ktora nic nie przyjmuje
        
    });
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [self updateBluetooth];
        
    });
    
    self.dateFormatter = [[NSDateFormatter alloc] init];
    [self.dateFormatter setDateFormat:@"YY-MM-ddhh:mm"];
}

- (void)updateWeatherData {
    
    while (1) {
        CLLocationCoordinate2D cord = [[LocationManager sharedInstance] getCurrentLocation];
        [self.networkManager getWeatherDataForLocationWithCoordinates:cord];
        sleep(30);
    }
}

- (void)updateBluetooth {
    while (1) {
        if(self.currentWeather!=nil) {
            NSDate* date = [NSDate date];
            NSString* icon = [self.currentWeather.iconName substringWithRange:NSMakeRange(0, 2)];
            NSString* stringDate = [self.dateFormatter stringFromDate:date];
            NSString* str = [icon stringByAppendingString:stringDate]; 
            [self.bluetoothManager setupPeripheralWithData:str];
        }
        sleep(1);
    }
}


- (void)networkManagerDidDonloadWeatherData:(WeatherData *)data {
    
    self.currentWeather = data;
    [self.bluetoothManager writeWeatherDescriptionToCharacteristic:data.weatherDescription];
    
//warning kijowo troche z tym delay, do poprawy
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.bluetoothManager writeLocationToCharacteristic:data.name];
    });
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.bluetoothManager writeWindToCharacteristic:[NSString stringWithFormat:@"%f", data.windSpeed]];
    });
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    
    //self.weatherDescription.text = data.weatherDescription; //przypisuje lejbelce text, ktory sie pobiera
    self.weatherDescription.text = [NSString stringWithFormat:@"Weather description: %@", data.weatherDescription];
    self.city.text = @"Krakow";//[NSString stringWithFormat:@"Krakow"];
    self.wind.text = [NSString stringWithFormat:@"Wind Speed: %0.0f", data.windSpeed];
    self.sunrise.text = [NSString stringWithFormat:@"Sunrise: %@", [formatter stringFromDate:[NSDate dateWithTimeIntervalSince1970:data.sunrise]]];
    self.sunset.text = [NSString stringWithFormat:@"Sunset: %@", [formatter stringFromDate:[NSDate dateWithTimeIntervalSince1970:data.sunset]]];
    self.temperature.text = [NSString stringWithFormat:@"Average temperature: %0.0f", data.temp-273];
    //self.temperatureMax.text = [NSString stringWithFormat:@"Max temp: %0.0f", data.tempMax-273];
    //self.temperatureMin.text = [NSString stringWithFormat:@"Min temp: %0.0f", data.tempMin-273];
    self.rain.text = [NSString stringWithFormat:@"Rain: %0.0f", data.rain];
    self.snow.text = [NSString stringWithFormat:@"Snow: %0.0f", data.snow];
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSString *baseURL = @"http://openweathermap.org/img/w/";
        NSString *stringURL = [baseURL stringByAppendingString:[NSString stringWithFormat:@"%@.png", data.iconName]];
        NSURL *url = [NSURL URLWithString:stringURL];
        
        NSData *data = [NSData dataWithContentsOfURL:url];
        UIImage *img = [UIImage imageWithData:data];
        dispatch_async(dispatch_get_main_queue(), ^{
            self.weatherIcon.image = img;
            
        });
    });
}

- (void)centralManagerDidUpdateSensorReading:(NSDictionary *)data {
    NSLog(@"%@", data);

//    kFloatTemperatureKey;
//    kHumidityKey;
//    kGasConcentrationKey;
//    kIntTemperatureKey;
//    kPressureKey;
    
    
    // i tutaj przychodzi Ci dictionary, z ktorego trzeba wyciagnac dane i zrobic update UI ;)
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
