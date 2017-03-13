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

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self initVideoCaptureSession];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initMTLDevice];
    
    [self initParameter];
    [self setParameterToTextField];

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

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}

-(BOOL)shouldAutorotate
{
    return YES;
}

- (void)dealloc
{
    self.captureManager = nil;
    self.captureVideoPreviewLayer = nil;
    self.device = nil;
    self.textureLoader = nil;
    self.commandQueue = nil;
    self.inception3Net = nil;
    self.ciContext = nil;
    [super dealloc];
}

-(void)initParameter{
    self.firstObjectParameter = [[ParameterDataModel alloc] init];
    self.secondObjectParameter = [[ParameterDataModel alloc] init];
    [self.firstObjectParameter setValueWithNameKey:FIRST_OBJECT_NAME withValueKey:FIRST_OBJECT_VALUE];
    [self.secondObjectParameter setValueWithNameKey:SECOND_OBJECT_NAME withValueKey:SECOND_OBJECT_VALUE];
}

-(void)setParameterToTextField{
    self.firstObjectNameTextField.text =self.firstObjectParameter.objectName;
    self.firstObjectValueTextField.text =[NSString stringWithFormat:@"%f",self.firstObjectParameter.objectValue];
    
    self.secondObjectNameTextField.text =self.secondObjectParameter.objectName;
    self.secondObjectValueTextField.text =[NSString stringWithFormat:@"%f",self.secondObjectParameter.objectValue];
}

-(void)initPhotoCaptureSeesion{
    if (self.captureManager == nil) {
        AVCamCaptureManager* manager = [[[AVCamCaptureManager alloc] init] autorelease];
        [self setCaptureManager:manager];
        
        //[self.captureManager setDelegate:self];
        self.captureManager.delegate = self;
        if (self.captureManager.setupSession) {
            // Create video preview layer and add it to the UI
            AVCaptureVideoPreviewLayer*newCaptureVideoPreviewLayer = [[[AVCaptureVideoPreviewLayer alloc] initWithSession:self.captureManager.session] autorelease];
            UIView* view = self.videoPreviewView;
            CALayer* viewLayer = view.layer;
            //[viewLayer setMasksToBounds:YES];
            
            CGRect bounds = view.bounds;
            [newCaptureVideoPreviewLayer setFrame:bounds];
            
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
        AVCamCaptureManager* manager = [[[AVCamCaptureManager alloc] init] autorelease];
        [self setCaptureManager:manager];
        self.captureManager.delegate = self;
        [self.captureManager setupCaptureSession];
        AVCaptureVideoPreviewLayer*newCaptureVideoPreviewLayer = [[[AVCaptureVideoPreviewLayer alloc] initWithSession:self.captureManager.session] autorelease];
        UIView* view = self.videoPreviewView;
        CALayer* viewLayer = view.layer;
        //[viewLayer setMasksToBounds:YES];
        CGRect bounds = view.bounds;
        [newCaptureVideoPreviewLayer setFrame:bounds];
        
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
    self.commandQueue = [[self.device newCommandQueue] autorelease];
    self.textureLoader = [[[MTKTextureLoader alloc] initWithDevice:self.device] autorelease];
    self.inception3Net = [[[Inception3Net alloc] initWithCommandQueue:self.commandQueue] autorelease];
    self.ciContext = [CIContext contextWithMTLDevice:self.device];
}

- (IBAction)setPartmeterTotest{
    [self.firstObjectParameter saveWithObjectNameWithValue:self.display_object_name withObjectValue:self.display_object_screen_rate withNameKey:FIRST_OBJECT_NAME withvalueKey:FIRST_OBJECT_VALUE];
    [self.secondObjectParameter saveWithObjectNameWithValue:self.second_display_object_name withObjectValue:self.second_display_object_screen_rate withNameKey:SECOND_OBJECT_NAME withvalueKey:SECOND_OBJECT_VALUE];

    [self setParameterToTextField];
}

- (IBAction)clearParameter{
    [self.firstObjectParameter saveWithObjectNameWithValue:@"" withObjectValue:0.0f withNameKey:FIRST_OBJECT_NAME withvalueKey:FIRST_OBJECT_VALUE];
    [self.secondObjectParameter saveWithObjectNameWithValue:@"" withObjectValue:0.0f withNameKey:SECOND_OBJECT_NAME withvalueKey:SECOND_OBJECT_VALUE];
    [self setParameterToTextField];
}

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
    CIImage *ciImage = [[[CIImage alloc] initWithCVImageBuffer:imageBuffer] autorelease];
    CGImageRef cgImageRef = [self.ciContext createCGImage:ciImage fromRect:ciImage.extent];
    if (cgImageRef) {
        self.sourceTexture = [self.textureLoader newTextureWithCGImage:cgImageRef options:nil error:nil];
    }
    else{
        return;
    }
    CGImageRelease(cgImageRef);
    [self runNetWork:ciImage];
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
            });
        }

        NSString *testString = [NSString stringWithFormat:@"%@ = %f",self.display_object_name,self.display_object_screen_rate];
        displayTestString = [NSString stringWithFormat:@"%@\n%@",displayTestString,testString];

        dispatch_async(dispatch_get_main_queue(), ^{
            [self.objectLabel1 setText: displayTestString];
        });
    }
}

- (void)getCapturedImage:(UIImage *)image{
//    [self addFlashView];
    self.isCaptured = true;
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)addFlashView{
    
    [self.view.subviews makeObjectsPerformSelector: @selector(removeFromSuperview)];

    UIView *flashView = [[[UIView alloc] initWithFrame:self.view.frame] autorelease];
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

//-(IBAction)startCameraSession{
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        [[self.captureManager session] startRunning];
//        self.isShooting = false;
//    });
//}

- (UIImage *)imageFromCIImage:(CIImage *)ciImage {
    CIContext *ciContext = [CIContext contextWithOptions:nil];
    CGImageRef cgImage = [ciContext createCGImage:ciImage fromRect:[ciImage extent]];
    UIImage *image = [UIImage imageWithCGImage:cgImage];
    CGImageRelease(cgImage);
    return image;
}

//- (void)shootImage{
//    if([self.captureManager.session isRunning]){
//        CFRunLoopPerformBlock(CFRunLoopGetMain(), kCFRunLoopCommonModes, ^(void) {
//            @try {
//                [self.captureManager captureStillImage];
//            }
//            @catch(NSException* iae) {
//                NSLog(@"%@", iae.reason);
//            }
//        // Flash the screen white and fade it out to give UI feedback that a still image was taken
//            UIView *flashView = [[[UIView alloc] initWithFrame:self.view.frame] autorelease];
//            [flashView setBackgroundColor:[UIColor whiteColor]];
//            [self.view.window addSubview:flashView];
//            [UIView animateWithDuration:.4f
//                         animations:^{
//                             [flashView setAlpha:0.f];
//                         }
//                         completion:^(BOOL finished){
//                             [flashView removeFromSuperview];
//                         }
//             ];
//        });
//    }
//}

@end
