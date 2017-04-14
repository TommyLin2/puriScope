//
//  PickersViewController.h
//  Pickers
//

#import <UIKit/UIKit.h>
#import "OptionsViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "TypeSomethingViewController.h"
#import "CustomCameraViewController.h"

extern NSMutableArray *dDate;

@interface puriSCOPEViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate, OptionsViewControllerDelegate,TypeSomethingViewControllerDelegate, UITextFieldDelegate, UIActionSheetDelegate,CustomCameraViewControllerDelegate>
{
    //UIImageView *imageView;
	UISegmentedControl *libsegcam;
	UIImagePickerController *imagePickerController;
	UILabel *result3;
	UIView *sample;
	UIView *blank;
	UIButton *getImage;
	UILabel *personLabel;
	UILabel *timeLabel;
	UIButton *getPhoto;
	UIView *reportview;
	//UIButton *report;
	UIButton *newfoxy;
	UILabel *adress;
	UILabel *namelabel;
	//UIButton *peoplepicker;
	//UIButton *labeler;
	UILabel *taglabel;
	UIImageView *resultfox;
	UILabel *Rlabel;
	UILabel *Rvalue;
	UILabel *Glabel;
	UILabel *Gvalue;
	UILabel *Blabel;
	UILabel *Bvalue;	
	UIButton *kalib;
	UIView *Options;
	UILabel *reslabel;
	UIButton *save;
	UILabel *lblreport;
	UIButton *btnoptions;
	UIButton *btninfo;
    UIButton *btngel;
	UILabel *lblugormg;
	UIImageView *vwslidemenu;
	UILabel *lbldiam;
}   

@property(nonatomic, retain)IBOutlet UILabel *lbldiam;
@property(nonatomic, retain)IBOutlet UILabel *lblugormg;
@property(nonatomic, retain)IBOutlet UIView *Options;
@property(nonatomic, retain)IBOutlet UIButton *btninfo;
@property(nonatomic, retain)IBOutlet UIImageView *resultfox;
@property(nonatomic, retain)IBOutlet UIView *sample;
@property(nonatomic, retain)IBOutlet UIView *blank;
@property(nonatomic, retain)IBOutlet UIButton *getImage;
@property(nonatomic, retain)IBOutlet UIButton *getPhoto;
@property(nonatomic, retain)IBOutlet UIButton *newfoxy;
@property(nonatomic, retain)IBOutlet UILabel *adress;
@property(nonatomic, retain)IBOutlet UILabel *namelabel;
@property(nonatomic, retain)IBOutlet UIView *reportview;
@property(nonatomic, retain)IBOutlet UILabel *result3;
@property(nonatomic, retain)IBOutlet UILabel *timeLabel;
@property(nonatomic, retain)IBOutlet UISegmentedControl *libsegcam;
@property(nonatomic, retain)IBOutlet UILabel *taglabel;
@property(nonatomic, retain)IBOutlet UILabel *personLabel;
@property(nonatomic, retain)IBOutlet UIButton *save;
@property(nonatomic, retain)IBOutlet UILabel *lblreport;
@property(nonatomic, retain)IBOutlet UIButton *btnoptions;
@property(nonatomic, retain)IBOutlet UIButton *btngel;
@property(nonatomic, retain)IBOutlet UIImageView *vwslidemenu;
@property(nonatomic, retain)IBOutlet UILabel *reslabel;


//- (IBAction)libbut:(id)sender;
//- (IBAction)cambut:(id)sender;
- (IBAction)showImagePicker:(id)sender;
- (IBAction)showimagepicker2:(id)sender;
- (IBAction)save:(id)sender;
- (IBAction)options:(id)sender;
- (IBAction)showInfo;
- (BOOL)licheck;
//- (IBAction)showPeoplePicker:(id)sender;
//- (IBAction)makeReport:(id)sender;
//- (IBAction)newfoxyd:(id)sender;
//- (IBAction)labeler:(id)sender;
//- (IBAction)kalib:(id)sender;
//- (IBAction)options:(id)sender;
//- (IBAction)doneedit:(id)sender;
/*- (IBAction)res0val:(id)sender;
- (IBAction)res1val:(id)sender;
- (IBAction)res2val:(id)sender;
- (IBAction)res3val:(id)sender;

*/
@end
