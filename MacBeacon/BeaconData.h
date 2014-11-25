//
//  BeaconData.h
//  MacBeacon
//
//  Created by Ayaka Tominaga on 2014/11/24.
//  Copyright (c) 2014年 Communication Planning Corporation. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BeaconData : NSObject

- (id)initWithProximityUUID:(NSUUID *)proximityUUID
                      major:(uint16_t)major
                      minor:(uint16_t)minor;

- (NSDictionary *)getAdvertisementData;

@end
