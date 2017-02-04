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
    [self setParameter];
    // Do any additional setup after loading the view.
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
    [super dealloc];
}

-(void)setParameter{
    self.parameterDataModel = [[ParameterDataModel alloc] init];
    [self.parameterDataModel setParmetersFromKey];
    self.objectNameTextField.text = [self.parameterDataModel getObjectName];
    self.objectValueTextField.text =[NSString stringWithFormat:@"%f",[self.parameterDataModel getObjectValue]];
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
    self.commandQueue = [self.device newCommandQueue];
    self.textureLoader = [[MTKTextureLoader alloc] initWithDevice:self.device];
    self.inception3Net = [[Inception3Net alloc] initWithCommandQueue:self.commandQueue];
    self.ciContext = [CIContext contextWithMTLDevice:self.device];
}


- (IBAction)setPartmeterTotest{
    [self.parameterDataModel setWithObjectNameWithValue:self.display_object_name withObjectValue:self.display_object_screen_rate];
    [self.parameterDataModel storeParmeters];
    self.objectNameTextField.text =self.display_object_name;
    self.objectValueTextField.text =[NSString stringWithFormat:@"%f",self.display_object_screen_rate];
}

- (IBAction)clearParameter{
    [self.parameterDataModel setWithObjectNameWithValue:@"" withObjectValue:0.0];
    [self.parameterDataModel storeParmeters];
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

        for (int i =0; i<1; i++) {
            NSMutableDictionary *dictionary  = [array objectAtIndex:i];
            NSArray*keys=[dictionary allKeys];
            self.display_object_name = keys[0];
            self.display_object_screen_rate = [[dictionary objectForKey:self.display_object_name] floatValue];
            
            if ([self.display_object_name isEqualToString:[self.parameterDataModel getObjectName] ]) {
                if ((self.display_object_screen_rate>[self.parameterDataModel getObjectValue]-RATE_RANGE)&&(self.display_object_screen_rate<[self.parameterDataModel getObjectValue]+RATE_RANGE)) {
                        dispatch_async(dispatch_get_main_queue(), ^{
                            [[self.captureManager session] stopRunning];
                            self.capturedImage = [self imageFromCIImage:ciImage];
                            [self getCapturedImage:self.capturedImage];
                        });
                }
            }
            NSString *testString = [NSString stringWithFormat:@"%@ = %f",self.display_object_name,self.display_object_screen_rate];
            displayTestString = [NSString stringWithFormat:@"%@\n%@",displayTestString,testString];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.objectLabel1 setText: displayTestString];
        });
    }
}

- (void)getCapturedImage:(UIImage *)image{
    [self addFlashView];
    if (self.delegate) {
        [self.delegate customCameraImageCaptured:self withCapturedImage:self.capturedImage];
    }
}

-(void)addFlashView{
    UIView *flashView = [[[UIView alloc] initWithFrame:self.view.frame] autorelease];
    [flashView setBackgroundColor:[UIColor whiteColor]];
    [self.view.window addSubview:flashView];
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
