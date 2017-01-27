//
//  CustomCameraViewController.h
//  puriSCOPE
//
//  Created by Jordi on 26/01/17.
//
//

#import <UIKit/UIKit.h>
#import "AVCamCaptureManager.h"

//@class AVCamCaptureManager, AVCamPreviewView, AVCaptureVideoPreviewLayer;

@interface CustomCameraViewController : UIViewController<UIImagePickerControllerDelegate,UINavigationControllerDelegate> {
}


@property (nonatomic,retain) AVCamCaptureManager *captureManager;
@property (nonatomic,retain) AVCaptureVideoPreviewLayer *captureVideoPreviewLayer;

@property (strong, nonatomic) IBOutlet UIView *videoPreviewView;
@property (strong, nonatomic) IBOutlet UIButton *snapButton;

@end
