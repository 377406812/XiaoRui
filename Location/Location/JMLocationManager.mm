//
//  JMLocationManager.m
//  Location
//
//  Created by xiaorui on 14-11-6.
//  Copyright (c) 2014年 xiaorui. All rights reserved.
//

#import "JMLocationManager.h"
#import "BMapKit.h"


@interface JMLocationManager ()<CLLocationManagerDelegate,BMKLocationServiceDelegate,BMKGeoCodeSearchDelegate>
{

    BMKLocationService* _locService;
    BMKGeoCodeSearch *_searcher;
    
}


@property (nonatomic,strong) CLLocationManager *locationManger;

@property (nonatomic,strong) CLLocation *location;

@property (nonatomic, strong) LocationBlock locationBlock;
@property (nonatomic, strong) NSStringBlock cityBlock;
@property (nonatomic, strong) NSStringBlock addressBlock;
@property (nonatomic, strong) LocationErrorBlock errorBlock;
@end

@implementation JMLocationManager
@synthesize locationBlock = _locationBlock;
@synthesize cityBlock = _cityBlock;
@synthesize addressBlock = _addressBlock;
@synthesize errorBlock = _errorBlock;



+ (instancetype) shareLocation{
    static  id _shareObject = nil;
    static dispatch_once_t once_t;
    dispatch_once(&once_t, ^{
        
        _shareObject = [self alloc];
        
    });
    return _shareObject;
}
-(id)init{
    self = [super init];
    if(self){
        _locService = [[BMKLocationService alloc]init];
        _searcher =[[BMKGeoCodeSearch alloc]init];


    }
    return self;
}

-(BOOL)isOpenLocationServer{
    if ([CLLocationManager locationServicesEnabled]&&
        ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorized
         || [CLLocationManager authorizationStatus] == kCLAuthorizationStatusNotDetermined)){
            return YES;
        }else{
            return NO;
        }
}

- (void)getLocationCoordinate:(void(^)(CLLocationCoordinate2D locaiont))locaiontBlock{
    _locationBlock = locaiontBlock;
    [self startLocation];
}

- (void) getLocationCoordinate:(LocationBlock) locaiontBlock  withAddress:(NSStringBlock) addressBlock{
    _locationBlock = locaiontBlock;
    _addressBlock = addressBlock;
    [self startLocation];
    
}


- (void) getAddress:(NSStringBlock)addressBlock{
    _addressBlock = addressBlock;
    [self startLocation];
}

- (void) getCity:(NSStringBlock)cityBlock{
    _cityBlock =  cityBlock;
    [self startLocation];
}


- (void) getCity:(NSStringBlock)cityBlock error:(LocationErrorBlock) errorBlock{
    _cityBlock = cityBlock;
    _errorBlock = errorBlock;
    [self startLocation];
}

-(void)startLocation{
//    if (_locService) {
//        _locService = nil;
//        _searcher = nil;
//    }
    
    _locService.delegate = self;
    //启动LocationService
    [_locService startUserLocationService];
    
}

//处理方向变更信息
- (void)didUpdateUserHeading:(BMKUserLocation *)userLocation{

}
//处理位置坐标更新
- (void)didUpdateUserLocation:(BMKUserLocation *)userLocation{
    
        
        _searcher.delegate = self;
    CLLocationCoordinate2D pt = (CLLocationCoordinate2D){userLocation.location.coordinate.latitude, userLocation.location.coordinate.longitude};
    BMKReverseGeoCodeOption *reverseGeoCodeSearchOption = [[BMKReverseGeoCodeOption alloc]init];
    reverseGeoCodeSearchOption.reverseGeoPoint = pt;
   
    BOOL flag = [_searcher reverseGeoCode:reverseGeoCodeSearchOption];
    if(flag){
      NSLog(@"反geo检索发送成功");
    }
    else{
      NSLog(@"反geo检索发送失败");
    }
    [_locService stopUserLocationService];
}
- (void)onGetReverseGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKReverseGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error{
  if (error == BMK_SEARCH_NO_ERROR) {
      
//      /// 街道号码  streetNumber;
//      /// 街道名称
//      @property (nonatomic, retain) NSString* streetName;
//      /// 区县名称
//      @property (nonatomic, retain) NSString* district;
//      /// 城市名称
//      @property (nonatomic, retain) NSString* city;
//      /// 省份名称
//      @property (nonatomic, retain) NSString* province;
//      

      NSLog(@"在此处理正常结果,,%@,lll%@",result.address,result.addressDetail.streetName);
      
      
      if (_cityBlock) {
          _cityBlock(result.addressDetail.city);
          _cityBlock = nil;
      }
      if (_addressBlock) {
          _addressBlock(result.address);
          _addressBlock = nil;
      }

  }else {
      NSLog(@"抱歉，未找到结果");
  }
}
@end
