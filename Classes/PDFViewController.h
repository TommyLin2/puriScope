//
//  PDFViewController.h
//  puriSCOPE
//
//  Created by Christoph Stock on 05.05.10.
//  Copyright 2010 Dipl. Ing. Thonhauser GmbH. All rights reserved.
//

#import <UIKit/UIKit.h>
//@protocol PDFViewControllerDelegate;


@interface PDFViewController : UIViewController {
	
	UIWebView	*webView;
	NSURL		*pdfURL;
}

- (IBAction)back;

@property (nonatomic, retain) IBOutlet UIWebView	*webView;
@property (nonatomic, retain) NSURL					*pdfURL;


@end