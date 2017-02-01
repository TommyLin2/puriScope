//
//  CustomCameraViewController.h
//  puriSCOPE
//
//  Created by Jordi on 26/01/17.
//
//

#import <UIKit/UIKit.h>
#import "AVCamCaptureManager.h"
#import <MetalKit/MetalKit.h>
#import <Metal/Metal.h>
#import <MetalPerformanceShaders/MetalPerformanceShaders.h>
#import "AVCamCaptureManager.h"

@class CustomCameraViewController;
@protocol CustomCameraViewControllerDelegate <NSObject>
- (void)customCameraImageCaptured:(CustomCameraViewController*)controller withCapturedImage:(UIImage *)image;
@end

@interface CustomCameraViewController : UIViewController<UIImagePickerControllerDelegate,UINavigationControllerDelegate,AVCamCaptureManagerDelegate,AVCaptureVideoDataOutputSampleBufferDelegate> {

}


@property (nonatomic,retain) AVCamCaptureManager *captureManager;
@property (nonatomic,retain) AVCaptureVideoPreviewLayer *captureVideoPreviewLayer;

@property (strong, nonatomic) IBOutlet UIView *videoPreviewView;
@property (strong, nonatomic) IBOutlet UIButton *snapButton;
@property (nonatomic, assign) id <CustomCameraViewControllerDelegate> delegate;
@property (strong, nonatomic) UIImage *capturedImage;

@property (nonatomic, assign) id <MTLDevice> device;

@property (nonatomic, assign) id <MTLCommandQueue> commandQueue;
@property (nonatomic, strong) MTKTextureLoader *textureLoader;

@property (nonatomic, strong) CIContext *ciContext;
@property (nonatomic, assign) id <MTLTexture> sourceTexture;

@end
