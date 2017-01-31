//
//  CustomCameraViewController.m
//  puriSCOPE
//
//  Created by Jordi on 26/01/17.
//
//

#import "CustomCameraViewController.h"

@interface CustomCameraViewController ()

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


- (void)viewDidLoad {
    [super viewDidLoad];
   
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
                [self initCaptureDevice];
            });
        }
    }
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


- (void)initMTLDevice{
    self.device = MTLCreateSystemDefaultDevice();
//    guard MPSSupportsMTLDevice(device) else {
//        showAlert(title: "Not Supported", message: "MetalPerformanceShaders is not supported on current device", handler: { (action) in
//            self.navigationController!.popViewController(animated: true)
//        })
//        return
//    }
//    
//    let spec = VideoSpec(fps: 3, size: CGSize(width: 1280, height: 720))
//    videoCapture = VideoCapture(cameraType: .back,
//                                preferredSpec: spec,
//                                previewContainer: previewView.layer)
//    videoCapture.imageBufferHandler = {[unowned self] (imageBuffer, timestamp, outputBuffer) in
//        let ciImage = CIImage(cvPixelBuffer: imageBuffer)
//        guard let cgImage = self.ciContext.createCGImage(ciImage, from: ciImage.extent) else {return}
//        
//        // get a texture from this CGImage
//        do {
//            self.sourceTexture = try self.textureLoader.newTexture(with: cgImage, options: [:])
//        }
//        catch let error as NSError {
//            fatalError("Unexpected error ocurred: \(error.localizedDescription).")
//        }
//        // run inference neural network to get predictions and display them
//        self.runNetwork()
//    }
//    
//    // Load any resources required for rendering.
//    
//    // Create new command queue.
//    commandQueue = device!.makeCommandQueue()
//    
//    // make a textureLoader to get our input images as MTLTextures
//    textureLoader = MTKTextureLoader(device: device!)
//    
//    // Load the appropriate Network
//    inception3Net = Inception3Net(withCommandQueue: commandQueue)
//    
//    // we use this CIContext as one of the steps to get a MTLTexture
//    ciContext = CIContext.init(mtlDevice: device)

}

-(void)initCaptureDevice{
    
    AVCaptureVideoDataOutput *output = [[AVCaptureVideoDataOutput alloc] init];
    output.alwaysDiscardsLateVideoFrames = true;
    
    // Configure your output.
    dispatch_queue_t queue = dispatch_queue_create("myQueue", NULL);
    [output setSampleBufferDelegate:self queue:queue];
    if (![self.captureManager.session canAddOutput:output]) {
        NSLog(@"error: cannot Add output");
        return;
    }
    [self.captureManager.session addOutput:output];
    // Specify the pixel format
    output.videoSettings =
    [NSDictionary dictionaryWithObject:
     [NSNumber numberWithInt:kCVPixelFormatType_32BGRA]
                                forKey:(id)kCVPixelBufferPixelFormatTypeKey];

}

- (void)captureOutput:(AVCaptureOutput *)captureOutput
didOutputSampleBuffer:(CMSampleBufferRef)sampleBuffer
       fromConnection:(AVCaptureConnection *)connection
{
    // Create a UIImage from the sample buffer data
    [connection setVideoOrientation:AVCaptureVideoOrientationLandscapeLeft];
//    UIImage *image = [self imageFromSampleBuffer:sampleBuffer];
}
// Create a UIImage from sample buffer data
//- (UIImage *) imageFromSampleBuffer:(CMSampleBufferRef) sampleBuffer
//{
    // Get a CMSampleBuffer's Core Video image buffer for the media data
//    CVImageBufferRef imageBuffer = CMSampleBufferGetImageBuffer(sampleBuffer);
//    // Lock the base address of the pixel buffer
//    CVPixelBufferLockBaseAddress(imageBuffer, 0);
//    
//    // Get the number of bytes per row for the pixel buffer
//    void *baseAddress = CVPixelBufferGetBaseAddress(imageBuffer);
//    
//    // Get the number of bytes per row for the pixel buffer
//    size_t bytesPerRow = CVPixelBufferGetBytesPerRow(imageBuffer);
//    // Get the pixel buffer width and height
//    size_t width = CVPixelBufferGetWidth(imageBuffer);
//    size_t height = CVPixelBufferGetHeight(imageBuffer);
//    
//    // Create a device-dependent RGB color space
//    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
//    
//    // Create a bitmap graphics context with the sample buffer data
//    CGContextRef context = CGBitmapContextCreate(baseAddress, width, height, 8,
//                                                 bytesPerRow, colorSpace, kCGBitmapByteOrder32Little | kCGImageAlphaPremultipliedFirst);
//    // Create a Quartz image from the pixel data in the bitmap graphics context
//    CGImageRef quartzImage = CGBitmapContextCreateImage(context);
//    // Unlock the pixel buffer
//    CVPixelBufferUnlockBaseAddress(imageBuffer,0);
//    
//    // Free up the context and color space
//    CGContextRelease(context);
//    CGColorSpaceRelease(colorSpace);
//    
//    // Create an image object from the Quartz image
//    UIImage *image = [UIImage imageWithCGImage:quartzImage];
//    
//    // Release the Quartz image
//    CGImageRelease(quartzImage);
    
//    return (image);
//}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
