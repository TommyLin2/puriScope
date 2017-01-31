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

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initVideoCaptureSession];
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


- (void) captureManagerRealTimeImageCaptured:(CVImageBufferRef )imageBuffer withTimeStamp:(CMTime)timeStamp{

}

- (void)runNetWork{    
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
