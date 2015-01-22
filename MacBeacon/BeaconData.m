//
//  BeaconData.m
//  MacBeacon
//
//  Created by Ayaka Tominaga on 2014/11/24.
//  Copyright (c) 2014年 Ayaka Tominaga
//
//  This software is released under the MIT License.
//  http://opensource.org/licenses/mit-license.php
//

#import "BeaconData.h"

@interface BeaconData ()
{
    NSUUID *_proximityUUID;
    uint16_t _major;
    uint16_t _minor;
    int8_t _measuredPower;
}

@end

@implementation BeaconData

- (id)initWithProximityUUID:(NSUUID *)proximityUUID
                      major:(uint16_t)major
                      minor:(uint16_t)minor {
    self = [super init];
    
    if (self) {
        _proximityUUID = proximityUUID;
        _major = major;
        _minor = minor;
        _measuredPower = -50;
    }
    
    return self;
}


- (NSDictionary *)getAdvertisementData {
    NSString *key = @"kCBAdvDataAppleBeaconKey";
    
    unsigned char advertisementBytes[21] = {0};
    
    [_proximityUUID getUUIDBytes:(unsigned char *)&advertisementBytes];
    
    advertisementBytes[16] = (unsigned char)(_major >> 8);
    advertisementBytes[17] = (unsigned char)(_major & 255);
    
    advertisementBytes[18] = (unsigned char)(_minor >> 8);
    advertisementBytes[19] = (unsigned char)(_minor & 255);
    
    advertisementBytes[20] = _measuredPower;
    
    NSMutableData *advertisement = [NSMutableData dataWithBytes:advertisementBytes length:21];
    
    return [NSDictionary dictionaryWithObject:advertisement forKey:key];
}

@end
