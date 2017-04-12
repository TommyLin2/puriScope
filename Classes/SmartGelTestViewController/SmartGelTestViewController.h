//
//  SmartGelTestViewController.h
//  puriSCOPE
//
//  Created by Jordi on 12/04/17.
//
//

#import <UIKit/UIKit.h>
#import "AVCamCaptureManager.h"

@interface SmartGelTestViewController : UIViewController<UIImagePickerControllerDelegate,UINavigationControllerDelegate,AVCamCaptureManagerDelegate,AVCaptureVideoDataOutputSampleBufferDelegate> {
    
}

@property (nonatomic,retain) AVCamCaptureManager *captureManager;
@property (nonatomic,retain) AVCaptureVideoPreviewLayer *captureVideoPreviewLayer;

@property (strong, nonatomic) IBOutlet UIView *videoPreviewView;

@end
