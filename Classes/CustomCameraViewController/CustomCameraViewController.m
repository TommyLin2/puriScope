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

-(IBAction)captureStillImage:(id)sender {
    // Capture a still image
    @try {
        [self.captureManager captureStillImage];
    }
    @catch(NSException* iae) {
        NSLog(@"%@", iae.reason);
    }
    
    // Flash the screen white and fade it out to give UI feedback that a still image was taken
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

- (void)captureManagerStillImageCaptured:(UIImage *)image {
    [[self.captureManager session] stopRunning];
    self.capturedImage = image;

    CFRunLoopPerformBlock(CFRunLoopGetMain(), kCFRunLoopCommonModes, ^(void) {
        if (self.delegate) {
            [self.delegate customCameraImageCaptured:self withCapturedImage:self.capturedImage];
        }
    });
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

- (void) captureManagerRealTimeImageCaptured:(CVImageBufferRef )imageBuffer withTimeStamp:(CMTime)timeStamp{
    CIImage *ciImage = [[[CIImage alloc] initWithCVImageBuffer:imageBuffer] autorelease];
    CGImageRef cgImageRef = [self.ciContext createCGImage:ciImage fromRect:ciImage.extent];
    if (cgImageRef) {
        self.sourceTexture = [self.textureLoader newTextureWithCGImage:cgImageRef options:nil error:nil];
    }
    else{
        return;
    }

    [self runNetWork];
}

- (void)runNetWork{
//    let startTime = CACurrentMediaTime()
//    
//    // to deliver optimal performance we leave some resources used in MPSCNN to be released at next call of autoreleasepool,
//    // so the user can decide the appropriate time to release this
//    autoreleasepool{
//        // encoding command buffer
//        let commandBuffer = commandQueue.makeCommandBuffer()
//        
//        // encode all layers of network on present commandBuffer, pass in the input image MTLTexture
//        inception3Net.forward(commandBuffer: commandBuffer, sourceTexture: sourceTexture)
//        
//        // commit the commandBuffer and wait for completion on CPU
//        commandBuffer.commit()
//        commandBuffer.waitUntilCompleted()
//        
//        // display top-5 predictions for what the object should be labelled
//        var resultStr = ""
//        inception3Net.getResults().forEach({ (label, prob) in
//            resultStr = resultStr + label + "\t" + String(format: "%.1f", prob * 100) + "%\n\n"
//        })
//        
//        DispatchQueue.main.async {
//            self.predictLabel.text = resultStr
//        }
//    }
//    
//    let endTime = CACurrentMediaTime()
//    print("Running Time: \(endTime - startTime) [sec]")
    
    @autoreleasepool {
        id<MTLCommandBuffer> commandBuffer = [self.commandQueue commandBuffer];
        [self.inception3Net forwardWithCommandBuffer:commandBuffer sourceTexture:self.sourceTexture];
        [commandBuffer commit];
        [commandBuffer waitUntilCompleted];
        
        NSArray* array = self.inception3Net.getResults;
        NSLog(@"result - %@", array);

        /*
         commandBuffer.commit()
         commandBuffer.waitUntilCompleted()
         
         // display top-5 predictions for what the object should be labelled
         var resultStr = ""
         inception3Net.getResults().forEach({ (label, prob) in
         resultStr = resultStr + label + "\t" + String(format: "%.1f", prob * 100) + "%\n\n"
         })
         
         DispatchQueue.main.async {
         self.predictLabel.text = resultStr
         }
         
         */
        
    }
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
