//
//  CustomCameraViewController.h
//  puriSCOPE
//
//  Created by Jordi on 26/01/17.
//
//

#import <UIKit/UIKit.h>
#import "AVCamCaptureManager.h"

@class CustomCameraViewController;
@protocol CustomCameraViewControllerDelegate <NSObject>
- (void)customCameraImageCaptured:(CustomCameraViewController*)controller withCapturedImage:(UIImage *)image;
@end

@interface CustomCameraViewController : UIViewController<UIImagePickerControllerDelegate,UINavigationControllerDelegate,AVCamCaptureManagerDelegate> {
}


@property (nonatomic,retain) AVCamCaptureManager *captureManager;
@property (nonatomic,retain) AVCaptureVideoPreviewLayer *captureVideoPreviewLayer;

@property (strong, nonatomic) IBOutlet UIView *videoPreviewView;
@property (strong, nonatomic) IBOutlet UIButton *snapButton;
@property (nonatomic, assign) id <CustomCameraViewControllerDelegate> delegate;
@property (strong, nonatomic) UIImage *capturedImage;

@end
