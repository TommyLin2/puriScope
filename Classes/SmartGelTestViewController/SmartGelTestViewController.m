//
//  SmartGelTestViewController.m
//  puriSCOPE
//
//  Created by Jordi on 12/04/17.
//
//

#import "SmartGelTestViewController.h"
#import <Photos/PHAssetCollectionChangeRequest.h>
#import <Photos/PHAssetChangeRequest.h>
#import <Photos/PHCollection.h>
#import <Photos/PHFetchOptions.h>

@interface SmartGelTestViewController ()

@end

@implementation SmartGelTestViewController


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
    }
    return self;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}

-(BOOL)shouldAutorotate
{
    return YES;
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self initVideoCaptureSession];
    self.capturedImage = [[UIImage alloc] init];
    self.engine = [[DirtyExtractor alloc] init];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

- (void) captureManagerRealTimeImageCaptured:(CVImageBufferRef )imageBuffer withTimeStamp:(CMTime)timeStamp{
    CIImage *ciImage = [[CIImage alloc] initWithCVImageBuffer:imageBuffer] ;
    [self runNetWork:ciImage];
}

- (void)runNetWork:(CIImage *)ciImage{
    @autoreleasepool {
        [self.engine reset];
        self.capturedImage =[self imageFromCIImage:ciImage];
        [self.engine importImage:self.capturedImage];
        [self.engine extract];
        dispatch_async(dispatch_get_main_queue(), ^{
            self.capturedImageValueString = [NSString stringWithFormat:@"%.2f", self.engine.dirtyValue];
            [self.valueLabel setText:self.capturedImageValueString];
//            NSString *localValueString = [NSString stringWithFormat:@"Local Value - %.2f", self.engine.localDirtyValue];
//            [self.localValueLabel setText:localValueString];
        });
    }
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

-(IBAction)catureImage{
    
    [self addFlashView];
    UIImageWriteToSavedPhotosAlbum(self.capturedImage, nil, nil, nil);
    
    __block PHObjectPlaceholder *myAlbum;
    __block PHAssetCollection *collection;

    PHFetchOptions *fetchOptions = [[PHFetchOptions alloc] init];
    fetchOptions.predicate = [NSPredicate predicateWithFormat:@"title = %@", @"SmartGel"];
    collection = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeAlbum
                                                          subtype:PHAssetCollectionSubtypeAny
                                                          options:fetchOptions].firstObject;
    if(!collection){
        [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
            //        NSString *valueString = [NSString stringWithFormat:@"SmartGel - %@", self.capturedImageValueString];
            NSString *valueString = @"SmartGel";
            
            PHAssetCollectionChangeRequest *changeRequest = [PHAssetCollectionChangeRequest creationRequestForAssetCollectionWithTitle:valueString];
            myAlbum = changeRequest.placeholderForCreatedAssetCollection;
        } completionHandler:^(BOOL success, NSError *error) {
            if (success) {
                PHFetchResult *fetchResult = [PHAssetCollection fetchAssetCollectionsWithLocalIdentifiers:@[myAlbum.localIdentifier] options:nil];
                PHAssetCollection *assetCollection = fetchResult.firstObject;
                
                [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
                    PHAssetChangeRequest *assetChangeRequest = [PHAssetChangeRequest creationRequestForAssetFromImage:self.capturedImage];
                    
                    // add asset
                    PHAssetCollectionChangeRequest *assetCollectionChangeRequest = [PHAssetCollectionChangeRequest changeRequestForAssetCollection:assetCollection];
                    [assetCollectionChangeRequest addAssets:@[[assetChangeRequest placeholderForCreatedAsset]]];
                } completionHandler:^(BOOL success, NSError *error) {
                    if (success) {
                    }
                }];
            } else {
                NSLog(@"Error: %@", error);
            }
        }];

    }else{
        [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
            PHAssetChangeRequest *assetChangeRequest = [PHAssetChangeRequest creationRequestForAssetFromImage:self.capturedImage];
            
            // add asset
            PHAssetCollectionChangeRequest *assetCollectionChangeRequest = [PHAssetCollectionChangeRequest changeRequestForAssetCollection:collection];
            [assetCollectionChangeRequest addAssets:@[[assetChangeRequest placeholderForCreatedAsset]]];
        } completionHandler:^(BOOL success, NSError *error) {
            if (success) {
            }
        }];
    }
}

-(NSString*)getTimeString{
    NSDate *currentTime = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YYMMdd_hh_mm_ss"];
    NSString *resultString = [dateFormatter stringFromDate: currentTime];
    return resultString;
}

-(BOOL)prefersStatusBarHidden{
    return YES;
}

-(void)addFlashView{
    
    [self.videoPreviewView.subviews makeObjectsPerformSelector: @selector(removeFromSuperview)];
    
    UIView *flashView = [[UIView alloc] initWithFrame:self.view.frame] ;
    [flashView setBackgroundColor:[UIColor whiteColor]];
    [self.videoPreviewView addSubview:flashView];
    [UIView animateWithDuration:.4f
                     animations:^{
                         [flashView setAlpha:0.f];
                     }
                     completion:^(BOOL finished){
                         [flashView removeFromSuperview];
                     }
     ];
}


@end
