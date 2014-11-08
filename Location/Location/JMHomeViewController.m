//
//  JMHomeViewController.m
//  Location
//
//  Created by xiaorui on 14-11-6.
//  Copyright (c) 2014年 xiaorui. All rights reserved.
//

#import "JMHomeViewController.h"
#import "JMLocationManager.h"

@interface JMHomeViewController ()

@end

@implementation JMHomeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    JMLocationManager *manager =[[JMLocationManager shareLocation] init];
    [manager getLocationCoordinate:^(CLLocationCoordinate2D locationCorrrdinate) {
     NSLog(@"UUU::%f,%f",locationCorrrdinate.longitude,locationCorrrdinate.latitude);
    }];
    [manager getCity:^(NSString *addressString) {
        NSLog(@"UUU::%@",addressString);
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
