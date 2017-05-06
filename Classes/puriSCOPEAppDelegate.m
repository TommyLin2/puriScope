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
    window.frame = [[UIScreen mainScreen] bounds];
    [window setRootViewController:viewController];
}

- (void)dealloc {
}

-(UIInterfaceOrientationMask)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window
{
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        return UIInterfaceOrientationMaskAll;
    else  /* iphone */
        return UIInterfaceOrientationMaskAllButUpsideDown;
}
@end
