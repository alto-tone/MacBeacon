//
//  AppDelegate.m
//  MacBeacon
//
//  Created by Ayaka Tominaga on 2014/11/24.
//  Copyright (c) 2014年 Communication Planning Corporation. All rights reserved.
//

#import <IOBluetooth/IOBluetooth.h>

#import "AppDelegate.h"
#import "BeaconData.h"

@interface AppDelegate ()
{
    CBPeripheralManager *peripheralManager;
}

@property (weak) IBOutlet NSWindow *window;
@property (weak) IBOutlet NSTextField *uuidField;
@property (weak) IBOutlet NSTextField *majorField;
@property (weak) IBOutlet NSTextField *minorField;
@property (weak) IBOutlet NSTextField *errorLabel;

@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application
    
    _errorLabel.hidden = YES;
    
    _uuidField.stringValue = @"421AAA52-28CD-4CA0-88CA-A936F4C65BF8";
    _majorField.stringValue = @"10";
    _minorField.stringValue = @"10";
    
    // CBPeripheralManagerを初期化
    peripheralManager = [[CBPeripheralManager alloc] initWithDelegate:(id)self
                                                                queue:nil];
}

- (IBAction)onClickStart:(id)sender {
    if (peripheralManager.state == CBPeripheralManagerStatePoweredOn) {
        
        _uuidField.enabled = NO;
        _majorField.enabled = NO;
        _minorField.enabled = NO;
        
        //ビーコンの情報を設定
        NSString *strUuid = _uuidField.stringValue;
        NSString *strMajor = _majorField.stringValue;
        NSString *strMinor = _minorField.stringValue;
        
        if (strUuid.length == 0 || strMajor.length == 0 || strMinor.length == 0) {
            _errorLabel.hidden = NO;
            _uuidField.enabled = YES;
            _majorField.enabled = YES;
            _minorField.enabled = YES;
            return;
        } else {
            _errorLabel.hidden = YES;
        }
        
        NSUUID *proximityUUID = [[NSUUID alloc] initWithUUIDString:strUuid];
        int major = strMajor.intValue;
        int minor = strMinor.intValue;
        
        // アドバタイズ用のデータを作成
        BeaconData *beaconData = [[BeaconData alloc] initWithProximityUUID:proximityUUID
                                                                     major:major
                                                                     minor:minor];
        // アドバタイズ開始
        [peripheralManager startAdvertising:beaconData.getAdvertisementData];
    }
}

- (IBAction)onClickStop:(id)sender {
    //アドバタイズ停止
    [peripheralManager stopAdvertising];
    
    _uuidField.enabled = YES;
    _majorField.enabled = YES;
    _minorField.enabled = YES;
}

- (void)peripheralManagerDidUpdateState:(CBPeripheralManager *)peripheral {
    
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}

@end
