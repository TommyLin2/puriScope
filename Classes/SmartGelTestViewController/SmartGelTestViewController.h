//
//  SmartGelTestViewController.h
//  puriSCOPE
//
//  Created by Jordi on 12/04/17.
//
//

#import <UIKit/UIKit.h>
#import "AVCamCaptureManager.h"
#import "DirtyExtractor.h"

@interface SmartGelTestViewController : UIViewController<UIImagePickerControllerDelegate,UINavigationControllerDelegate,AVCamCaptureManagerDelegate,AVCaptureVideoDataOutputSampleBufferDelegate> {
    
}

@property (nonatomic,retain) AVCamCaptureManager *captureManager;
@property (nonatomic,retain) AVCaptureVideoPreviewLayer *captureVideoPreviewLayer;

@property (strong, nonatomic) IBOutlet UIView *videoPreviewView;

@property (strong, nonatomic) IBOutlet UILabel *localValueLabel;
@property (strong, nonatomic) IBOutlet UILabel *valueLabel;

@property (strong, nonatomic) UIImage *capturedImage;
@property (strong, nonatomic) NSString *capturedImageValueString;


@property (nonatomic, strong) DirtyExtractor *engine;


@end
