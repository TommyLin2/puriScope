//
//  PDFViewController.m
//  puriSCOPE
//
//  Created by Christoph Stock on 05.05.10.
//  Copyright 2010 Dipl. Ing. Thonhauser GmbH. All rights reserved.
//

#import "PDFViewController.h"


@implementation PDFViewController



@synthesize webView, pdfURL;

#pragma mark -
#pragma mark UIViewController methods

// View Did Load method -- Load the PDF
- (void)viewDidLoad 
{
	[super viewDidLoad];
	// Tells the webView to load pdfUrl
	
	webView.multipleTouchEnabled=TRUE;
	[webView loadRequest:[NSURLRequest requestWithURL:pdfURL]];
}

-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	if(interfaceOrientation==UIInterfaceOrientationLandscapeRight)
	{
		return YES;
	}
	else
	{
		return NO;	
	}
}

- (IBAction)back
{
	[self dismissModalViewControllerAnimated:YES];

	
}


// Dealloc method -- webView, pdfURL
- (void)dealloc {
	[webView release];
	[pdfURL release];
	[super dealloc];
}


@end
