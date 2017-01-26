//
//  FlipsideViewController.m
//  
//
//  Created by Christoph Stock on 2009-09-01.
//  Copyright Thonhauser GesmbH 2009. All rights reserved.
//

#import "OptionsViewController.h"
#import "PDFViewController.h"
//#import "S7FTPRequest.h"

@implementation OptionsViewController
@synthesize delegate,/*res0lab,res0vallab,res0val,res2lab,res2val,res2vallab,res4lab,*/lbloptions,svinfo,swugormg,swsavereport,Rvalue,Gvalue,Bvalue,kalib,reslabel,scrollView,vwopt01,vwopt02,vwopt03,vwopt04,btnopt01,btnopt02,btnopt03,btnopt04,lblrepcount,lbldisporcip,vwgrayoutsel,vwnoli,vwjust3g,txtcomp,txtdep,txtemail,btnback,btnregister,btndia01,btndia02,btndia03,btndia04,btndia05,btndia06,btndia07,btndia08,btndia09,btndia10,res0lab,res0val,res0vallab,res2lab,res2val,res4lab,res2vallab;

NSString *vgoodlab, *satislab, *inadeqlab,*thePath;
float vgood,good,satis,adeq,R,G,B,blankR,blankG,blankB,sampleR,sampleG,sampleB;
uint DIA;
bool OPorIN,li,ugormg;
int x=240,arlen;

- (void)viewDidLoad {
    [super viewDidLoad];
	btnback.hidden=TRUE;
	vwopt01.hidden=TRUE;
	vwopt02.hidden=TRUE;
	vwopt03.hidden=TRUE;
	vwopt04.hidden=TRUE;
	svinfo.hidden=TRUE;
	vwnoli.hidden=TRUE;
	if(li)
	{vwnoli.hidden=TRUE;
		
		if(OPorIN == TRUE)
		{	
			lbloptions.hidden=FALSE;
			if( [[NSUserDefaults standardUserDefaults] integerForKey:@"ugormg"]==0)
			{
				ugormg=FALSE;
				//@"ug/cm2 Organic";
			}else
			{
				ugormg=TRUE;
				//@"mg/l Organic";
			}
			
			
			/*CGRect rect01,rect02,rect03,rect04,rectvw02,rectvw03,rectvw04;
			 CGPoint pos01,pos02,pos03,pos04,posvw02,posvw03,posvw04;
			 
			 rect01.size.height=235;
			 rect01.size.width=480;
			 
			 rect02.size.height=20;
			 rect02.size.width=480;
			 
			 rect03.size.height=20;
			 rect03.size.width=480;
			 
			 rect04.size.height=20;
			 rect04.size.width=480;
			 
			 rectvw02.size.height=235;
			 rectvw02.size.width=480;
			 
			 rectvw03.size.height=235;
			 rectvw03.size.width=480;
			 
			 rectvw04.size.height=235;
			 rectvw04.size.width=480;
			 
			 
			 pos01.x=x;
			 pos02.x=x;
			 pos03.x=x;
			 pos04.x=x;
			 
			 posvw02.x=x;
			 posvw03.x=x;
			 posvw04.x=x;
			 
			 pos01.y=120;
			 pos02.y=250;
			 pos03.y=270;
			 pos04.y=290;
			 
			 posvw02.y=140;
			 posvw03.y=160;
			 posvw04.y=180;
			 
			 btnopt01.center=pos01;
			 vwopt01.center=pos01;
			 btnopt01.bounds=rect01;
			 vwopt01.bounds=rect01;
			 btnopt01.hidden=TRUE;
			 vwopt01.hidden=FALSE;
			 
			 btnopt02.center=pos02;
			 btnopt02.bounds=rect02;
			 btnopt02.hidden=FALSE;
			 vwopt02.hidden=TRUE;
			 vwopt02.center=posvw02;
			 vwopt02.bounds=rectvw02;
			 
			 btnopt03.center=pos03;
			 btnopt03.bounds=rect03;
			 btnopt03.hidden=FALSE;
			 vwopt03.hidden=TRUE;
			 vwopt03.center=posvw03;
			 vwopt03.bounds=rectvw03;
			 
			 btnopt04.center=pos04;
			 btnopt04.bounds=rect04;
			 btnopt04.hidden=FALSE;
			 vwopt04.hidden=TRUE;
			 vwopt04.center=posvw04;
			 vwopt04.bounds=rectvw04;
			 */
			vwnoli.hidden=TRUE;
			svinfo.hidden=TRUE;
            
			
			NSString *rootP = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES) objectAtIndex:0];
			thePath = [rootP stringByAppendingPathComponent:@"Data.xml"];
			NSMutableArray *fData = [[NSMutableArray alloc] initWithContentsOfFile:thePath];
			
			arlen = [fData count]-1;
			lblrepcount.text=[NSString stringWithFormat:@"%i Reportlines are ready to send",arlen];
			[fData release];
			
			svinfo.hidden=TRUE;
			self.view.backgroundColor = [UIColor whiteColor];
			
			vgood = [[NSUserDefaults standardUserDefaults] floatForKey:@"vgood"];
			res0val.value = vgood;
			res0vallab.text=[NSString stringWithFormat:@"%.2f",vgood];
			
			satis = [[NSUserDefaults standardUserDefaults] floatForKey:@"satis"];
			res2val.value = satis;
			res2vallab.text=[NSString stringWithFormat:@"%.2f",satis];
			
			
			
			vgoodlab = [[NSUserDefaults standardUserDefaults] stringForKey:@"vgoodlab"];
			res0lab.text = [[NSUserDefaults standardUserDefaults] stringForKey:@"vgoodlab"];
			
			satislab = [[NSUserDefaults standardUserDefaults] stringForKey:@"satislab"];
			res2lab.text = [[NSUserDefaults standardUserDefaults] stringForKey:@"satislab"];
			
			inadeqlab = [[NSUserDefaults standardUserDefaults] stringForKey:@"inadeqlab"];
			res4lab.text = [[NSUserDefaults standardUserDefaults] stringForKey:@"inadeqlab"];
			
			
			R = [[NSUserDefaults standardUserDefaults] floatForKey:@"BlankR"];
			Rvalue.text = [NSString stringWithFormat:@"%.2f",R];
			G= [[NSUserDefaults standardUserDefaults] floatForKey:@"BlankG"];
			Gvalue.text=[NSString stringWithFormat:@"%.2f",G];
			
			B = [[NSUserDefaults standardUserDefaults] floatForKey:@"BlankB"];
			Bvalue.text=[NSString stringWithFormat:@"%.2f",B];
			
			
			UIImage *stetchLeftTrack = [[UIImage imageNamed:@"tslider.png"]
										stretchableImageWithLeftCapWidth:10.0 topCapHeight:0.0];
			UIImage *stetchRightTrack = [[UIImage imageNamed:@"tslider.png"]
										 stretchableImageWithLeftCapWidth:10.0 topCapHeight:0.0];
			[res0val setThumbImage: [UIImage imageNamed:@"slider_ball.png"] forState:UIControlStateNormal];
			[res0val setThumbImage: [UIImage imageNamed:@"slider_ball.png"] forState:UIControlStateHighlighted];	
			[res0val setMinimumTrackImage:stetchLeftTrack forState:UIControlStateNormal];
			[res0val setMaximumTrackImage:stetchRightTrack forState:UIControlStateNormal];
			
			[res2val setThumbImage: [UIImage imageNamed:@"slider_ball.png"] forState:UIControlStateNormal];
			[res2val setThumbImage: [UIImage imageNamed:@"slider_ball.png"] forState:UIControlStateHighlighted];
			[res2val setMinimumTrackImage:stetchLeftTrack forState:UIControlStateNormal];
			[res2val setMaximumTrackImage:stetchRightTrack forState:UIControlStateNormal];
			
			swugormg.selectedSegmentIndex= [[NSUserDefaults standardUserDefaults] integerForKey:@"ugormg"];
			
			/*if(ugormg==FALSE)
			{
				lbldisporcip.text=@"dispensing";
				vwgrayoutsel.hidden=TRUE;
			}else
			{
				lbldisporcip.text=@"cip-verification";
				vwgrayoutsel.hidden=FALSE;
				
			}*/
			
			if(ugormg==FALSE)
			{
				lbldisporcip.text=@"dispensing";
				vwgrayoutsel.hidden=TRUE;
				btnopt01.enabled=TRUE;
				ugormg=FALSE;
			}else
			{
				lbldisporcip.text=@"cip-verification";
				vwgrayoutsel.hidden=FALSE;
				btnopt01.enabled=FALSE;
				ugormg=TRUE;
			}
			
						
			
			swsavereport.on= [[NSUserDefaults standardUserDefaults] boolForKey:@"savereport"];
			DIA = [[NSUserDefaults standardUserDefaults] integerForKey:@"DIAMETER"];
			
			if(DIA==1)
			{
				btndia01.backgroundColor = [UIColor colorWithRed:0.75 green:0.26 blue:0.59 alpha:1];
			}
			if(DIA==2)
			{
				btndia02.backgroundColor = [UIColor colorWithRed:0.75 green:0.26 blue:0.59 alpha:1];
			}
			if(DIA==3)
			{
				btndia03.backgroundColor = [UIColor colorWithRed:0.75 green:0.26 blue:0.59 alpha:1];
			}
			if(DIA==4)
			{
				btndia04.backgroundColor = [UIColor colorWithRed:0.75 green:0.26 blue:0.59 alpha:1];
			}		
			if(DIA==5)
			{
				btndia05.backgroundColor = [UIColor colorWithRed:0.75 green:0.26 blue:0.59 alpha:1];
			}	
			if(DIA==6)
			{
				btndia06.backgroundColor = [UIColor colorWithRed:0.75 green:0.26 blue:0.59 alpha:1];
			}
			if(DIA==7)
			{
				btndia07.backgroundColor = [UIColor colorWithRed:0.75 green:0.26 blue:0.59 alpha:1];
			}
			if(DIA==8)
			{
				btndia08.backgroundColor = [UIColor colorWithRed:0.75 green:0.26 blue:0.59 alpha:1];
			}
			if(DIA==9)
			{
				btndia09.backgroundColor = [UIColor colorWithRed:0.75 green:0.26 blue:0.59 alpha:1];
			}
			if(DIA==10)
			{
				btndia10.backgroundColor = [UIColor colorWithRed:0.75 green:0.26 blue:0.59 alpha:1];
			}
			if(DIA < 1 | DIA >10)
			{
				btndia01.backgroundColor = [UIColor colorWithRed:0.93 green:0.93 blue:0.93 alpha:1];
				btndia02.backgroundColor = [UIColor colorWithRed:0.98 green:0.98 blue:0.98 alpha:1];
				btndia03.backgroundColor = [UIColor colorWithRed:0.75 green:0.26 blue:0.59 alpha:1];
				btndia04.backgroundColor = [UIColor colorWithRed:0.98 green:0.98 blue:0.98 alpha:1];
				btndia05.backgroundColor = [UIColor colorWithRed:0.93 green:0.93 blue:0.93 alpha:1];
				btndia06.backgroundColor = [UIColor colorWithRed:0.98 green:0.98 blue:0.98 alpha:1];
				btndia07.backgroundColor = [UIColor colorWithRed:0.93 green:0.93 blue:0.93 alpha:1];
				btndia08.backgroundColor = [UIColor colorWithRed:0.98 green:0.98 blue:0.98 alpha:1];
				btndia09.backgroundColor = [UIColor colorWithRed:0.93 green:0.93 blue:0.93 alpha:1];
				btndia10.backgroundColor = [UIColor colorWithRed:0.98 green:0.98 blue:0.98 alpha:1];
				DIA=3;
			}
			
		}
		else
		{
			self.view.backgroundColor= [UIColor whiteColor];
			svinfo.hidden=FALSE;
			vwnoli.hidden=TRUE;
			btnopt01.hidden=TRUE;
			vwopt01.hidden=TRUE;
			btnopt02.hidden=TRUE;
			vwopt02.hidden=TRUE;
			btnopt03.hidden=TRUE;
			vwopt03.hidden=TRUE;
			btnopt04.hidden=TRUE;
			vwopt04.hidden=TRUE;
			lbloptions.hidden=TRUE;
            svinfo.exclusiveTouch = TRUE;
		}
		
	}else
	{
		UIDeviceHardware *h=[[UIDeviceHardware alloc] init];
		NSString *HardwareID = [h platformString];
		[h release];
		NSString *model = [[UIDevice currentDevice] model];
        NSLog(@"model %@",model);
		if([model isEqualToString:@"iPod touch"])
		{
			
			if([HardwareID isEqualToString:@"iPod Touch 4G"])
			{	vwjust3g.hidden=TRUE;
				txtdep.enabled=TRUE;
				txtcomp.enabled=TRUE;
				btnregister.enabled=TRUE;
			}else	
			{	
				txtdep.enabled=FALSE;
				txtcomp.enabled=FALSE;
				btnregister.enabled=FALSE;
			}
		}
		
		vwnoli.hidden=FALSE;
		lbloptions.hidden=TRUE;
		svinfo.hidden=TRUE;
		btnopt01.hidden=TRUE;
		vwopt01.hidden=TRUE;
		btnopt02.hidden=TRUE;
		vwopt02.hidden=TRUE;
		btnopt03.hidden=TRUE;
		vwopt03.hidden=TRUE;
		btnopt04.hidden=TRUE;
		vwopt04.hidden=TRUE;
	}
}



- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskLandscapeRight;
}

-(BOOL)shouldAutorotate
{
    return YES;
}

- ( BOOL)textFieldShouldReturn:(UITextField *)textField
{
	[textField resignFirstResponder];
	return NO;
}

- (IBAction)kalib:(id)sender
{
	UIActionSheet *cactionSheet = [[UIActionSheet alloc] initWithTitle:@"Do you really want to recalibrate this puriSCOPE?"delegate:self cancelButtonTitle:@"NO" destructiveButtonTitle:nil otherButtonTitles:@"YES",nil];
	cactionSheet.actionSheetStyle = UIActionSheetStyleBlackOpaque;
	cactionSheet.tag=0;
	[cactionSheet showInView:self.view]; // show from our table view (pops up in the middle of the table)
	[cactionSheet release];
	
}	
	




- (IBAction)changeprocedure:(id)sender
{
		if(swugormg.selectedSegmentIndex==0)
		{
			lbldisporcip.text=@"dispensing";
			vwgrayoutsel.hidden=TRUE;
			btnopt01.enabled=TRUE;
			ugormg=FALSE;
			
		}else
		{
			lbldisporcip.text=@"cip-verification";
			vwgrayoutsel.hidden=FALSE;
			btnopt01.enabled=FALSE;
			ugormg=TRUE;
		}
	[[NSUserDefaults standardUserDefaults] setInteger:swugormg.selectedSegmentIndex forKey:@"ugormg"];
}

- (IBAction)linktopdf:(id)sender
{
	PDFViewController *controller = [[PDFViewController alloc] initWithNibName:@"PDFView" bundle:nil];
	
	//NSString *saveDirectory = [documentPath objectAtIndex:0];
	//NSString *saveFileName = @"puriscope.pdf";
	//NSString *finalPath = [saveDirectory stringByAppendingPathComponent:saveFileName];
	
	
	NSString *finalPath = [[NSBundle mainBundle] pathForResource:@"puriscope" ofType:@"pdf"];
	
	//NSURL *pdfURL = [NSURL URLWithString:finalPath];
	controller.pdfURL = [NSURL fileURLWithPath:finalPath];
    [self presentViewController:controller animated:YES completion:nil];
	[controller release];
	
}



- (IBAction)delplist:(id)sender
{
	UIActionSheet *delactionSheet = [[UIActionSheet alloc] initWithTitle:@"Do You want to delete all Reportlines??"delegate:self cancelButtonTitle:@"NO" destructiveButtonTitle:nil otherButtonTitles:@"YES",nil];
	delactionSheet.actionSheetStyle = UIActionSheetStyleDefault;
	delactionSheet.tag=1;
	[delactionSheet showInView:self.view]; // show from our table view (pops up in the middle of the table)
	[delactionSheet release];
}


- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
		if(actionSheet.tag==0)
		{	if(buttonIndex==0)
			{
				R=sampleR-blankR;
				G=sampleG-blankG;
				B=sampleB-blankB;
			
			
				Rvalue.text= [NSString stringWithFormat:@"%.2f",R];
				Gvalue.text= [NSString stringWithFormat:@"%.2f",G];
				Bvalue.text= [NSString stringWithFormat:@"%.2f",B];
			
				[[NSUserDefaults standardUserDefaults] setFloat:R forKey:@"BlankR"];
			
				[[NSUserDefaults standardUserDefaults] setFloat:G forKey:@"BlankG"];
			
				[[NSUserDefaults standardUserDefaults] setFloat:B forKey:@"BlankB"];	
			
			}
		}else if(actionSheet.tag==1)
		{
			if(buttonIndex==0)
			{
				//Delete All Data from Array
				//int len,i;
				NSString *rootPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES) objectAtIndex:0];
				thePath = [rootPath stringByAppendingPathComponent:@"Data.xml"];
				//NSArray *cData;
				/*
				NSMutableArray *cData = [[NSMutableArray alloc] initWithContentsOfFile:thePath];
				
				len= [cData count]-1;
				for(i=0;i<=len;i++)
				{
					[cData removeObjectAtIndex:0];
					
				}
				*/
				NSArray *plistentries = [[NSArray alloc] initWithObjects:@"Date",@"Customer",@"Tag",@"Diameter",@"Result",@"\"ug or mg\"",@"BlankR",@"BlankG",@"BlankB",@"SampleR",@"SampleG",@"SampleB",nil];
				NSArray *cData = [[NSArray alloc] initWithObjects:plistentries,nil];
				[cData writeToFile:thePath atomically:YES];
				[plistentries release];
				[cData release];
				
				UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"REPORT" message:[NSString stringWithFormat:@"Report with %i lines deleted!",arlen] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
				[alert show];
				[alert release];
				lblrepcount.text=[NSString stringWithFormat:@"0 Reportlines are ready to send"];
			}
		}	
		
}


-(void)textFieldDidBeginEditing:(UITextField *)textField 
{ //Keyboard becomes visible
    
	if(textField==txtdep)
	{
		
		[UIView beginAnimations:nil context:NULL];
		[UIView setAnimationDuration:0.5];
		
		
		CGPoint pos1new;
		pos1new.x=240;
		pos1new.y=vwnoli.center.y-58;
		vwnoli.center=pos1new;
		[UIView commitAnimations];
		
		
	}
	
	if(textField==txtemail)
	{
		[UIView beginAnimations:nil context:NULL];
		[UIView setAnimationDuration:0.5];
		
		
		CGPoint pos1new;
		pos1new.x=240;
		pos1new.y=vwnoli.center.y-116;
		vwnoli.center=pos1new;
		[UIView commitAnimations];
		
		
	}
	
	
	
	if(textField!=res0lab) 
	{
		[UIView beginAnimations:nil context:NULL];
		[UIView setAnimationDuration:0.5];
		
		lbloptions.hidden=TRUE;
		CGPoint posnew;
		posnew.x=x;
		if(textField==res2lab)
		{
			posnew.y=25;
		}
		else
		{
			posnew.y=-52;
		}
		
		vwopt01.center=posnew;
		[UIView commitAnimations];
	}
}




-(void)textFieldDidEndEditing:(UITextField *)textField { //keyboard will hide

if(textField!=res0lab) 
{
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:0.5];
	
	lbloptions.hidden=FALSE;
	CGPoint posnew;
	posnew.x=x;
	posnew.y=140;
	vwopt01.center=posnew;
	[UIView commitAnimations];
}	
	
	
	if(textField==txtdep || textField==txtemail)
	{
		[UIView beginAnimations:nil context:NULL];
		[UIView setAnimationDuration:0.5];
		
		
		CGPoint pos2new;
		pos2new.x=240;
		pos2new.y=140;
		vwnoli.center=pos2new;
		[UIView commitAnimations];
		
		
	}
	
	
}



- (IBAction)btndia01:(id)sender
{	
	btndia01.backgroundColor = [UIColor colorWithRed:0.75 green:0.26 blue:0.59 alpha:1];
	btndia02.backgroundColor = [UIColor colorWithRed:0.98 green:0.98 blue:0.98 alpha:1];
	btndia03.backgroundColor = [UIColor colorWithRed:0.93 green:0.93 blue:0.93 alpha:1];
	btndia04.backgroundColor = [UIColor colorWithRed:0.98 green:0.98 blue:0.98 alpha:1];
	btndia05.backgroundColor = [UIColor colorWithRed:0.93 green:0.93 blue:0.93 alpha:1];
	btndia06.backgroundColor = [UIColor colorWithRed:0.98 green:0.98 blue:0.98 alpha:1];
	btndia07.backgroundColor = [UIColor colorWithRed:0.93 green:0.93 blue:0.93 alpha:1];
	btndia08.backgroundColor = [UIColor colorWithRed:0.98 green:0.98 blue:0.98 alpha:1];
	btndia09.backgroundColor = [UIColor colorWithRed:0.93 green:0.93 blue:0.93 alpha:1];
	btndia10.backgroundColor = [UIColor colorWithRed:0.98 green:0.98 blue:0.98 alpha:1];
	DIA = 1;
	
	[[NSUserDefaults standardUserDefaults] setInteger:DIA forKey:@"DIAMETER"];

	
}
- (IBAction)btndia02:(id)sender
{
	btndia01.backgroundColor = [UIColor colorWithRed:0.93 green:0.93 blue:0.93 alpha:1];
	btndia02.backgroundColor = [UIColor colorWithRed:0.75 green:0.26 blue:0.59 alpha:1];
	btndia03.backgroundColor = [UIColor colorWithRed:0.93 green:0.93 blue:0.93 alpha:1];
	btndia04.backgroundColor = [UIColor colorWithRed:0.98 green:0.98 blue:0.98 alpha:1];
	btndia05.backgroundColor = [UIColor colorWithRed:0.93 green:0.93 blue:0.93 alpha:1];
	btndia06.backgroundColor = [UIColor colorWithRed:0.98 green:0.98 blue:0.98 alpha:1];
	btndia07.backgroundColor = [UIColor colorWithRed:0.93 green:0.93 blue:0.93 alpha:1];
	btndia08.backgroundColor = [UIColor colorWithRed:0.98 green:0.98 blue:0.98 alpha:1];
	btndia09.backgroundColor = [UIColor colorWithRed:0.93 green:0.93 blue:0.93 alpha:1];
	btndia10.backgroundColor = [UIColor colorWithRed:0.98 green:0.98 blue:0.98 alpha:1];
	
	DIA = 2;
	[[NSUserDefaults standardUserDefaults] setInteger:DIA forKey:@"DIAMETER"];

}
- (IBAction)btndia03:(id)sender
{
	btndia01.backgroundColor = [UIColor colorWithRed:0.93 green:0.93 blue:0.93 alpha:1];
	btndia02.backgroundColor = [UIColor colorWithRed:0.98 green:0.98 blue:0.98 alpha:1];
	btndia03.backgroundColor = [UIColor colorWithRed:0.75 green:0.26 blue:0.59 alpha:1];
	btndia04.backgroundColor = [UIColor colorWithRed:0.98 green:0.98 blue:0.98 alpha:1];
	btndia05.backgroundColor = [UIColor colorWithRed:0.93 green:0.93 blue:0.93 alpha:1];
	btndia06.backgroundColor = [UIColor colorWithRed:0.98 green:0.98 blue:0.98 alpha:1];
	btndia07.backgroundColor = [UIColor colorWithRed:0.93 green:0.93 blue:0.93 alpha:1];
	btndia08.backgroundColor = [UIColor colorWithRed:0.98 green:0.98 blue:0.98 alpha:1];
	btndia09.backgroundColor = [UIColor colorWithRed:0.93 green:0.93 blue:0.93 alpha:1];
	btndia10.backgroundColor = [UIColor colorWithRed:0.98 green:0.98 blue:0.98 alpha:1];	
	DIA = 3;
	[[NSUserDefaults standardUserDefaults] setInteger:DIA forKey:@"DIAMETER"];

}
- (IBAction)btndia04:(id)sender
{
	btndia01.backgroundColor = [UIColor colorWithRed:0.93 green:0.93 blue:0.93 alpha:1];
	btndia02.backgroundColor = [UIColor colorWithRed:0.98 green:0.98 blue:0.98 alpha:1];
	btndia03.backgroundColor = [UIColor colorWithRed:0.93 green:0.93 blue:0.93 alpha:1];
	btndia04.backgroundColor = [UIColor colorWithRed:0.75 green:0.26 blue:0.59 alpha:1];
	btndia05.backgroundColor = [UIColor colorWithRed:0.93 green:0.93 blue:0.93 alpha:1];
	btndia06.backgroundColor = [UIColor colorWithRed:0.98 green:0.98 blue:0.98 alpha:1];
	btndia07.backgroundColor = [UIColor colorWithRed:0.93 green:0.93 blue:0.93 alpha:1];
	btndia08.backgroundColor = [UIColor colorWithRed:0.98 green:0.98 blue:0.98 alpha:1];
	btndia09.backgroundColor = [UIColor colorWithRed:0.93 green:0.93 blue:0.93 alpha:1];
	btndia10.backgroundColor = [UIColor colorWithRed:0.98 green:0.98 blue:0.98 alpha:1];
	
	DIA = 4;
	[[NSUserDefaults standardUserDefaults] setInteger:DIA forKey:@"DIAMETER"];

}
- (IBAction)btndia05:(id)sender
{
	btndia01.backgroundColor = [UIColor colorWithRed:0.93 green:0.93 blue:0.93 alpha:1];
	btndia02.backgroundColor = [UIColor colorWithRed:0.98 green:0.98 blue:0.98 alpha:1];
	btndia03.backgroundColor = [UIColor colorWithRed:0.93 green:0.93 blue:0.93 alpha:1];
	btndia04.backgroundColor = [UIColor colorWithRed:0.98 green:0.98 blue:0.98 alpha:1];
	btndia05.backgroundColor = [UIColor colorWithRed:0.75 green:0.26 blue:0.59 alpha:1];
	btndia06.backgroundColor = [UIColor colorWithRed:0.98 green:0.98 blue:0.98 alpha:1];
	btndia07.backgroundColor = [UIColor colorWithRed:0.93 green:0.93 blue:0.93 alpha:1];
	btndia08.backgroundColor = [UIColor colorWithRed:0.98 green:0.98 blue:0.98 alpha:1];
	btndia09.backgroundColor = [UIColor colorWithRed:0.93 green:0.93 blue:0.93 alpha:1];
	btndia10.backgroundColor = [UIColor colorWithRed:0.98 green:0.98 blue:0.98 alpha:1];
	
	DIA = 5;
	[[NSUserDefaults standardUserDefaults] setInteger:DIA forKey:@"DIAMETER"];

}
- (IBAction)btndia06:(id)sender
{
	btndia01.backgroundColor = [UIColor colorWithRed:0.93 green:0.93 blue:0.93 alpha:1];
	btndia02.backgroundColor = [UIColor colorWithRed:0.98 green:0.98 blue:0.98 alpha:1];
	btndia03.backgroundColor = [UIColor colorWithRed:0.93 green:0.93 blue:0.93 alpha:1];
	btndia04.backgroundColor = [UIColor colorWithRed:0.98 green:0.98 blue:0.98 alpha:1];
	btndia05.backgroundColor = [UIColor colorWithRed:0.93 green:0.93 blue:0.93 alpha:1];
	btndia06.backgroundColor = [UIColor colorWithRed:0.75 green:0.26 blue:0.59 alpha:1];
	btndia07.backgroundColor = [UIColor colorWithRed:0.93 green:0.93 blue:0.93 alpha:1];
	btndia08.backgroundColor = [UIColor colorWithRed:0.98 green:0.98 blue:0.98 alpha:1];
	btndia09.backgroundColor = [UIColor colorWithRed:0.93 green:0.93 blue:0.93 alpha:1];
	btndia10.backgroundColor = [UIColor colorWithRed:0.98 green:0.98 blue:0.98 alpha:1];	
	DIA = 6;
	[[NSUserDefaults standardUserDefaults] setInteger:DIA forKey:@"DIAMETER"];

}
- (IBAction)btndia07:(id)sender
{
	btndia01.backgroundColor = [UIColor colorWithRed:0.93 green:0.93 blue:0.93 alpha:1];
	btndia02.backgroundColor = [UIColor colorWithRed:0.98 green:0.98 blue:0.98 alpha:1];
	btndia03.backgroundColor = [UIColor colorWithRed:0.93 green:0.93 blue:0.93 alpha:1];
	btndia04.backgroundColor = [UIColor colorWithRed:0.98 green:0.98 blue:0.98 alpha:1];
	btndia05.backgroundColor = [UIColor colorWithRed:0.93 green:0.93 blue:0.93 alpha:1];
	btndia06.backgroundColor = [UIColor colorWithRed:0.98 green:0.98 blue:0.98 alpha:1];
	btndia07.backgroundColor = [UIColor colorWithRed:0.75 green:0.26 blue:0.59 alpha:1];
	btndia08.backgroundColor = [UIColor colorWithRed:0.98 green:0.98 blue:0.98 alpha:1];
	btndia09.backgroundColor = [UIColor colorWithRed:0.93 green:0.93 blue:0.93 alpha:1];
	btndia10.backgroundColor = [UIColor colorWithRed:0.98 green:0.98 blue:0.98 alpha:1];	
	DIA = 7;
	[[NSUserDefaults standardUserDefaults] setInteger:DIA forKey:@"DIAMETER"];

}
- (IBAction)btndia08:(id)sender
{
	btndia01.backgroundColor = [UIColor colorWithRed:0.93 green:0.93 blue:0.93 alpha:1];
	btndia02.backgroundColor = [UIColor colorWithRed:0.98 green:0.98 blue:0.98 alpha:1];
	btndia03.backgroundColor = [UIColor colorWithRed:0.93 green:0.93 blue:0.93 alpha:1];
	btndia04.backgroundColor = [UIColor colorWithRed:0.98 green:0.98 blue:0.98 alpha:1];
	btndia05.backgroundColor = [UIColor colorWithRed:0.93 green:0.93 blue:0.93 alpha:1];
	btndia06.backgroundColor = [UIColor colorWithRed:0.98 green:0.98 blue:0.98 alpha:1];
	btndia07.backgroundColor = [UIColor colorWithRed:0.93 green:0.93 blue:0.93 alpha:1];
	btndia08.backgroundColor = [UIColor colorWithRed:0.75 green:0.26 blue:0.59 alpha:1];
	btndia09.backgroundColor = [UIColor colorWithRed:0.93 green:0.93 blue:0.93 alpha:1];
	btndia10.backgroundColor = [UIColor colorWithRed:0.98 green:0.98 blue:0.98 alpha:1];
	
	DIA = 8;
	[[NSUserDefaults standardUserDefaults] setInteger:DIA forKey:@"DIAMETER"];

}
- (IBAction)btndia09:(id)sender
{
	btndia01.backgroundColor = [UIColor colorWithRed:0.93 green:0.93 blue:0.93 alpha:1];
	btndia02.backgroundColor = [UIColor colorWithRed:0.98 green:0.98 blue:0.98 alpha:1];
	btndia03.backgroundColor = [UIColor colorWithRed:0.93 green:0.93 blue:0.93 alpha:1];
	btndia04.backgroundColor = [UIColor colorWithRed:0.98 green:0.98 blue:0.98 alpha:1];
	btndia05.backgroundColor = [UIColor colorWithRed:0.93 green:0.93 blue:0.93 alpha:1];
	btndia06.backgroundColor = [UIColor colorWithRed:0.98 green:0.98 blue:0.98 alpha:1];
	btndia07.backgroundColor = [UIColor colorWithRed:0.93 green:0.93 blue:0.93 alpha:1];
	btndia08.backgroundColor = [UIColor colorWithRed:0.98 green:0.98 blue:0.98 alpha:1];
	btndia09.backgroundColor = [UIColor colorWithRed:0.75 green:0.26 blue:0.59 alpha:1];
	btndia10.backgroundColor = [UIColor colorWithRed:0.98 green:0.98 blue:0.98 alpha:1];
	
	DIA = 9;
	[[NSUserDefaults standardUserDefaults] setInteger:DIA forKey:@"DIAMETER"];

}
- (IBAction)btndia10:(id)sender
{
	btndia01.backgroundColor = [UIColor colorWithRed:0.93 green:0.93 blue:0.93 alpha:1];
	btndia02.backgroundColor = [UIColor colorWithRed:0.98 green:0.98 blue:0.98 alpha:1];
	btndia03.backgroundColor = [UIColor colorWithRed:0.93 green:0.93 blue:0.93 alpha:1];
	btndia04.backgroundColor = [UIColor colorWithRed:0.98 green:0.98 blue:0.98 alpha:1];
	btndia05.backgroundColor = [UIColor colorWithRed:0.93 green:0.93 blue:0.93 alpha:1];
	btndia06.backgroundColor = [UIColor colorWithRed:0.98 green:0.98 blue:0.98 alpha:1];
	btndia07.backgroundColor = [UIColor colorWithRed:0.93 green:0.93 blue:0.93 alpha:1];
	btndia08.backgroundColor = [UIColor colorWithRed:0.98 green:0.98 blue:0.98 alpha:1];
	btndia09.backgroundColor = [UIColor colorWithRed:0.93 green:0.93 blue:0.93 alpha:1];
	btndia10.backgroundColor = [UIColor colorWithRed:0.75 green:0.26 blue:0.59 alpha:1];

	DIA = 10;
	[[NSUserDefaults standardUserDefaults] setInteger:DIA forKey:@"DIAMETER"];

}




/*
- (IBAction)acbtnopt01:(id)sender
{	vwnoli.hidden=TRUE;
	vwjust3g.hidden=TRUE;
	svinfo.hidden=TRUE;
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:0.5];
	
	CGRect rect01,rect02,rect03,rect04;
	CGPoint pos01,pos02,pos03,pos04;
	
	rect01.size.height=235;
	rect01.size.width=480;
	
	rect02.size.height=20;
	rect02.size.width=480;
	
	rect03.size.height=20;
	rect03.size.width=480;
	
	rect04.size.height=20;
	rect04.size.width=480;
	
	pos01.x=x;
	pos02.x=x;
	pos03.x=x;
	pos04.x=x;
	
	pos01.y=120;
	pos02.y=250;
	pos03.y=270;
	pos04.y=290;
	
	//btnopt01.center=pos01;
	//btnopt01.bounds=rect01;
	btnopt01.hidden=TRUE;
	vwopt01.hidden=FALSE;

	btnopt02.center=pos02;
	btnopt02.bounds=rect02;
	btnopt02.hidden=FALSE;
	vwopt02.hidden=TRUE;

	
	btnopt03.center=pos03;
	btnopt03.bounds=rect03;
	btnopt03.hidden=FALSE;
	vwopt03.hidden=TRUE;

	btnopt04.center=pos04;
	btnopt04.bounds=rect04;
	btnopt04.hidden=FALSE;
	vwopt04.hidden=TRUE;

	
	[UIView commitAnimations];

}

- (IBAction)acbtnopt02:(id)sender
{	vwnoli.hidden=TRUE;
	vwjust3g.hidden=TRUE;
	svinfo.hidden=TRUE;
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:0.5];
	
	CGRect rect01,rect02,rect03,rect04;
	CGPoint pos01,pos02,pos03,pos04;
	

	
	rect01.size.height=20;
	rect01.size.width=480;
	
	rect02.size.height=235;
	rect02.size.width=480;
	
	rect03.size.height=20;
	rect03.size.width=480;
	
	rect04.size.height=20;
	rect04.size.width=480;
	
	pos01.x=x;
	pos02.x=x;
	pos03.x=x;
	pos04.x=x;
	
	pos01.y=10;
	pos02.y=140;
	pos03.y=270;
	pos04.y=290;
	
	btnopt01.center=pos01;
	btnopt01.bounds=rect01;
	btnopt01.hidden=FALSE;
	vwopt01.hidden=TRUE;

	//btnopt02.center=pos02;
	//btnopt02.bounds=rect02;
	btnopt02.hidden=TRUE;
	vwopt02.hidden=FALSE;

	btnopt03.center=pos03;
	btnopt03.bounds=rect03;
	btnopt03.hidden=FALSE;
	vwopt03.hidden=TRUE;

	btnopt04.center=pos04;
	btnopt04.bounds=rect04;
	btnopt04.hidden=FALSE;
	vwopt04.hidden=TRUE;

	[UIView commitAnimations];

}
- (IBAction)acbtnopt03:(id)sender
{	vwnoli.hidden=TRUE;
	vwjust3g.hidden=TRUE;
	svinfo.hidden=TRUE;
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:0.5];
	
	CGRect rect01,rect02,rect03,rect04;
	CGPoint pos01,pos02,pos03,pos04;
	
	rect01.size.height=20;
	rect01.size.width=480;
	
	rect02.size.height=20;
	rect02.size.width=480;
	
	rect03.size.height=235;
	rect03.size.width=480;
	
	rect04.size.height=20;
	rect04.size.width=480;
	
	pos01.x=x;
	pos02.x=x;
	pos03.x=x;
	pos04.x=x;
	
	pos01.y=10;
	pos02.y=30;
	pos03.y=160;
	pos04.y=290;
	
	btnopt01.center=pos01;
	btnopt01.bounds=rect01;
	btnopt01.hidden=FALSE;
	vwopt01.hidden=TRUE;
	
	btnopt02.center=pos02;
	btnopt02.bounds=rect02;
	btnopt02.hidden=FALSE;
	vwopt02.hidden=TRUE;
	
	//btnopt03.center=pos03;
	//btnopt03.bounds=rect03;
	btnopt03.hidden=TRUE;
	vwopt03.hidden=FALSE;
	
	btnopt04.center=pos04;
	btnopt04.bounds=rect04;
	btnopt04.hidden=FALSE;
	vwopt04.hidden=TRUE;
	
	[UIView commitAnimations];

}
- (IBAction)acbtnopt04:(id)sender
{	
	vwnoli.hidden=TRUE;
	vwjust3g.hidden=TRUE;
	svinfo.hidden=TRUE;
	
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:0.5];
	
	CGRect rect01,rect02,rect03,rect04;
	CGPoint pos01,pos02,pos03,pos04;
	

	
	rect01.size.height=20;
	rect01.size.width=480;
	
	rect02.size.height=20;
	rect02.size.width=480;
	
	rect03.size.height=20;
	rect03.size.width=480;
	
	rect04.size.height=235;
	rect04.size.width=480;
	
	pos01.x=x;
	pos02.x=x;
	pos03.x=x;
	pos04.x=x;
	
	pos01.y=10;
	pos02.y=30;
	pos03.y=50;
	pos04.y=180;
	
	btnopt01.center=pos01;
	btnopt01.bounds=rect01;
	btnopt01.hidden=FALSE;
	vwopt01.hidden=TRUE;
	
	btnopt02.center=pos02;
	btnopt02.bounds=rect02;
	btnopt02.hidden=FALSE;
	vwopt02.hidden=TRUE;
	
	btnopt03.center=pos03;
	btnopt03.bounds=rect03;
	btnopt03.hidden=FALSE;
	vwopt03.hidden=TRUE;
	
	//btnopt04.center=pos04;
	//btnopt04.bounds=rect04;
	btnopt04.hidden=TRUE;
	vwopt04.hidden=FALSE;

	[UIView commitAnimations];

}
*/

-(IBAction)acbtnopt01:(id)sender
{
	CGRect rectFS;
	CGPoint ptFS;
	rectFS.size.height=280;
	rectFS.size.width=480;
	ptFS.x=240;
	ptFS.y=140;
	
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:0.5];

	
	btnopt01.hidden=TRUE;
	btnopt02.hidden=TRUE;
	btnopt03.hidden=TRUE;
	btnopt04.hidden=TRUE;
	
	vwopt01.center=ptFS;
	vwopt01.bounds=rectFS;
	vwopt01.hidden=FALSE;
	
	vwopt02.hidden=TRUE;
	vwopt03.hidden=TRUE;
	vwopt04.hidden=TRUE;

	btnback.hidden=FALSE;

	
	[UIView commitAnimations];
}

-(IBAction)acbtnopt02:(id)sender
{
	CGRect rectFS;
	CGPoint ptFS;
	rectFS.size.height=280;
	rectFS.size.width=480;
	ptFS.x=240;
	ptFS.y=140;
	
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:0.5];
	
	
	btnopt01.hidden=TRUE;
	btnopt02.hidden=TRUE;
	btnopt03.hidden=TRUE;
	btnopt04.hidden=TRUE;
	
	vwopt02.center=ptFS;
	vwopt02.bounds=rectFS;
	vwopt02.hidden=FALSE;
	
	vwopt01.hidden=TRUE;
	vwopt03.hidden=TRUE;
	vwopt04.hidden=TRUE;
		
	btnback.hidden=FALSE;

	[UIView commitAnimations];
}

-(IBAction)acbtnopt03:(id)sender
{
	CGRect rectFS;
	CGPoint ptFS;
	rectFS.size.height=280;
	rectFS.size.width=480;
	ptFS.x=240;
	ptFS.y=140;
	
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:0.5];
	
	
	btnopt01.hidden=TRUE;
	btnopt02.hidden=TRUE;
	btnopt03.hidden=TRUE;
	btnopt04.hidden=TRUE;
	
	vwopt03.center=ptFS;
	vwopt03.bounds=rectFS;
	vwopt03.hidden=FALSE;
	
	vwopt02.hidden=TRUE;
	vwopt01.hidden=TRUE;
	vwopt04.hidden=TRUE;
	
	btnback.hidden=FALSE;

	
	[UIView commitAnimations];
}

-(IBAction)acbtnopt04:(id)sender
{
	CGRect rectFS;
	CGPoint ptFS;
	rectFS.size.height=280;
	rectFS.size.width=480;
	ptFS.x=240;
	ptFS.y=140;
	
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:0.5];
	
	
	btnopt01.hidden=TRUE;
	btnopt02.hidden=TRUE;
	btnopt03.hidden=TRUE;
	btnopt04.hidden=TRUE;
	
	vwopt04.center=ptFS;
	vwopt04.bounds=rectFS;
	
	vwopt04.hidden=FALSE;
	vwopt02.hidden=TRUE;
	vwopt03.hidden=TRUE;
	vwopt01.hidden=TRUE;
	
	btnback.hidden=FALSE;

	
	[UIView commitAnimations];
}

- (IBAction)back
{
	btnopt01.hidden=FALSE;
	btnopt02.hidden=FALSE;
	btnopt03.hidden=FALSE;
	btnopt04.hidden=FALSE;
	vwopt04.hidden=TRUE;
	vwopt02.hidden=TRUE;
	vwopt03.hidden=TRUE;
	vwopt01.hidden=TRUE;
	btnback.hidden=TRUE;
	
}

- (IBAction)res0val:(id)sender
{
	res0vallab.text=[NSString stringWithFormat:@"%.2f",res0val.value];
	vgood=res0val.value;
	[[NSUserDefaults standardUserDefaults] setFloat:vgood forKey:@"vgood"];
	
	if(res2val.value <= res0val.value)
	{
		res2val.value= res0val.value;
		res2vallab.text=[NSString stringWithFormat:@"%.2f",res2val.value];
	}
		
}

- (IBAction)sendFTP:(id)sender;
{	NSString *rootPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES) objectAtIndex:0];
	NSString *thePath2 = [rootPath stringByAppendingPathComponent:@"puriSCOPE.csv"];
	thePath = [rootPath stringByAppendingPathComponent:@"Data.xml"];
	
	NSFileManager *fileManager = [NSFileManager defaultManager];
	[fileManager createFileAtPath:thePath2 contents:nil attributes:nil];
	NSFileHandle* pfile = [NSFileHandle fileHandleForWritingAtPath:thePath2];
	NSMutableArray *dData = [[NSMutableArray alloc] initWithContentsOfFile:thePath];
	
	
	int i,len=([dData count]-1);
	NSString *outd = [[NSString alloc] initWithString:@""];
	for(i=0;i<=len;i++)
	{
		NSArray *newd = [[NSArray alloc] initWithArray:[dData objectAtIndex:i]];
		int u,leng=([newd count]-1);
		NSString *outdn=[[NSString alloc]initWithString:@""],*unew;
		for(u=0;u<=leng;u++)
		{
			unew = [newd objectAtIndex:u];
			if(u==leng)
			{
				outdn = [NSString stringWithFormat:@"%@%@",outdn,unew];
			}else
			{	outdn = [NSString stringWithFormat:@"%@%@,",outdn,unew];
			}	
		}
		outd = [NSString stringWithFormat:@"%@\n%@",outd,outdn];
		[newd release];
	}
	[pfile writeData:[[NSString stringWithFormat:@"%@",outd] dataUsingEncoding:NSUTF8StringEncoding]];
	//NSLog(@"%@",outd);
	[dData release];
	
		
	Class mailClass = (NSClassFromString(@"MFMailComposeViewController"));
	if (mailClass != nil)
	{
		// We must always check whether the current device is configured for sending emails
		if ([mailClass canSendMail])
		{
			MFMailComposeViewController *picker = [[MFMailComposeViewController alloc] init];
			picker.mailComposeDelegate = self;
			
			[picker setSubject:@"Hello from puriSCOPE"];
			NSString *rootPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES) objectAtIndex:0];
			NSString *thePath2 = [rootPath stringByAppendingPathComponent:@"puriSCOPE.csv"];

			//NSArray *toRecipients = [NSArray arrayWithObject:@"c.stock@thonhauser.net"]; 
			
			
			//[picker setBccRecipients:toRecipients];
			
			
			// Attach an image to the email
			//NSString *path = [[NSBundle mainBundle] pathForResource:@"PUREiSCOPE" ofType:@"csv"];
			NSData *myData = [NSData dataWithContentsOfFile:thePath2];
			[picker addAttachmentData:myData mimeType:@"csv" fileName:@"puriSCOPE.csv"];
			
			// Fill out the email body text
			NSString *emailBody = @"Your results from your puriSCOPE tests are attached.";
			[picker setMessageBody:emailBody isHTML:NO];
            [self presentViewController:picker animated:YES completion:nil];
			[picker release];
			
		}
		else
		{
			UIAlertView *mailaccount = [[UIAlertView alloc] initWithTitle:@"MESSAGE delivery" message:@"Please check your Mail Account" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
			[mailaccount show];
			[mailaccount release];
		}
	}
	else
	{
		UIAlertView *mailaccount = [[UIAlertView alloc] initWithTitle:@"MESSAGE delivery" message:@"Please check your Mail Account" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
		[mailaccount show];
		[mailaccount release];
	}
	
}




// Dismisses the email composition interface when users tap Cancel or Send. Proceeds to update the message field with the result of the operation.
- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error 
{	NSString *message=@"";
	//message.hidden = NO;
	// Notifies users about errors associated with the interface
	switch (result)
	{	
			
		case MFMailComposeResultCancelled:
			message = @"Result: canceled";
			break;
		case MFMailComposeResultSaved:
			message= @"Result: saved";
			break;
		case MFMailComposeResultSent:
			message = @"Result: sent";
			break;
		case MFMailComposeResultFailed:
			message = @"Result: failed";
			break;
		default:
			message = @"Result: not sent";
			break;
	}
	//NSLog(message);
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"MESSAGE delivery" message:message delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
	
	//alert.actionSheetStyle = UIActionSheetStyleDefault;
	[alert show];	// show from our table view (pops up in the middle of the table)
	[alert release];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)res2val:(id)sender
{
	//res2vallab.text=[NSString stringWithFormat:@"%.2f",res2val.value];
	satis=res2val.value;
	[[NSUserDefaults standardUserDefaults] setFloat:satis forKey:@"satis"];

	if(res2val.value <=res0val.value)
	{
		res2val.value=res0val.value;
		res2vallab.text=[NSString stringWithFormat:@"%.2f",res0val.value];
	}
	
	if(res2val.value > res0val.value)
	{
		res2vallab.text=[NSString stringWithFormat:@"%.2f",res2val.value];
	}
}

- (IBAction)registerpuri:(id)sender;
{
	
	if([txtcomp.text length]<=1 | [txtdep.text length]<=1 | [txtemail.text length]<=6)
	{
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"REGISTRATION" message:@"Please fill in your data correctly" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
		[alert show];
		[alert release];
	}else
	{
		
	
	NSString *Version = [[UIDevice currentDevice] systemVersion];

	NSString *UUID = [[UIDevice currentDevice] uniqueIdentifier];
	NSString *rootPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES) objectAtIndex:0];
	NSString *thePath3 = [rootPath stringByAppendingPathComponent:@"act_puriSCOPE.csv"];	

	NSFileManager *fileManager = [NSFileManager defaultManager];
	[fileManager createFileAtPath:thePath3 contents:nil attributes:nil];
	NSFileHandle* pfile = [NSFileHandle fileHandleForWritingAtPath:thePath3];
	[pfile writeData:[[NSString stringWithFormat:@"%@,%@,%@,%@,%@\n\r",txtcomp.text,txtdep.text,txtemail.text,Version,UUID] dataUsingEncoding:NSUTF8StringEncoding]];
	
			
			Class mailClass = (NSClassFromString(@"MFMailComposeViewController"));
			if (mailClass != nil)
			{
				// We must always check whether the current device is configured for sending emails
				if ([mailClass canSendMail])
				{
					MFMailComposeViewController *picker = [[MFMailComposeViewController alloc] init];
					picker.mailComposeDelegate = self;
					
					[picker setSubject:@"puriSCOPE Activation"];
					
					
					
					NSArray *toRecipients = [NSArray arrayWithObject:@"activation@thonhauser.net"]; 
					
					
					[picker setToRecipients:toRecipients];
					
					
					// Attach an image to the email
					//NSString *path = [[NSBundle mainBundle] pathForResource:@"PUREiSCOPE" ofType:@"csv"];
					NSData *myData = [NSData dataWithContentsOfFile:thePath3];
					[picker addAttachmentData:myData mimeType:@"csv" fileName:@"act_puriSCOPE.csv"];
					
					// Fill out the email body text
					NSString *emailBody = @"<h1>Please do not change any part of this Email.</h1> <br> <h1><b>Data from your iPod for activation is attached.</b></h1>";
					[picker setMessageBody:emailBody isHTML:YES];
                    [self presentViewController:picker animated:NO completion:nil];
					[picker release];
					
				}
				else
				{
					//[self launchMailAppOnDevice];
				}
			}
			else
			{
				//[self launchMailAppOnDevice];
			}	
			
	}
			
			
}

- (IBAction)done {
	
	if(OPorIN == TRUE)
	{
	[[NSUserDefaults standardUserDefaults] setObject:res0lab.text forKey:@"vgoodlab"];
	[[NSUserDefaults standardUserDefaults] setObject:res2lab.text forKey:@"satislab"];
	[[NSUserDefaults standardUserDefaults] setObject:res4lab.text forKey:@"inadeqlab"];
	[[NSUserDefaults standardUserDefaults] setInteger:swugormg.selectedSegmentIndex forKey:@"ugormg"];
	[[NSUserDefaults standardUserDefaults] setBool:swsavereport.on forKey:@"savereport"];
	//[[NSUserDefaults standardUserDefaults] setInteger:DIA forKey:@"DIAMETER"];
	//	vgoodlab = res0lab.text;
	//	satislab = res2lab.text;
	//	inadeqlab = res4lab.text;
	
		
		
	}
	
	
	[self.delegate OptionsViewControllerDidFinish:self];	
	
	
}


/*
 // Override to allow orientations other than the default portrait orientation.
 - (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
 // Return YES for supported orientations
 return (interfaceOrientation == UIInterfaceOrientationPortrait);
 }
 */

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
	
	
	/*[[NSUserDefaults standardUserDefaults] setObject:res0lab.text forKey:@"vgoodlab"];
	[[NSUserDefaults standardUserDefaults] setObject:res2lab.text forKey:@"satislab"];
	[[NSUserDefaults standardUserDefaults] setObject:res4lab.text forKey:@"inadeqlab"];
*/
}


- (void)dealloc {
    [super dealloc];
}


@end
