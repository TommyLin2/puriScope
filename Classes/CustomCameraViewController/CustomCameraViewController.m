//
//  CustomCameraViewController.m
//  puriSCOPE
//
//  Created by Jordi on 26/01/17.
//
//

#import "CustomCameraViewController.h"
#import "puriSCOPE-Swift.h"

@class Inception3Net;

@interface CustomCameraViewController ()

@property (strong, nonatomic) Inception3Net *inception3Net;
@property bool isCaptured;
@property bool isCapturing;
@property bool isSettedParameter;

@end

@implementation CustomCameraViewController
@synthesize captureManager;
@synthesize videoPreviewView;
@synthesize captureVideoPreviewLayer;

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

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self initVideoCaptureSession];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initMTLDevice];
    
    [self initParameter];
    [self initUIwithSettedParamter];
    // Do any additional setup after loading the view.
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    if(_isCaptured){
        if (self.delegate) {
            [self.delegate customCameraImageCaptured:self withCapturedImage:self.capturedImage];
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (AVCaptureVideoOrientation)interfaceOrientationToVideoOrientation:(UIInterfaceOrientation)orientation {
    switch (orientation) {
        case UIInterfaceOrientationPortrait:
            return AVCaptureVideoOrientationPortrait;
        case UIInterfaceOrientationPortraitUpsideDown:
            return AVCaptureVideoOrientationPortraitUpsideDown;
        case UIInterfaceOrientationLandscapeLeft:
            return AVCaptureVideoOrientationLandscapeLeft;
        case UIInterfaceOrientationLandscapeRight:
            return AVCaptureVideoOrientationLandscapeRight;
        default:
            break;
    }
    return AVCaptureVideoOrientationPortrait;
}

//- (void)dealloc
//{
//    self.captureManager = nil;
//    self.captureVideoPreviewLayer = nil;
//    self.device = nil;
//    self.textureLoader = nil;
//    self.commandQueue = nil;
//    self.inception3Net = nil;
//    self.ciContext = nil;
//}

-(void)initParameter{
    self.firstObjectParameter = [[ParameterDataModel alloc] init];
    self.secondObjectParameter = [[ParameterDataModel alloc] init];
    [self.firstObjectParameter setValueWithNameKey:FIRST_OBJECT_NAME withValueKey:FIRST_OBJECT_VALUE];
    [self.secondObjectParameter setValueWithNameKey:SECOND_OBJECT_NAME withValueKey:SECOND_OBJECT_VALUE];
    if((self.firstObjectParameter.objectValue==0.0f)||(self.secondObjectParameter.objectValue==0.0f))
        self.isSettedParameter = false;
    else
        self.isSettedParameter = true;
    self.isCapturing = false;
}

-(void)initUIwithSettedParamter{
    if(self.isSettedParameter){
        [self.buttonLabel setText:@"Reset"];
        [self showAlertdialog:@"PuriScope" message:@"Please press Reset button to reset distance of auto shoot."];
    }else{
        [self.buttonLabel setText:@"Set"];
        [self showAlertdialog:@"PuriScope" message:@"Please press Set button to set distance of auto shoot."];
    }
}

-(void)showAlertdialog:(NSString*)title message:(NSString*)message{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title
                                                                   message:message
                                                            preferredStyle:UIAlertControllerStyleAlert]; // 1
    [alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
    [self presentViewController:alert animated:YES completion:nil];
}

-(void)initPhotoCaptureSeesion{
    if (self.captureManager == nil) {
        AVCamCaptureManager* manager = [[AVCamCaptureManager alloc] init] ;
        [self setCaptureManager:manager];
        
        //[self.captureManager setDelegate:self];
        self.captureManager.delegate = self;
        if (self.captureManager.setupSession) {
            // Create video preview layer and add it to the UI
            AVCaptureVideoPreviewLayer*newCaptureVideoPreviewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:self.captureManager.session] ;
            UIView* view = self.videoPreviewView;
            CALayer* viewLayer = view.layer;
            //[viewLayer setMasksToBounds:YES];
            
            CGRect bounds = view.bounds;

            [newCaptureVideoPreviewLayer setFrame:bounds];
            if (newCaptureVideoPreviewLayer.connection.supportsVideoOrientation) {
                newCaptureVideoPreviewLayer.connection.videoOrientation = [self interfaceOrientationToVideoOrientation:[UIApplication sharedApplication].statusBarOrientation];
            }

            [newCaptureVideoPreviewLayer setVideoGravity:AVLayerVideoGravityResizeAspectFill];
            [viewLayer insertSublayer:newCaptureVideoPreviewLayer
                                below:[viewLayer.sublayers objectAtIndex:0]];
            
            [self setCaptureVideoPreviewLayer:newCaptureVideoPreviewLayer];
            
            // Start the session. This is done asychronously since -startRunning doesn't return until the session is running.
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                [[self.captureManager session] startRunning];
            });
        }
    }
}

- (void)initVideoCaptureSession{
    if (self.captureManager == nil) {
        AVCamCaptureManager* manager = [[AVCamCaptureManager alloc] init] ;
        [self setCaptureManager:manager];
        self.captureManager.delegate = self;
        [self.captureManager setupCaptureSession];
        AVCaptureVideoPreviewLayer*newCaptureVideoPreviewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:self.captureManager.session];
        UIView* view = self.videoPreviewView;
        CALayer* viewLayer = view.layer;
        //[viewLayer setMasksToBounds:YES];
        CGRect bounds = view.bounds;
        [newCaptureVideoPreviewLayer setFrame:bounds];
        if (newCaptureVideoPreviewLayer.connection.supportsVideoOrientation) {
            newCaptureVideoPreviewLayer.connection.videoOrientation = [self interfaceOrientationToVideoOrientation:[UIApplication sharedApplication].statusBarOrientation];
        }
        [newCaptureVideoPreviewLayer setVideoGravity:AVLayerVideoGravityResizeAspectFill];
        
        [viewLayer insertSublayer:newCaptureVideoPreviewLayer
                            below:[viewLayer.sublayers objectAtIndex:0]];
        
        [self setCaptureVideoPreviewLayer:newCaptureVideoPreviewLayer];
        // Start the session. This is done asychronously since -startRunning doesn't return until the session is running.
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            [[self.captureManager session] startRunning];
        });
    }
}

- (void)initMTLDevice{
    self.device = MTLCreateSystemDefaultDevice();
    self.commandQueue = [self.device newCommandQueue] ;
    self.textureLoader = [[MTKTextureLoader alloc] initWithDevice:self.device];
    self.inception3Net = [[Inception3Net alloc] initWithCommandQueue:self.commandQueue];
    self.ciContext = [CIContext contextWithMTLDevice:self.device];
}

- (IBAction)setPartmeterTotest{
    
    if(self.isSettedParameter){
        [self.firstObjectParameter saveWithObjectNameWithValue:@"" withObjectValue:0.0f withNameKey:FIRST_OBJECT_NAME withvalueKey:FIRST_OBJECT_VALUE];
        [self.secondObjectParameter saveWithObjectNameWithValue:@"" withObjectValue:0.0f withNameKey:SECOND_OBJECT_NAME withvalueKey:SECOND_OBJECT_VALUE];
        self.isSettedParameter = false;
    }else{
        [self.firstObjectParameter saveWithObjectNameWithValue:self.display_object_name withObjectValue:self.display_object_screen_rate withNameKey:FIRST_OBJECT_NAME withvalueKey:FIRST_OBJECT_VALUE];
        [self.secondObjectParameter saveWithObjectNameWithValue:self.second_display_object_name withObjectValue:self.second_display_object_screen_rate withNameKey:SECOND_OBJECT_NAME withvalueKey:SECOND_OBJECT_VALUE];
        self.isSettedParameter = true;
    }
    [self initUIwithSettedParamter];
}

//- (IBAction)clearParameter{
//    [self.firstObjectParameter saveWithObjectNameWithValue:@"" withObjectValue:0.0f withNameKey:FIRST_OBJECT_NAME withvalueKey:FIRST_OBJECT_VALUE];
//    [self.secondObjectParameter saveWithObjectNameWithValue:@"" withObjectValue:0.0f withNameKey:SECOND_OBJECT_NAME withvalueKey:SECOND_OBJECT_VALUE];
//    [self setParameterToTextField];
//}

- (void)setPhotoCaptureSession{
    [[self.captureManager session] stopRunning];
    CFRunLoopPerformBlock(CFRunLoopGetMain(), kCFRunLoopCommonModes, ^(void) {
        self.captureManager = nil;
        [self.captureVideoPreviewLayer.sublayers makeObjectsPerformSelector:@selector(removeFromSuperlayer)];
        [self initPhotoCaptureSeesion];
    });
}

//- (void)captureManagerStillImageCaptured:(UIImage *)image {
//    [[self.captureManager session] stopRunning];
//
//    CFRunLoopPerformBlock(CFRunLoopGetMain(), kCFRunLoopCommonModes, ^(void) {
//        if (self.delegate) {
//            [self.delegate customCameraImageCaptured:self withCapturedImage:self.capturedImage];
//        }
//    });
//}

- (void) captureManagerRealTimeImageCaptured:(CVImageBufferRef )imageBuffer withTimeStamp:(CMTime)timeStamp{

    if(self.isCapturing)
        return;
    
    CIImage *ciImage = [[CIImage alloc] initWithCVImageBuffer:imageBuffer] ;
    CGImageRef cgImageRef = [self.ciContext createCGImage:ciImage fromRect:ciImage.extent];
    if (cgImageRef) {
        self.sourceTexture = [self.textureLoader newTextureWithCGImage:cgImageRef options:nil error:nil];
    }
    else{
        CGImageRelease(cgImageRef);
        return;
    }

    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        CGImageRelease(cgImageRef);
        self.isCapturing = true;
        [self runNetWork:ciImage];
    });
}

- (void)runNetWork:(CIImage *)ciImage{

    @autoreleasepool {
        id<MTLCommandBuffer> commandBuffer = [self.commandQueue commandBuffer];
        [self.inception3Net forwardWithCommandBuffer:commandBuffer sourceTexture:self.sourceTexture];
        [commandBuffer commit];
        [commandBuffer waitUntilCompleted];
        NSArray* array = self.inception3Net.getResults;
        NSLog(@"result - %@", array);
        NSString *displayTestString = @"";

        NSMutableDictionary *dictionary1  = [array objectAtIndex:0];
        NSArray *keys1=[dictionary1 allKeys];
        self.display_object_name = keys1[0];
        self.display_object_screen_rate = [[dictionary1 objectForKey:self.display_object_name] floatValue];
        
        NSMutableDictionary *dictionary2  = [array objectAtIndex:1];
        NSArray *keys2=[dictionary2 allKeys];
        self.second_display_object_name = keys2[0];
        self.second_display_object_screen_rate = [[dictionary2 objectForKey:self.second_display_object_name] floatValue];

        self.firstObjectParameter.objectValue = 0.7;
        if ([self.display_object_name isEqualToString:self.firstObjectParameter.objectName]) {
            if ((self.display_object_screen_rate>(self.firstObjectParameter.objectValue-RATE_RANGE))&&(self.display_object_screen_rate<(self.firstObjectParameter.objectValue+RATE_RANGE))) {
                self.isFirstObject = true;
            }
        }
        
        self.firstObjectParameter.objectValue = 0.7;

        if ([self.second_display_object_name isEqualToString:self.secondObjectParameter.objectName]) {
            if ((self.second_display_object_screen_rate>(self.secondObjectParameter.objectValue-RATE_RANGE))&&(self.second_display_object_screen_rate<(self.secondObjectParameter.objectValue+RATE_RANGE))) {
                self.isSecondObject = true;
            }
        }
        
        if (self.isFirstObject&&self.isSecondObject) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [[self.captureManager session] stopRunning];
                self.capturedImage = [self imageFromCIImage:ciImage];
                [self getCapturedImage:self.capturedImage];
                self.isCapturing = false;
            });
        }

        NSString *testString = [NSString stringWithFormat:@"%@ = %f",self.display_object_name,self.display_object_screen_rate];
        displayTestString = [NSString stringWithFormat:@"%@\n%@",displayTestString,testString];
        self.isCapturing = false;
//        dispatch_async(dispatch_get_main_queue(), ^{
//            [self.objectLabel1 setText: displayTestString];
//        });
    }
}

- (void)getCapturedImage:(UIImage *)image{
//    [self addFlashView];
    self.isCaptured = true;
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)addFlashView{
    
    [self.view.subviews makeObjectsPerformSelector: @selector(removeFromSuperview)];

    UIView *flashView = [[UIView alloc] initWithFrame:self.view.frame] ;
    [flashView setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:flashView];
    [UIView animateWithDuration:.4f
                             animations:^{
                                 [flashView setAlpha:0.f];
                             }
                             completion:^(BOOL finished){
                                 [flashView removeFromSuperview];
                             }
    ];
}

- (UIImage *)imageFromCIImage:(CIImage *)ciImage {
    CIContext *ciContext = [CIContext contextWithOptions:nil];
    CGImageRef cgImage = [ciContext createCGImage:ciImage fromRect:[ciImage extent]];
    UIImage *image = [UIImage imageWithCGImage:cgImage];
    CGImageRelease(cgImage);
    return image;
}

-(IBAction)backButtonPressed{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
