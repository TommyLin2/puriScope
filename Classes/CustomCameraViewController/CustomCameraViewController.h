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
#import "ParameterDataModel.h"

#define RATE_RANGE 0.1

@class CustomCameraViewController;
@protocol CustomCameraViewControllerDelegate <NSObject>
- (void)customCameraImageCaptured:(CustomCameraViewController*)controller withCapturedImage:(UIImage *)image;
@end

@interface CustomCameraViewController : UIViewController<UIImagePickerControllerDelegate,UINavigationControllerDelegate,AVCamCaptureManagerDelegate,AVCaptureVideoDataOutputSampleBufferDelegate> {

}

@property (nonatomic,retain) AVCamCaptureManager *captureManager;
@property (nonatomic,retain) AVCaptureVideoPreviewLayer *captureVideoPreviewLayer;

@property (strong, nonatomic) IBOutlet UIView *videoPreviewView;
@property (retain, nonatomic) IBOutlet UILabel *objectLabel1;

@property (strong, nonatomic) IBOutlet UIButton *snapButton;
@property (nonatomic, assign) id <CustomCameraViewControllerDelegate> delegate;
@property (strong, nonatomic) UIImage *capturedImage;

@property (nonatomic, assign) id <MTLDevice> device;

@property (nonatomic, assign) id <MTLCommandQueue> commandQueue;
@property (nonatomic, strong) MTKTextureLoader *textureLoader;

@property (nonatomic, strong) CIContext *ciContext;
@property (nonatomic, assign) id <MTLTexture> sourceTexture;

////////////////////////To test to set Parameters /////////////////////////////////////
@property (strong, nonatomic) IBOutlet UITextField *objectNameTextField;
@property (strong, nonatomic) IBOutlet UITextField *objectValueTextField;

@property (nonatomic, assign) float display_object_screen_rate;
@property (nonatomic, strong) NSString *display_object_name;

@property (nonatomic, strong) ParameterDataModel *parameterDataModel;
@end
