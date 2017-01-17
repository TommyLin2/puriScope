/*
 *  hwcheck.h
 *  Pickers
 *
 *  Created by Christoph Stock on 19.04.10.
 *  Copyright 2010 Dipl. Ing. Thonhauser GmbH. All rights reserved.
 *
 */

//
//  UIDeviceHardware.h
//
//  Used to determine EXACT version of device software is running on.

#import <Foundation/Foundation.h>

@interface UIDeviceHardware : NSObject 

- (NSString *) platform;
- (NSString *) platformString;

@end