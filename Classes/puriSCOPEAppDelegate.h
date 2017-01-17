//
//  puriSCOPEAppDelegate.h
//  puriSCOPE
//
//  Created by Christoph Stock on 29.04.10.
//  Copyright Dipl. Ing. Thonhauser GmbH 2010. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "puriSCOPEViewController.h"
#import "OptionsViewController.h"

//@class puriSCOPEViewController;

@interface puriSCOPEAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    puriSCOPEViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
//@property (nonatomic, retain) IBOutlet puriSCOPEViewController *viewController;

@end

