//
//  FlipsideViewController.h
//  utilitytest01
//
//  Created by Christoph Stock on 2009-09-01.
//  Copyright Thonhauser GesmbH 2009. All rights reserved.
//
//#import "PickersViewController.h"

#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>
#import "UIDeviceHardware.h"

@protocol OptionsViewControllerDelegate;

extern NSString *vgoodlab, *satislab, *inadeqlab;
extern float vgood,satis,R,G,B,blankR,blankG,blankB,sampleR,sampleG,sampleB;
extern uint DIA;
extern bool OPorIN,li,ugormg;



@interface OptionsViewController : UIViewController <UITextFieldDelegate,MFMailComposeViewControllerDelegate,UIActionSheetDelegate>
{
	UITextField *res0lab;
	UISlider *res0val;
	UITextField *res2lab;
	UISlider *res2val;
	UITextField *res4lab;
	UILabel *res0vallab;
	UILabel *res2vallab;
	
     UILabel *Rvalue;
	UILabel *Gvalue;
	UILabel *Bvalue;
	UIScrollView *scrollView;
	UISwitch *swsavereport;
	UISegmentedControl *swugormg;
	UIView *svinfo;
	UILabel *linktotm;
	UIButton *btndia01;
	UIButton *btndia02;
	UIButton *btndia03;
	UIButton *btndia04;
	UIButton *btndia05;
	UIButton *btndia06;
	UIButton *btndia07;
	UIButton *btndia08;
	UIButton *btndia09;
	UIButton *btndia10;
	UIView	*vwopt01;
	UIView	*vwopt02;
	UIView	*vwopt03;
	UIView	*vwopt04;
	UIButton *btnopt01;
	UIButton *btnopt02;
	UIButton *btnopt03;
	UIButton *btnopt04;
	UILabel	*lblrepcount;
	UILabel *lbldisporcip;
	UIView *vwgrayoutsel;
	UIView *vwnoli;
	UIView *vwjust3g;
	UITextField *txtcomp;
	UITextField *txtdep;
	UITextField *txtemail;
	UIButton *btnback;
	UIButton *btnregister;
	UILabel *lbloptions;
    
    
}

@property (nonatomic, assign) id <OptionsViewControllerDelegate> delegate;
@property(nonatomic, retain) IBOutlet UILabel *lbloptions;
@property(nonatomic, retain) IBOutlet UIView *svinfo;
@property(nonatomic, retain) IBOutlet UISegmentedControl *swugormg;
@property(nonatomic, retain) IBOutlet UISwitch *swsavereport;
@property(nonatomic, retain) IBOutlet UILabel *Rvalue;
@property(nonatomic, retain) IBOutlet UILabel *Gvalue;
@property(nonatomic, retain) IBOutlet UILabel *Bvalue;
@property(nonatomic, retain) IBOutlet UIButton *kalib;
@property(nonatomic, retain) IBOutlet UILabel *reslabel;
 
@property(nonatomic, retain) IBOutlet UITextField *res0lab;
@property(nonatomic, retain) IBOutlet UISlider *res0val;
@property(nonatomic, retain) IBOutlet UITextField *res2lab;
@property(nonatomic, retain) IBOutlet UISlider *res2val;
@property(nonatomic, retain) IBOutlet UITextField *res4lab;
@property(nonatomic, retain) IBOutlet UILabel *res0vallab;
@property(nonatomic, retain) IBOutlet UILabel *res2vallab;

@property(nonatomic, retain) IBOutlet UIScrollView *scrollView;
@property(nonatomic, retain) IBOutlet UIView *vwopt01;
@property(nonatomic, retain) IBOutlet UIView *vwopt02;
@property(nonatomic, retain) IBOutlet UIView *vwopt03;
@property(nonatomic, retain) IBOutlet UIView *vwopt04;
@property(nonatomic, retain) IBOutlet UIButton *btnopt01;
@property(nonatomic, retain) IBOutlet UIButton *btnopt02;
@property(nonatomic, retain) IBOutlet UIButton *btnopt03;
@property(nonatomic, retain) IBOutlet UIButton *btnopt04;
@property(nonatomic, retain) IBOutlet UILabel *lblrepcount;
@property(nonatomic, retain) IBOutlet UILabel *lbldisporcip;
@property(nonatomic, retain) IBOutlet UIView *vwgrayoutsel;
@property(nonatomic, retain) IBOutlet UIView *vwnoli;
@property(nonatomic, retain) IBOutlet UIView *vwjust3g; 
@property(nonatomic, retain) IBOutlet UITextField *txtcomp;
@property(nonatomic, retain) IBOutlet UITextField *txtdep;
@property(nonatomic, retain) IBOutlet UITextField *txtemail;
@property(nonatomic, retain) IBOutlet UIButton *btnback;
@property(nonatomic, retain) IBOutlet UIButton *btnregister;

@property(nonatomic, retain) IBOutlet UIButton *btndia01;
@property(nonatomic, retain) IBOutlet UIButton *btndia02;
@property(nonatomic, retain) IBOutlet UIButton *btndia03;
@property(nonatomic, retain) IBOutlet UIButton *btndia04;
@property(nonatomic, retain) IBOutlet UIButton *btndia05;
@property(nonatomic, retain) IBOutlet UIButton *btndia06;
@property(nonatomic, retain) IBOutlet UIButton *btndia07;
@property(nonatomic, retain) IBOutlet UIButton *btndia08;
@property(nonatomic, retain) IBOutlet UIButton *btndia09;
@property(nonatomic, retain) IBOutlet UIButton *btndia10;

- (IBAction)done;
- (IBAction)back;
- (IBAction)res0val:(id)sender;
- (IBAction)res2val:(id)sender;
- (IBAction)kalib:(id)sender;
- (IBAction)sendFTP:(id)sender;
- (IBAction)delplist:(id)sender;
- (IBAction)linktopdf:(id)sender;
- (IBAction)btndia01:(id)sender;
- (IBAction)btndia02:(id)sender;
- (IBAction)btndia03:(id)sender;
- (IBAction)btndia04:(id)sender;
- (IBAction)btndia05:(id)sender;
- (IBAction)btndia06:(id)sender;
- (IBAction)btndia07:(id)sender;
- (IBAction)btndia08:(id)sender;
- (IBAction)btndia09:(id)sender;
- (IBAction)btndia10:(id)sender;
- (IBAction)acbtnopt01:(id)sender;
- (IBAction)acbtnopt02:(id)sender;
- (IBAction)acbtnopt03:(id)sender;
- (IBAction)acbtnopt04:(id)sender;
- (IBAction)changeprocedure:(id)sender;
- (IBAction)registerpuri:(id)sender;

@end


@protocol OptionsViewControllerDelegate
- (void)OptionsViewControllerDidFinish:(OptionsViewController *)controller;
@end

