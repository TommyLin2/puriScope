//
//  PickersViewController.m
//  Pickers
//
#include <math.h>
#import "puriSCOPEViewController.h"
#import "CustomCameraViewController.h"

int firstrun;
NSString *thePath;
@implementation puriSCOPEViewController;
CGPoint first,second;
float alpha;
double Diam;
NSString *_diam;
BOOL picorimg,optorpic;
@synthesize lbldiam,lblugormg,Options,btninfo,resultfox,sample,blank,getImage,getPhoto,newfoxy,adress,namelabel,reportview,result3,timeLabel,libsegcam,taglabel,personLabel,save,lblreport,btnoptions,vwslidemenu,reslabel;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
    }
    return self;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskLandscapeRight;
}

-(BOOL)shouldAutorotate
{
    return YES;
}

- (BOOL)licheck
{
	
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	NSString *lkeyI = [defaults stringForKey:@"lkey"];
	
//	NSString *aresult = [[[UIDevice currentDevice] uniqueIdentifier] stringByReplacingOccurrencesOfString:@"a" withString:@""];
    NSString *aresult = [[[NSUUID UUID] UUIDString] stringByReplacingOccurrencesOfString:@"a" withString:@""];
	NSString *bresult = [aresult stringByReplacingOccurrencesOfString:@"b" withString:@""];
	NSString *cresult = [bresult stringByReplacingOccurrencesOfString:@"c" withString:@""];
	NSString *dresult = [cresult stringByReplacingOccurrencesOfString:@"d" withString:@""];
	NSString *eresult = [dresult stringByReplacingOccurrencesOfString:@"e" withString:@""];
	NSString *fresult = [eresult stringByReplacingOccurrencesOfString:@"f" withString:@""];
	
	int l = [fresult length];
	
	NSString *nr1 = [fresult substringFromIndex:l-2];
	NSString *nr2 = [[fresult substringFromIndex:l-4] substringToIndex:2];
	NSString *nr3 = [[fresult substringFromIndex:l-6] substringToIndex:2];
	NSString *nr4 = [[fresult substringFromIndex:l-8] substringToIndex:2];
	NSString *nr5 = [[fresult substringFromIndex:l-10] substringToIndex:2];
	NSString *nr6 = [[fresult substringFromIndex:l-12] substringToIndex:2];
	NSString *nr7 = [[fresult substringFromIndex:l-14] substringToIndex:2];
	NSString *nr8 = [[fresult substringFromIndex:l-16] substringToIndex:2];
	NSString *nr9 = [[fresult substringFromIndex:l-18] substringToIndex:2];
	NSString *nr10 = [fresult substringToIndex:l-(l-2)];
	
	NSArray *nrs = [[NSArray alloc] initWithObjects:nr1,nr2,nr3,nr4,nr5,nr6,nr7,nr8,nr9,nr10,nil];
	int i;
	NSMutableArray *LK= [[NSMutableArray alloc] init];
	
	for(i=0;i<10;i++)
	{
		
		float nrn = [[nrs objectAtIndex:i] floatValue]/99.0*25.0;
		
		if(nrn<=0)
		{	
			[LK addObject:@"A"];
		}else
		{
			if(nrn<=1)
			{
				[LK addObject:@"B"];
			}else
			{
				if(nrn<=2)
				{	
					[LK addObject:@"C"];
				}else
				{
					if(nrn<=3)
					{
						[LK addObject:@"D"];
					}else
					{
						if(nrn<=4)
						{	
							[LK addObject:@"E"];
						}else
						{
							if(nrn<=5)
							{
								[LK addObject:@"F"];
							}else
							{
								if(nrn<=6)
								{	
									[LK addObject:@"G"];
								}else
								{
									if(nrn<=7)
									{
										[LK addObject:@"H"];
									}else
									{
										if(nrn<=8)
										{	
											[LK addObject:@"I"];
										}else
										{
											if(nrn<=9)
											{
												[LK addObject:@"J"];
											}else
											{
												if(nrn<=10)
												{	
													[LK addObject:@"K"];
												}else
												{
													if(nrn<=11)
													{
														[LK addObject:@"L"];
													}else
													{
														if(nrn<=12)
														{	
															[LK addObject:@"M"];
														}else
														{
															if(nrn<=13)
															{
																[LK addObject:@"N"];
															}else
															{
																if(nrn<=14)
																{	
																	[LK addObject:@"O"];
																}else
																{
																	if(nrn<=15)
																	{
																		[LK addObject:@"P"];
																	}else
																	{
																		if(nrn<=16)
																		{	
																			[LK addObject:@"Q"];
																		}else
																		{
																			if(nrn<=17)
																			{
																				[LK addObject:@"R"];
																			}else
																			{
																				if(nrn<=18)
																				{	
																					[LK addObject:@"S"];
																				}else
																				{
																					if(nrn<=19)
																					{
																						[LK addObject:@"T"];
																					}else
																					{
																						if(nrn<=20)
																						{	
																							[LK addObject:@"U"];
																						}else
																						{
																							if(nrn<=21)
																							{
																								[LK addObject:@"V"];
																							}else
																							{
																								if(nrn<=22)
																								{	
																									[LK addObject:@"W"];
																								}else
																								{
																									if(nrn<=23)
																									{
																										[LK addObject:@"X"];
																									}else
																									{
																										if(nrn<=24)
																										{	
																											[LK addObject:@"Y"];
																										}else
																										{
																											if(nrn<=25)
																											{
																												[LK addObject:@"Z"];
																											}
																										}
																									}
																								}
																							}
																						}
																					}
																				}
																			}
																		}
																	}
																}
															}
														}
													}
												}
											}
										}
									}
								}
							}
						}
					}
				}
			}
		}
		
		
		
	}
	
	if([LK count]>=10)
	{
		
		if([lkeyI isEqualToString:[NSString stringWithFormat:@"%@%@%@%@-%@%@%@-%@%@%@",[LK objectAtIndex:0],[LK objectAtIndex:1],[LK objectAtIndex:2],[LK objectAtIndex:3],[LK objectAtIndex:4],[LK objectAtIndex:5],[LK objectAtIndex:6],[LK objectAtIndex:7],[LK objectAtIndex:8],[LK objectAtIndex:9]]])
		{
			return TRUE;
		}else
		{
			return FALSE;
		}
	}else
	{
		return FALSE;
	}
	
	
}


- (void)viewDidLoad
{
	li=([self licheck]);
	DIA = [[NSUserDefaults standardUserDefaults] integerForKey:@"DIAMETER"];
	optorpic=FALSE;
		
	if( [[NSUserDefaults standardUserDefaults] integerForKey:@"ugormg"]==0)
	{
		ugormg=FALSE;
		lblugormg.text = @"ug/cm2 Organic";
	}else
	{
		ugormg=TRUE;
		lblugormg.text = @"mg/l Organic";
	}
	save.enabled = FALSE;
	//libsegcam.segmentedControlStyle = UISegmentedControlStylePlain;
	//libsegcam.tintColor = [UIColor colorWithRed:0.90 green:0.90 blue:0.90 alpha:1.0];
	
	vgood = [[NSUserDefaults standardUserDefaults] floatForKey:@"vgood"];
    //res0val.value = vgood;
	//res0vallab.text=[NSString stringWithFormat:@"%.2f",vgood];
	
    
	satis = [[NSUserDefaults standardUserDefaults] floatForKey:@"satis"];
	//res2val.value = satis;
	//res2vallab.text=[NSString stringWithFormat:@"%.2f",satis];
	
	
	vgoodlab = [[NSUserDefaults standardUserDefaults] stringForKey:@"vgoodlab"];
	//res0lab.text = [[NSUserDefaults standardUserDefaults] stringForKey:@"vgoodlab"];
	
	satislab = [[NSUserDefaults standardUserDefaults] stringForKey:@"satislab"];
	//res2lab.text = [[NSUserDefaults standardUserDefaults] stringForKey:@"satislab"];
	
	inadeqlab = [[NSUserDefaults standardUserDefaults] stringForKey:@"inadeqlab"];
	//res4lab.text = [[NSUserDefaults standardUserDefaults] stringForKey:@"inadeqlab"];
	
	
	R = [[NSUserDefaults standardUserDefaults] floatForKey:@"BlankR"];
	Rvalue.text = [NSString stringWithFormat:@"%.2f",R];
	
	G= [[NSUserDefaults standardUserDefaults] floatForKey:@"BlankG"];
	Gvalue.text=[NSString stringWithFormat:@"%.2f",G];
	
	B = [[NSUserDefaults standardUserDefaults] floatForKey:@"BlankB"];
	Bvalue.text=[NSString stringWithFormat:@"%.2f",B];
	
	Rlabel.text=@"R:";
	Glabel.text=@"G:";
	Blabel.text=@"B:";
	
	
	
    [super viewDidLoad];
	[[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleBlackOpaque animated:NO];
	personLabel.text = @"";
	taglabel.text= @"";
	reslabel.text=@"";
	firstrun=0;
	
	
	
	NSString *rootPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES) objectAtIndex:0];
	thePath = [rootPath stringByAppendingPathComponent:@"Data.xml"];
	
	
	NSMutableArray *bData = [[NSMutableArray alloc] initWithContentsOfFile:thePath];
	//NSLog(@"bd:%@",bData);
	

	int len;
	
	len = [bData count];
	
	if(len<=1)
	{	
		//Ausgabe mit RGB
		NSArray *plistentries = [[NSArray alloc] initWithObjects:@"Date",@"Customer",@"Tag",@"Diameter",@"Result",@"UgorMg",@"BlankR",@"BlankG",@"BlankB",@"SampleR",@"SampleG",@"SampleB",nil];
		/*
		//Ausgabe ohne RGB
		NSArray *plistentries = [[NSArray alloc] initWithObjects:@"Date",@"Customer",@"Tag",@"Diameter",@"Result",@"UgorMg",nil];
		*/
		 NSMutableArray *dData= [[NSMutableArray alloc] init];
		[dData addObject:plistentries];
		[dData writeToFile:thePath atomically:YES];
		//NSLog(@"%@",dData);
		[dData release];
		[plistentries release];
		
	}
	
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:2];
	float l=120.0;
	float ix=520.0,iy=150.0;
	float ag,ar,ain,ao,pi=M_PI,e=M_E;
	
	ag = (pi/3.5)*1;
	ar=2*ag;
	ao=3*ag;
	ain=4*ag;
	
	alpha=((1.5*pi)-ag);
	
	CGPoint pos1 = getImage.center;
	CGPoint pos2 = getPhoto.center;
	CGPoint pos3 = save.center;
	CGPoint pos4 = btnoptions.center;
	CGPoint pos5 = btninfo.center;
	CGPoint slpos1 = vwslidemenu.center;
	
	pos1.x=ix+(sin(alpha)*l);
	pos1.y=iy+(cos(alpha)*l);
	
	pos2.x=ix+(sin(alpha+ag)*l);
	pos2.y=iy+(cos(alpha+ag)*l);
	
	pos3.x=ix+(sin(alpha+ar)*l);
	pos3.y=iy+(cos(alpha+ar)*l);
	
	pos4.x=ix+(sin(alpha+ao)*l);
	pos4.y=iy+(cos(alpha+ao)*l);
	
	pos5.x=ix+(sin(alpha+ain)*l);
	pos5.y=iy+(cos(alpha+ain)*l);
	
	slpos1.y=(alpha*75)-71;

	int xlargeI;
	xlargeI=(150*pow(e,(-5*(alpha-(1.5*pi))*(alpha-(1.5*pi)))));
	CGRect gI = getImage.bounds;
	gI.size.width=35+xlargeI;
	gI.size.height=35+xlargeI;
	getImage.bounds = gI;
	
	int xlargeP;
	xlargeP=(150*pow(e,(-5*(alpha-((1.5*pi)-ag))*(alpha-((1.5*pi)-ag)))));
	CGRect gP = getPhoto.bounds;
	gP.size.width=35+xlargeP;
	gP.size.height=35+xlargeP;
	getPhoto.bounds = gP;
	
	int xlargeS;
	xlargeS=(150*pow(e,(-5*(alpha-((1.5*pi)-ar))*(alpha-((1.5*pi)-ar)))));
	CGRect gS = save.bounds;
	gS.size.width=35+xlargeS;
	gS.size.height=35+xlargeS;
	save.bounds = gS;
	
	int xlargeO;
	xlargeO=(150*pow(e,(-5*(alpha-((1.5*pi)-ao))*(alpha-((1.5*pi)-ao)))));
	CGRect gO = btnoptions.bounds;
	gO.size.width=35+xlargeO;
	gO.size.height=35+xlargeO;
	btnoptions.bounds = gO;
	
	int xlargeIn;
	xlargeIn=(150*pow(e,(-5*(alpha-((1.5*pi)-ain))*(alpha-((1.5*pi)-ain)))));
	CGRect gIn = btninfo.bounds;
	gIn.size.width=35+xlargeIn;
	gIn.size.height=35+xlargeIn;
	btninfo.bounds = gIn;
	
	getPhoto.center=pos2;
	getImage.center=pos1;
	
	if(li)
	{
		save.center=pos3;
		btnoptions.center=pos4;
		btninfo.center=pos5;
	}else
	{
		save.hidden=TRUE;
		btnoptions.hidden=TRUE;
		btninfo.center=pos3;
	}
	
	
	
	vwslidemenu.center=slpos1;
	
	[UIView commitAnimations];
	
	//[bData release];		
//	[dData release];

}




- (void)dealloc {
   
  // [bData release];
    [super dealloc];
}

//#pragma mark -
//#pragma mark Image Picker

- (IBAction)showimagepicker2:(id)sender;
{	picorimg=FALSE;
	optorpic=FALSE;
	if(firstrun==0|li==FALSE)
	{
	
	imagePickerController = [[UIImagePickerController alloc] init];		
	imagePickerController.delegate = self;
	imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:imagePickerController animated:NO completion:nil];
    //[imagePickerController release];
	}
	else
	{
		UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"Do You want to save the Result??"delegate:self cancelButtonTitle:@"NO" destructiveButtonTitle:nil otherButtonTitles:@"YES",nil];
		actionSheet.actionSheetStyle = UIActionSheetStyleDefault;
		[actionSheet showInView:self.view]; // show from our table view (pops up in the middle of the table)
		[actionSheet release];

	}
	
}


- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
	if(buttonIndex==0)
	{	
		TypeSomethingViewController *typeSomethingViewController = [[TypeSomethingViewController alloc] init];
		typeSomethingViewController.delegate = self;
        [self presentViewController:typeSomethingViewController animated:NO completion:nil];
		[typeSomethingViewController release];
	}
	else
	{
		if(optorpic)
		{OPorIN = TRUE;
			reportview.hidden=TRUE;
			lblreport.hidden=TRUE;
			blank.backgroundColor = [UIColor colorWithRed:0.92 green:0.92 blue:0.92 alpha:1];
			sample.backgroundColor = [UIColor colorWithRed:0.92 green:0.92 blue:0.92 alpha:1];
			result3.text=@"0.00";
			taglabel.text=@"";
			personLabel.text=@"";
			namelabel.text=@"";
			adress.text=@"";
			resultfox.image=nil;
			reslabel.text=@"";
			firstrun=0;
			
			OptionsViewController *controller = [[OptionsViewController alloc] initWithNibName:@"OptionsView" bundle:nil];
			controller.delegate = self;
			
			controller.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
            [self presentViewController:controller animated:NO completion:nil];
			[controller release];
			if( ugormg==TRUE)
			{
				lblugormg.text = @" mg/L Organic";
			}else
			{
				lblugormg.text = @"ug/cm2 Organic";
			}
			
		}
		
		imagePickerController = [[UIImagePickerController alloc] init];
		imagePickerController.delegate = self;
		if(picorimg)
		{
			if  ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
			{
                imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
                [self launchCustomCameraViewController];
			}
			else
			{
				imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                [self presentViewController:imagePickerController animated:NO completion:nil];
			}
			
		}else
		{
			imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            [self presentViewController:imagePickerController animated:NO completion:nil];
		}
		
	}
}

- (IBAction)showImagePicker:(id)sender
{
    
    picorimg=TRUE;
	optorpic=FALSE;
	if(firstrun==0 |li==FALSE)
	{
        imagePickerController = [[UIImagePickerController alloc] init];
        imagePickerController.delegate = self;
		if  ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
		{
            imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
            [self launchCustomCameraViewController];
		}
		else
		{
			imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            [self presentViewController:imagePickerController animated:YES completion:nil];
		}
	}
	else
	{
		UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"Do You want to save the Result??"delegate:self cancelButtonTitle:@"NO" destructiveButtonTitle:nil otherButtonTitles:@"YES",nil];
		actionSheet.actionSheetStyle = UIActionSheetStyleDefault;
		[actionSheet showInView:self.view]; // show from our table view (pops up in the middle of the table)
		[actionSheet release];
	}
}

- (void)launchCustomCameraViewController{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"customcamera" bundle:[NSBundle mainBundle]];
    CustomCameraViewController *controller = [storyboard instantiateViewControllerWithIdentifier:@"CustomCameraViewController"];
    controller.delegate = self;
    controller.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentViewController:controller animated:NO completion:nil];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
	UITouch *touch = [touches anyObject];
	first = [touch locationInView:self.view];

	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:2];

	vwslidemenu.hidden=FALSE;
	[UIView commitAnimations];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    float l=120.0;
	float ix=520.0,iy=150.0;
	float ag,ar,ain,ao,pi=M_PI,e=M_E;
	
	UITouch *touch2 = [touches anyObject];
	second = [touch2 locationInView:self.view];
	
	ag = (pi/3.5)*1;
	ar=2*ag;
	ao=3*ag;
	ain=4*ag;
	
	alpha=alpha+(pi/180*((second.y-first.y)/35));
	if(alpha >= (1.5*pi))
	{
		alpha=(1.5*pi);
	}
	if(alpha <= ((1.5*pi)-ain))
	{
		alpha=((1.5*pi)-ain);
	}
		
	CGPoint pos1 = getImage.center;
	CGPoint pos2 = getPhoto.center;
	CGPoint pos3 = save.center;
	CGPoint pos4 = btnoptions.center;
	CGPoint pos5 = btninfo.center;
	CGPoint slpos1 = vwslidemenu.center;
	
	pos1.x=ix+(sin(alpha)*l);
	pos1.y=iy+(cos(alpha)*l);
	
	pos2.x=ix+(sin(alpha+ag)*l);
	pos2.y=iy+(cos(alpha+ag)*l);
	
	pos3.x=ix+(sin(alpha+ar)*l);
	pos3.y=iy+(cos(alpha+ar)*l);
	
	pos4.x=ix+(sin(alpha+ao)*l);
	pos4.y=iy+(cos(alpha+ao)*l);

	pos5.x=ix+(sin(alpha+ain)*l);
	pos5.y=iy+(cos(alpha+ain)*l);

	slpos1.y=(alpha*75)-71;
	
	int xlargeI;
	xlargeI=(150*pow(e,(-5*(alpha-(1.5*pi))*(alpha-(1.5*pi)))));
	CGRect gI = getImage.bounds;
	gI.size.width=35+xlargeI;
	gI.size.height=35+xlargeI;
	getImage.bounds = gI;
	
	int xlargeP;
	xlargeP=(150*pow(e,(-5*(alpha-((1.5*pi)-ag))*(alpha-((1.5*pi)-ag)))));
	CGRect gP = getPhoto.bounds;
	gP.size.width=35+xlargeP;
	gP.size.height=35+xlargeP;
	getPhoto.bounds = gP;
	
	int xlargeS;
	xlargeS=(150*pow(e,(-5*(alpha-((1.5*pi)-ar))*(alpha-((1.5*pi)-ar)))));
	CGRect gS = save.bounds;
	gS.size.width=35+xlargeS;
	gS.size.height=35+xlargeS;
	save.bounds = gS;
	
	int xlargeO;
	xlargeO=(150*pow(e,(-5*(alpha-((1.5*pi)-ao))*(alpha-((1.5*pi)-ao)))));
	CGRect gO = btnoptions.bounds;
	gO.size.width=35+xlargeO;
	gO.size.height=35+xlargeO;
	btnoptions.bounds = gO;
	
	int xlargeIn;
	if(li)
	{
		xlargeIn=(150*pow(e,(-5*(alpha-((1.5*pi)-ain))*(alpha-((1.5*pi)-ain)))));
	}else{
		xlargeIn=xlargeS;
	}
	CGRect gIn = btninfo.bounds;
	gIn.size.width=35+xlargeIn;
	gIn.size.height=35+xlargeIn;
	btninfo.bounds = gIn;
	
	getImage.center=pos1;
	getPhoto.center=pos2;
	
	if(li)
	{
		save.center=pos3;
		btnoptions.center=pos4;
		btninfo.center=pos5;
	}else
	{
		save.hidden=TRUE;
		btnoptions.hidden=TRUE;
		btninfo.center=pos3;
	}
	
	vwslidemenu.center=slpos1;
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
	vwslidemenu.hidden=TRUE;
}

-(void)alertDone {
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"REPORT" message:@"... saved to your camera roll" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
	
	//alert.actionSheetStyle = UIActionSheetStyleDefault;
	[alert show];	// show from our table view (pops up in the middle of the table)
	[alert release];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
	//peoplepicker.hidden=FALSE;
	namelabel.hidden=FALSE;
	newfoxy.hidden=TRUE;
	reportview.hidden=TRUE;
	lblreport.hidden=TRUE;
	//labeler.hidden=FALSE;
	taglabel.hidden=FALSE;
	blank.backgroundColor = [UIColor colorWithRed:0.92 green:0.92 blue:0.92 alpha:1];
	sample.backgroundColor = [UIColor colorWithRed:0.92 green:0.92 blue:0.92 alpha:1];
	result3.text=@"0.00";
	taglabel.text=@"";
	personLabel.text=@"";
	namelabel.text=@"";
	adress.text=@"";
	resultfox.image=nil;
	Options.hidden=TRUE;
	//tooptions.hidden=FALSE;
	reslabel.text=@"";
	firstrun=0;
	aadress=@"";
	pperson=@"";
	nname=@"";
}


- (void)typeSomethingViewController:(TypeSomethingViewController *)controller didTypeSomething:(NSString *)text
{
    taglabel.text = [NSString stringWithFormat:@"             %@",text];
    adress.text=aadress;
	personLabel.text=pperson;
	namelabel.text=pperson;
	vwslidemenu.hidden=TRUE;
    [self dismissViewControllerAnimated:YES completion:nil];
	if([[NSUserDefaults standardUserDefaults] boolForKey:@"savereport"]==TRUE)
	{
	
		getImage.hidden=TRUE;;
		getPhoto.hidden=TRUE;
		save.hidden=TRUE;
		btnoptions.hidden=TRUE;
		btninfo.hidden=TRUE;
		
		reportview.hidden=FALSE;
		lblreport.hidden=FALSE;

		float width=480;
		float height=300;
		CGSize size= {width,height};
		UIGraphicsBeginImageContext(size);
		[self.view.layer renderInContext:UIGraphicsGetCurrentContext()];
		UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();
		UIGraphicsEndImageContext();
		UIImageWriteToSavedPhotosAlbum(viewImage, self, nil, nil); 
		[self alertDone];
		
		getImage.hidden=FALSE;
		getPhoto.hidden=FALSE;
		save.hidden=FALSE;
		btnoptions.hidden=FALSE;
		btninfo.hidden=FALSE;
		
	}else
	{
		//peoplepicker.hidden=FALSE;
		namelabel.hidden=FALSE;
		newfoxy.hidden=TRUE;
		reportview.hidden=TRUE;
		//labeler.hidden=FALSE;
		taglabel.hidden=FALSE;
		blank.backgroundColor = [UIColor colorWithRed:0.92 green:0.92 blue:0.92 alpha:1];
		sample.backgroundColor = [UIColor colorWithRed:0.92 green:0.92 blue:0.92 alpha:1];
		//result3.text=@"0.00";
		taglabel.text=@"";
		personLabel.text=@"";
		namelabel.text=@"";
		adress.text=@"";
		resultfox.image=nil;
		Options.hidden=TRUE;
		//tooptions.hidden=FALSE;
		reslabel.text=@"";
		firstrun=0;
		aadress=@"";
		pperson=@"";
		nname=@"";
	}

	NSString *ddate = [timeLabel.text stringByReplacingOccurrencesOfString:@"\n" withString:@" "];
	NSString *dcustomer = [pperson stringByReplacingOccurrencesOfString:@"\n" withString:@" "];
	NSString *dtag = [text stringByReplacingOccurrencesOfString:@"\n" withString:@" "];
	NSString *ddiam=_diam;
	NSString *dresult = [result3.text stringByReplacingOccurrencesOfString:@"\n" withString:@" "];

	NSString *dugormg;
	
	if( ugormg==TRUE)
	{dugormg=@"mg/l";
	}else
	{
	 dugormg=@"ug/cm2";	
	}
	
	if([ddate length]==0)
		
	{ddate = @"-";
	}else
    {
        ddate = [NSString stringWithFormat:@"\"%@\"",ddate];
    }
	if([dcustomer length]==0)
	{dcustomer = @"-";
	}else
    {
    dcustomer = [NSString stringWithFormat:@"\"%@\"",dcustomer];
    }	
	if([dtag length]==0)
	{dtag = @"-";
	}else
    {
        dtag = [NSString stringWithFormat:@"\"%@\"",dtag];
    }
	if([ddiam length]==0)
	{ddiam = @"-";
	}else
    {
        ddiam = [NSString stringWithFormat:@"\"%@\"",ddiam];
    }
	if([dresult length]==0)
	{dresult = @"-";
	}else
    {
        dresult = [NSString stringWithFormat:@"\"%@\"",dresult];
    }
	if([dugormg length]==0)
	{dugormg = @"-";
	}else
    {
        dugormg = [NSString stringWithFormat:@"\"%@\"",dugormg];
    }
	
	NSString *rootPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES) objectAtIndex:0];
	thePath = [rootPath stringByAppendingPathComponent:@"Data.xml"];
	
	 //Ausgabe + RGB
	NSArray *plistentries = [[NSArray alloc] initWithObjects:ddate,dcustomer,dtag,ddiam,dresult,dugormg,[NSString stringWithFormat:@"%2.f",blankR],[NSString stringWithFormat:@"%2.f",blankG],[NSString stringWithFormat:@"%2.f",blankB],[NSString stringWithFormat:@"%2.f",sampleR],[NSString stringWithFormat:@"%2.f",sampleG],[NSString stringWithFormat:@"%2.f",sampleB],nil];
	/*
	// ohne RGB
	NSArray *plistentries = [[NSArray alloc] initWithObjects:ddate,dcustomer,dtag,ddiam,dresult,dugormg,nil];
	*/
	NSMutableArray *dData=[[NSMutableArray alloc] initWithContentsOfFile:thePath];
	[dData addObject:plistentries];
	[dData writeToFile:thePath atomically:YES];
	//NSLog(@"%@",dData);
	[dData release];
	[plistentries release];

    save.enabled= FALSE;
	//[self alertDone];
	
	/*
	Event *event = (Event *)[NSEntityDescription insertNewObjectForEntityForName:@"Event" inManagedObjectContext:managedObjectContext];
	
	CLLocationCoordinate2D coordinate = [location coordinate];
	[event setLatitude:[NSNumber numberWithDouble:coordinate.latitude]];
	[event setLongitude:[NSNumber numberWithDouble:coordinate.longitude]];
	[event setCreationDate:[NSDate date]];
	*/
	//if([[NSUserDefaults standardUserDefaults] boolForKey:@"savereport"]==FALSE)
	if([[NSUserDefaults standardUserDefaults] boolForKey:@"savereport"]==TRUE)
	{
        result3.text=@"0.00";
	}
}

- (IBAction)save:(id)sender;
{
	firstrun=0;
	TypeSomethingViewController *typeSomethingViewController = [[TypeSomethingViewController alloc] init];
	typeSomethingViewController.delegate = self;
    [self presentViewController:typeSomethingViewController animated:YES completion:nil];
	[typeSomethingViewController release];
}

- (IBAction)showInfo {  
	OPorIN = FALSE;
	OptionsViewController *controller = [[OptionsViewController alloc] initWithNibName:@"OptionsView" bundle:nil];
	controller.delegate = self;
	
	controller.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentViewController:controller animated:YES completion:nil];
	[controller release];
}

- (IBAction)options:(id)sender{
	optorpic=TRUE;
	if(firstrun==1)
	{
		UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"Do You want to save the Result??"delegate:self cancelButtonTitle:@"NO" destructiveButtonTitle:nil otherButtonTitles:@"YES",nil];
		actionSheet.actionSheetStyle = UIActionSheetStyleDefault;
		[actionSheet showInView:self.view]; // show from our table view (pops up in the middle of the table)
		[actionSheet release];
	}else
	{
        OPorIN = TRUE;
        OptionsViewController *controller = [[OptionsViewController alloc] initWithNibName:@"OptionsView" bundle:nil];
        controller.delegate = self;
	
        controller.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
        [self presentViewController:controller animated:YES completion:nil];
	
        [controller release];
        if( ugormg==0)
        {
            lblugormg.text = @"ug/cm2 Organic";
        }else
        {
            lblugormg.text = @"mg/L Organic";
        }
    }
}

- (CGContextRef) createARGBBitmapContextFromImage:(CGImageRef) inImage {
	
	CGContextRef    context = NULL;
	CGColorSpaceRef colorSpace;
	void *          bitmapData;
	int             bitmapByteCount;
	int             bitmapBytesPerRow;
	
	// Get image width, height. We'll use the entire image.
	size_t pixelsWide = CGImageGetWidth(inImage);
	size_t pixelsHigh = CGImageGetHeight(inImage);
	
	// Declare the number of bytes per row. Each pixel in the bitmap in this
	// example is represented by 4 bytes; 8 bits each of red, green, blue, and
	// alpha.
	bitmapBytesPerRow   = (pixelsWide * 4);
	bitmapByteCount     = (bitmapBytesPerRow * pixelsHigh);
	
	// Use the generic RGB color space.
	colorSpace = CGColorSpaceCreateDeviceRGB();
	if (colorSpace == NULL)
	{
		fprintf(stderr, "Error allocating color space\n");
		return NULL;
	}
	
	// Allocate memory for image data. This is the destination in memory
	// where any drawing to the bitmap context will be rendered.
	bitmapData = malloc( bitmapByteCount );
	if (bitmapData == NULL)
	{
		fprintf (stderr, "Memory not allocated!");
		CGColorSpaceRelease( colorSpace );
		return NULL;
	}
	
	// Create the bitmap context. We want pre-multiplied ARGB, 8-bits
	// per component. Regardless of what the source image format is
	// (CMYK, Grayscale, and so on) it will be converted over to the format
	// specified here by CGBitmapContextCreate.
	context = CGBitmapContextCreate (bitmapData,
									 pixelsWide,
									 pixelsHigh,
									 8,      // bits per component
									 bitmapBytesPerRow,
									 colorSpace,
									 kCGImageAlphaPremultipliedFirst);
	if (context == NULL)
	{
		free (bitmapData);
		fprintf (stderr, "Context not created!");
	}
	
	// Make sure and release colorspace before returning
	CGColorSpaceRelease( colorSpace );
	return context;
}

- (void)OptionsViewControllerDidFinish:(OptionsViewController *)controller {
    [self dismissViewControllerAnimated:YES completion:nil];
	if( ugormg==FALSE)
	{
        lblugormg.text = @"ug/cm2 Organic";
	}else
	{
		lblugormg.text = @"mg/L Organic";
        lbldiam.text=@"";
	}
	save.enabled=FALSE;
	vgoodlab = [[NSUserDefaults standardUserDefaults] stringForKey:@"vgoodlab"];
	satislab = [[NSUserDefaults standardUserDefaults] stringForKey:@"satislab"];
	inadeqlab = [[NSUserDefaults standardUserDefaults] stringForKey:@"inadeqlab"];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo
{
    firstrun=1;
	//imageView.image = image;
	//UIColor* color=nil;
    [self imageProcess:image];
}

- (void)customCameraImageCaptured:(CustomCameraViewController*)controller withCapturedImage:(UIImage *)image{
    [self dismissViewControllerAnimated:YES completion:nil];
//    [self imageProcess:image];
}

-(void)imageProcess:(UIImage *)image{
    CGImageRef ref = image.CGImage;
    CGContextRef bitmapcrop1 = [self createARGBBitmapContextFromImage:ref];
    //CGContextRef bitmapcrop1 = CreateARGBBitmapContext(ref);
    if (bitmapcrop1 == NULL)
    {
        //NSLog(@"Error Creating ContextRef");
        // error creating context
        return;
    }
    
    size_t w = CGImageGetWidth(ref);
    size_t h = CGImageGetHeight(ref);
    CGRect rect = {{0,0},{w,h}};
    CGContextDrawImage(bitmapcrop1, rect, ref);
    
   	//NSLog(@"w ,%i h, %i",w,h);
    
    unsigned char* data = CGBitmapContextGetData (bitmapcrop1);
    
    if (data != NULL)
    {
        
        //_________________________________________________________
        //BLANK Crop
        
        int xb=0,yb=0,rednewbx=0,greennewbx=0,bluenewbx=0,rednewby=0,greennewby=0,bluenewby=0,nb=0;
        //br = (width*width%/100)
        float br,bl,bt,bb;
        br=(w*20.0/100.0);
        bl=(w*35.0/100.0);
        bt=(h*75.0/100.0);//55
        bb=(h*90.0/100.0);//70
        
        
        for(yb=bt;yb<bb;yb++)
        {
            for(xb=br;xb<bl;xb++)
            {nb++;
                int offset = 4*((w*yb)+xb);
                //int alpha =  data[offset]; maybe we need it?
                int redb = data[offset+1];
                data[offset+1]=255;
                int greenb = data[offset+2];
                data[offset+2]=255;
                int blueb = data[offset+3];
                data[offset+3]=255;
                rednewbx=rednewbx+redb;
                greennewbx=greennewbx+greenb;
                bluenewbx=bluenewbx+blueb;
            }
            nb++;
            rednewby=rednewby+rednewbx;
            greennewby=greennewby+greennewbx;
            bluenewby=bluenewby+bluenewbx;
            rednewbx=0,greennewbx=0,bluenewbx=0;
        }
        
        //NSLog(@"Blank: Pixels:%i crop:%f:%f:%f:%f",nb,br,bt,bl,bb);
        
        
        //________________________________________________________
        
        //SAMPLE Crop
        
        int xs=0,ys=0,rednewsx=0,greennewsx=0,bluenewsx=0,rednewsy=0,greennewsy=0,bluenewsy=0,ns=0;
        //sr = (width*width%/100)
        float sr,sl,st,sb;
        sr=(w*70.0/100.0);
        sl=(w*85.0/100.0);
        st=(h*75.0/100.0);//55
        sb=(h*90.0/100.0);//70
        int alpha;
        
        for(ys=st;ys<sb;ys++)
        {
            for(xs=sr;xs<sl;xs++)
            {ns++;
                int offset = 4*((w*ys)+xs);
                alpha =  data[offset]; //maybe we need it?
                int reds = data[offset+1];
                data[offset+1]=255;
                int greens = data[offset+2];
                data[offset+1]=255;
                int blues = data[offset+3];
                data[offset+1]=255;
                rednewsx=rednewsx+reds;
                greennewsx=greennewsx+greens;
                bluenewsx=bluenewsx+blues;
            }
            
            ns++;
            rednewsy=rednewsy+rednewsx;
            greennewsy=greennewsy+greennewsx;
            bluenewsy=bluenewsy+bluenewsx;
            rednewsx=0,greennewsx=0,bluenewsx=0;
        }
        
        //NSLog(@"BLANK:%i:%i:%i:SAMPLE:%i:%i:%i",rednewby/nb, greennewby/nb,bluenewby/nb,rednewsy/ns, greennewsy/ns,bluenewsy/ns);
        //result.text = [NSString stringWithFormat:@"%ix%i",w,h];
        //result2.text = [NSString stringWithFormat:@"BLANK:%i:%i:%i  SAMPLE:%i:%i:%i",rednewby/nb, greennewby/nb,bluenewby/nb,rednewsy/ns, greennewsy/ns,bluenewsy/ns];
        
        
        float sred,sgreen,sblue,bred,bgreen,bblue,ssred,ssgreen,ssblue,bbblue,bbgreen,bbred;
        bred=rednewby/(nb*255.0f);
        bgreen=greennewby/(nb*255.0f);
        bblue=bluenewby/(nb*255.0f);
        sred=rednewsy/(ns*255.0f);
        sgreen=greennewsy/(ns*255.0f);
        sblue=bluenewsy/(ns*255.0f);
        blank.backgroundColor = [UIColor colorWithRed:bred green:bgreen blue:bblue alpha:1];
        sample.backgroundColor = [UIColor colorWithRed:sred green:sgreen blue:sblue alpha:1];
        
        ssred=rednewsy/ns;
        ssgreen=greennewsy/ns;
        ssblue=bluenewsy/ns;
        
        blankR=rednewby/nb;
        blankG=greennewby/nb;
        blankB=bluenewby/nb;
        
        sampleR=ssred;
        sampleG=ssgreen;
        sampleB=ssblue;
        
        bbred=rednewby/nb+R;//-4
        bbgreen=greennewby/nb+G;//-4
        bbblue=bluenewby/nb+B;//-7
        
        
        
        
        /*double LD,RB,RS,GB,GS,MN2S,V1M,S1M,IZERO550,IZERO625,IATT550B,IATT550S,IATT625B,IATT625S,ABS550B,ABS550S,ABS625B,ABS625S,MN7B,MN7S,MN6B,MN6S,RSF,MGL_ORG,UGCM2_ORG;
         
         float MN2Q=3.00;
         float RGIZero=160.00;
         
         float WR550=163.00;
         float WG550=296.00;
         float WR625=352.00;
         float WG625=98.00;
         
         float M550_7=0.212;
         float M625_7=0.169;
         float M550_6=0.1;
         float M625_6=0.222;
         
         float DIV=0.03;
         float MNREF=0.114;
         
         
         RS=ssred;
         RB=bbred;
         GS=ssgreen;
         GB=bbgreen;
         
         IZERO550=(RGIZero*WR550+RGIZero*WG550)/1000;
         IZERO625=(RGIZero*WR625+RGIZero*WG625)/1000;
         IATT550B=(RB*WR550+GB*WG550)/1000;
         IATT550S=(RS*WR550+GS*WG550)/1000;
         IATT625B=(RB*WR625+GB*WG625)/1000;
         IATT625S=(RS*WR625+GS*WG625)/1000;
         
         ABS550B=(-log10(IATT550B/IZERO550));
         ABS625B=(-log10(IATT625B/IZERO625));
         ABS550S=(-log10(IATT550S/IZERO550));
         ABS625S=(-log10(IATT625S/IZERO625));
         
         MN7B=((M550_7*ABS550B-M625_7*ABS625B)/DIV)*MNREF;
         MN7S=((M550_7*ABS550S-M625_7*ABS625S)/DIV)*MNREF;
         MN6B=((M550_6*ABS550B-M625_6*ABS625B)/DIV)*MNREF;
         MN6S=-(((M550_6*ABS550S-M625_6*ABS625S)/DIV)*MNREF);
         //NSLog(@"ABS:%.3f;%.3f;%.3f;%.3f",ABS550B,ABS625B,ABS550S,ABS625S);
         //NSLog(@"MN:%.3f;%.3f;%.3f;%.3f",MN7B,MN7S,MN6B,MN6S);
         
         MN2S=(MN7B+MN6B)-(MN7S+MN6S);
         //IF MN2S <0 THEN MN2S=0;
         if(MN2S<=0)
         {MN2S=0;
         }
         //NSLog(@"MN2S%.3f",MN2S);
         
         
         RSF=(MN6S+4*MN2Q*MN2S)-MN6B;
         
         MGL_ORG=RSF*7.5;
         
         V1M=((LD/20)*(LD/20))*3.1415/10;
         S1M=(LD/10)*3.1415*100;
         
         UGCM2_ORG=(MGL_ORG*V1M*1000)/S1M;*/
        
        
        
        
        double E535_S,E435_S,E405_S,Mn7_S,Mn6_S,Mn2_S,E535_CS,E435_CS,E405_CS,Mn7_CS,Mn6_CS,Mn2_CS,I,T,RSF,mgl_CH2O,ug_cm2,Mn7R,ERR,maxmgl,maxug,RSFGO;
        I=4.07;
        T=8.53;
        // Diamter Berechnung
        
        DIA = [[NSUserDefaults standardUserDefaults] integerForKey:@"DIAMETER"];
        
        switch (DIA) {
            case 1:Diam=0.2;
                break;
            case 2:Diam=0.35;
                break;
            case 3:Diam=0.5;
                break;
            case 4:Diam=0.6;
                break;
            case 5:Diam=2.5;
                break;
            case 6:Diam=0.3175;
                break;
            case 7:Diam=0.47625;
                break;
            case 8:Diam=0.635;
                break;
            case 9:Diam=0.95252;
                break;
            case 10:Diam=1.27;
                break;
            default:Diam=0.5;
                break;
        }
        
        switch (DIA) {
            case 1:_diam=@"4mm";
                break;
            case 2:_diam=@"7mm";
                break;
            case 3:_diam=@"10mm";
                break;
            case 4:_diam=@"12mm";
                break;
            case 5:_diam=@"50mm";
                break;
            case 6:_diam=@"1/4\"";
                break;
            case 7:_diam=@"3/8\"";
                break;
            case 8:_diam=@"1/2\"";
                break;
            case 9:_diam=@"3/4\"";
                break;
            case 10:_diam=@"1\"";
                break;
            default:_diam=@"10mm";
                break;
        }
        
        ssgreen = (ssgreen+120)/2;
        bbgreen = (bbgreen+120)/2;
        
        ssblue = (ssblue+140)/2;
        bbblue = (bbblue+140)/2;
        
        
        // Berechnungsstufe 1_S:
        
        E535_S = ((-log10(((ssred/(I-4.0)*((T-4.0)*100.0/16.0*(-0.3327)+107.64)/100.0))/3205.0))*112.0+(-log10(((ssgreen/(I-4.0)*((T-4.0)*100.0/16.0*(-0.3327)+107.64)/100.0))/3205.0))*411.0)/100.0;
        E435_S = ((-log10(((ssred/(I-4)*((T-4)*100.0/16.0*(-0.3327)+107.64)/100))/3205))*35+(-log10(((ssblue/(I-4)*((T-4)*100/16*(-0.3327)+107.64)/100))/3205))*306)/100;
        E405_S = ((-log10(((ssred/(I-4)*((T-4)*100/16*(-0.3327)+107.64)/100))/3205))*130+(-log10(((ssblue/(I-4)*((T-4)*100/16*(-0.3327)+107.64)/100))/3205))*200)/100;
        
        
        // Berechnungsstufe 2_S:
        
        Mn7_S = (-1670.2*E535_S-1969.1*E435_S+4201.7*E405_S)/(-26606.7);
        Mn6_S = (-555.1*E535_S-5931*E435_S+8130.7*E405_S)/(26606.7);
        Mn2_S = (E535_S-26.6*(-1670.2*E535_S-1969.1*E435_S+4201.7*E405_S)/(-26606.7)-20*(-555.1*E535_S-5931*E435_S+8130.7*E405_S)/(26606.7))/18.3;
        
        
        // Berechnungsstufe 1_CS:
        
        E535_CS = ((-log10(((bbred/(I-4)*((T-4)*100/16*(-0.3327)+107.64)/100))/3205))*112+(-log10(((bbgreen/(I-4)*((T-4)*100/16*(-0.3327)+107.64)/100))/3205))*411)/100;
        E435_CS = ((-log10(((bbred/(I-4)*((T-4)*100/16*(-0.3327)+107.64)/100))/3205))*35+(-log10(((bbblue/(I-4)*((T-4)*100/16*(-0.3327)+107.64)/100))/3205))*306)/100;
        E405_CS = ((-log10(((bbred/(I-4)*((T-4)*100/16*(-0.3327)+107.64)/100))/3205))*130+(-log10(((bbblue/(I-4)*((T-4)*100/16*(-0.3327)+107.64)/100))/3205))*200)/100;
        
        
        // Berechnungsstufe 2_CS:
        
        Mn7_CS = (-1670.2*E535_CS-1969.1*E435_CS+4201.7*E405_CS)/(-26606.7);
        Mn6_CS = (-555.1*E535_CS-5931*E435_CS+8130.7*E405_CS)/(26606.7);
        Mn2_CS = (E535_CS-26.6*(-1670.2*E535_CS-1969.1*E435_CS+4201.7*E405_CS)/(-26606.7)-20*(-555.1*E535_CS-5931*E435_CS+8130.7*E405_CS)/(26606.7))/18.3;
        
        
        // Berechnungsstufe 3:
        
        RSF = (Mn6_S - Mn6_CS) + ((Mn2_S - Mn2_CS)*4);
        Mn7R = (Mn7_CS - Mn7_S);
        ERR = abs((Mn7R-RSF)*100/Mn7R);
        
        // Berechnungsstufe 4:
        /*if (ERR < 20)
         {
         CEQU = (RSF + Mn7R) / 2;
         }
         else
         {
         if (ERR > 20 && ssgreen > ssblue)
         {
         CEQU = RSF;
         }
         else
         {
         CEQU = Mn7R;
         }
         }*/
        // Berechnungsstufe 5:
        if(RSF*7.5<0.38)
        {   RSFGO = (RSF*7.5);
        }else
        {
            RSFGO = (RSF*7.5)*1.5-0.13;
        }
        mgl_CH2O = RSFGO;
        ug_cm2 = (RSFGO*1000)/(2*1000/(Diam));
        
        maxmgl=0.2*7.5;
        maxug=(0.2*7.5*1000)/(2*1000/(Diam));
        /*
         NSLog([NSString stringWithFormat:@"RSF %.2f",RSF]);
         NSLog([NSString stringWithFormat:@"maxug %.2f",maxug]);
         NSLog([NSString stringWithFormat:@"maxmg %.2f",maxmgl]);
         NSLog([NSString stringWithFormat:@"ug %.2f",ug_cm2]);
         NSLog([NSString stringWithFormat:@"mg %.2f",mgl_CH2O]);
         NSLog([NSString stringWithFormat:@"dia %.2f",Diam]);
         NSLog([NSString stringWithFormat:@"dia %.2f",Diam]);
         */
        li = true;
        if(li)
        {
            if([[NSUserDefaults standardUserDefaults] integerForKey:@"ugormg"]==0)
            {
                if(RSF<=0.2)
                {
                    
                    result3.text =[ NSString stringWithFormat:@"%.2f",ug_cm2];
                }else
                {			
                    result3.text =[ NSString stringWithFormat:@"> %.2f",maxug];
                }
                reslabel.hidden = FALSE;
                resultfox.hidden = FALSE;
                lbldiam.text=[NSString stringWithFormat:@"%@", _diam];
                if(ug_cm2 < vgood)
                {			
                    
                    resultfox.image = [UIImage imageNamed:@"Smiley_pink.png"];
                    reslabel.text = vgoodlab;
                    
                }else
                {if(ug_cm2 < satis)
                {			
                    resultfox.image = [UIImage imageNamed:@"Smiley_green.png"];
                    reslabel.text = satislab;
                    
                }else
                {
                    resultfox.image = [UIImage imageNamed:@"Smiley_yellow.png"];
                    reslabel.text = inadeqlab;
                }
                }
                
                
            }else
            {
                if(RSF<=0.2)
                {
                    result3.text =[ NSString stringWithFormat:@"%.2f",mgl_CH2O];
                }else
                {
                    result3.text =[ NSString stringWithFormat:@"> %.2f",maxmgl];
                }
                reslabel.hidden=TRUE;
                resultfox.image=nil;
                lbldiam.text=@"";
            }
        }else
        {
            result3.text=@"---";
            if(ug_cm2 <= 0.01)
            {
                resultfox.image = [UIImage imageNamed:@"Smiley_pink.png"];
                
            }else
            {if(ug_cm2 < maxug)
            {
                resultfox.image = [UIImage imageNamed:@"Smiley_green.png"];
                
            }else
            {
                resultfox.image = [UIImage imageNamed:@"Smiley_yellow.png"];
            }
            }
            
            lblugormg.text = @"";
            //reslabel.hidden=TRUE;
        }
        
        // Datum
        static NSDateFormatter *dateFormatter = nil;
        NSDate *today = [NSDate date];
        
        if (dateFormatter == nil) {
            dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setTimeStyle:NSDateFormatterShortStyle];
            [dateFormatter setDateStyle:NSDateFormatterShortStyle];
        }
        
        
        timeLabel.text = [dateFormatter stringFromDate:today];
        
        
        save.enabled=TRUE;
        
        
        //int xb=0,yb=0,rednewbx=0,greennewbx=0,bluenewbx=0,rednewby=0,greennewby=0,bluenewby=0,nb=0;
        //double E535_S,E435_S,E405_S,Mn7_S,Mn6_S,Mn2_S,E535_CS,E435_CS,E405_CS,Mn7_CS,Mn6_CS,Mn2_CS,I,T,RSF,CEQU,mgl_CH2O,Mn7R,ERR;
        
    }
    
    
    if(picorimg)
    {
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
    }
    // Free image data memory for the context
    if (data)
    {
        free(data);
    }	
    
    
    [self dismissViewControllerAnimated:YES completion:nil];
    CGContextRelease(bitmapcrop1);
    //CGImageRelease(ref);
    //[picker release];

}


- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    
	//[[picker parentViewController]dismissModalViewControllerAnimated:YES];

    [self dismissViewControllerAnimated:YES completion:nil];
	
	//[picker release];
}




@end
