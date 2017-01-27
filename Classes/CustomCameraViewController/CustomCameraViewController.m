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

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    if (self.captureManager == nil) {
        AVCamCaptureManager* manager = [[AVCamCaptureManager alloc] init];
        [self setCaptureManager:manager];
        [manager release];
        
        //[self.captureManager setDelegate:self];
        
        if (self.captureManager.setupSession) {
            // Create video preview layer and add it to the UI
            AVCaptureVideoPreviewLayer*newCaptureVideoPreviewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:self.captureManager.session];
            UIView* view = self.videoPreviewView;
            CALayer* viewLayer = view.layer;
            //[viewLayer setMasksToBounds:YES];
            
            CGRect bounds = view.bounds;
            [newCaptureVideoPreviewLayer setFrame:bounds];
            
            [newCaptureVideoPreviewLayer setVideoGravity:AVLayerVideoGravityResizeAspectFill];
            
            [viewLayer insertSublayer:newCaptureVideoPreviewLayer
                                below:[viewLayer.sublayers objectAtIndex:0]];
            
            [self setCaptureVideoPreviewLayer:newCaptureVideoPreviewLayer];
            [newCaptureVideoPreviewLayer release];
            
            // Start the session. This is done asychronously since -startRunning doesn't return until the session is running.
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                [[self.captureManager session] startRunning];
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
    [self removeObserver:self forKeyPath:@"captureManager.videoInput.device.focusMode"];
    [self.captureManager release];
    [self.captureVideoPreviewLayer release];
    [self.videoPreviewView release];
    [self.snapButton release];
    
    [super dealloc];
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
