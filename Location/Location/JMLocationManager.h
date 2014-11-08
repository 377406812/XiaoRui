//
//  JMLocationManager.h
//  Location
//
//  Created by xiaorui on 14-11-6.
//  Copyright (c) 2014年 xiaorui. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
 
@interface JMLocationManager : NSObject




typedef void (^LocationBlock)(CLLocationCoordinate2D locationCorrrdinate); // 返回 经度 纬度
typedef void (^LocationErrorBlock) (NSError *error); // 定位失败 返回 失败信息
typedef void(^NSStringBlock)(NSString *cityString);  // 返回 城市
typedef void(^NSStringBlock)(NSString *addressString);// 返回 位置信息


+ (instancetype) shareLocation;


-(id)init;
/**
 *  判断是否开启了定位
 *
 *  @param locaiontBlock locaiontBlock description
 */
-(BOOL)isOpenLocationServer;

/**
 *  获取坐标
 *
 *  @param locaiontBlock locaiontBlock description
 */
- (void) getLocationCoordinate:(LocationBlock )locaiontBlock ;

/**
 *  获取坐标和地址
 *
 *  @param locaiontBlock locaiontBlock description
 *  @param addressBlock  addressBlock description
 */
- (void) getLocationCoordinate:(LocationBlock) locaiontBlock  withAddress:(NSStringBlock) addressBlock;

/**
 *  获取地址
 *
 *  @param addressBlock addressBlock description
 */
- (void) getAddress:(NSStringBlock)addressBlock;

/**
 *  获取城市
 *
 *  @param cityBlock cityBlock description
 */
- (void) getCity:(NSStringBlock)cityBlock;

/**
 *  获取城市和定位失败
 *
 *  @param cityBlock  cityBlock description
 *  @param errorBlock errorBlock description
 */
- (void) getCity:(NSStringBlock)cityBlock error:(LocationErrorBlock) errorBlock;
@end
