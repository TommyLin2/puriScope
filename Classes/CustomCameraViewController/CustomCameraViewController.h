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

#define RATE_RANGE 0.05

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
@property (nonatomic, retain) id <CustomCameraViewControllerDelegate> delegate;
@property (strong, nonatomic) UIImage *capturedImage;

@property (nonatomic, retain) id <MTLDevice> device;

@property (nonatomic, retain) id <MTLCommandQueue> commandQueue;
@property (nonatomic, strong) MTKTextureLoader *textureLoader;

@property (nonatomic, strong) CIContext *ciContext;
@property (nonatomic, retain) id <MTLTexture> sourceTexture;

////////////////////////To test to set Parameters /////////////////////////////////////
@property (strong, nonatomic) IBOutlet UITextField *firstObjectNameTextField;
@property (strong, nonatomic) IBOutlet UITextField *firstObjectValueTextField;

@property (strong, nonatomic) IBOutlet UITextField *secondObjectNameTextField;
@property (strong, nonatomic) IBOutlet UITextField *secondObjectValueTextField;


@property (nonatomic, assign) float display_object_screen_rate;
@property (nonatomic, strong) NSString *display_object_name;
@property (nonatomic, assign) bool isFirstObject;

@property (nonatomic, assign) float second_display_object_screen_rate;
@property (nonatomic, strong) NSString *second_display_object_name;
@property (nonatomic, assign) bool isSecondObject;

@property (nonatomic, strong) ParameterDataModel *firstObjectParameter;
@property (nonatomic, strong) ParameterDataModel *secondObjectParameter;

@end
