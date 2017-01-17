//
//  puriSCOPEAppDelegate.m
//  puriSCOPE
//
//  Created by Christoph Stock on 29.04.10.
//  Copyright Dipl. Ing. Thonhauser GmbH 2010. All rights reserved.
//

#import "puriSCOPEAppDelegate.h"
//#import "puriSCOPEViewController.h"

@implementation puriSCOPEAppDelegate

@synthesize window;
//@synthesize viewController;


- (void)applicationDidFinishLaunching:(UIApplication *)application {    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleBlackOpaque animated:NO];
    viewController = [[puriSCOPEViewController alloc] initWithNibName:@"puriSCOPEView" bundle:nil];
    viewController.view.frame = [[UIScreen mainScreen] applicationFrame];
    // Override point for customization after app launch    
    [window addSubview:viewController.view];
    [window makeKeyAndVisible];
}


- (void)dealloc {
    [viewController release];
    [window release];
    [super dealloc];
}


@end
