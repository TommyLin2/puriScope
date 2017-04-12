//
//  ExtractDirty.m
//  grayscale test
//
//  Created by liu on 4/10/17.
//  Copyright © 2017 afco. All rights reserved.
//

#import "DirtyExtractor.h"

#define NO_DIRTY_PIXEL          0x0
#define PINK_DIRTY_PIXEL        0xFF00FFFF
#define BLUE_DIRTY_PIXEL        0x00FFFFFF

#define PIXEL_STEP              3
#define MAX_DIRTY_VALUE         10.0f

#define MIN_LOCAL_AREA_PERCENT  0.01f

@implementation DirtyExtractor

- (id) init
{
    self = [super init];
    
    return self;
}

- (void) dealloc
{
    [self reset];
}

- (void) reset
{
    _dirtyValue = 0.0f;
    _localDirtyValue = 0.0f;

    m_imageWidth = 0;
    m_imageHeight = 0;
    
    m_nPinkCount = 0;
    m_nBlueCount = 0;
    
    if (m_pInBuffer)
    {
        free (m_pInBuffer);
        m_pInBuffer = NULL;
    }
    
    if (m_pOutBuffer)
    {
        free (m_pOutBuffer);
        m_pOutBuffer = NULL;
    }
}

- (void) importImage:(UIImage *)image
{
    m_imageWidth = image.size.width;
    m_imageHeight = image.size.height;
    
    m_pInBuffer = (UInt32 *)calloc(sizeof(UInt32), m_imageWidth * m_imageHeight);
    m_pOutBuffer = (UInt32 *)calloc(sizeof(UInt32), m_imageWidth * m_imageHeight);
    
    int nBytesPerRow = m_imageWidth * 4;
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = CGBitmapContextCreate(m_pInBuffer, m_imageWidth, m_imageHeight, 8, nBytesPerRow, colorSpace, kCGBitmapByteOrder32Little | kCGImageAlphaNoneSkipLast);
    
    CGContextSetInterpolationQuality(context, kCGInterpolationHigh);
    CGContextSetShouldAntialias(context, NO);
    CGContextDrawImage(context, CGRectMake(0, 0, m_imageWidth, m_imageHeight), image.CGImage);
    CGContextRelease(context);
    CGColorSpaceRelease(colorSpace);
}

- (void)    extract
{
    [self smoothBufferByAverage];
    [self filtering];
    [self calculateDirtyValue];
}

- (void)    filtering
{
    UInt32 * pPixelBuffer = m_donePreprocess ? m_pOutBuffer : m_pInBuffer;
    for (int y = 0; y < m_imageHeight; y++)
    {
        for(int x = 0; x < m_imageWidth; x++)
        {
            int index = y * m_imageWidth + x;
            
            RGBA rgba;
            memcpy(&rgba, &pPixelBuffer[index], sizeof(RGBA));
            
            UInt32 dirtyPixel = [self getDirtyPixel:&rgba];
            if (dirtyPixel)
                m_pOutBuffer[index] = dirtyPixel;
            else if (!m_donePreprocess)
                m_pOutBuffer[index] = pPixelBuffer[index];
        }
    }
}

- (void)    smoothBufferByAverage
{
    int pixelStep = PIXEL_STEP;
    for (int y = 0; y < m_imageHeight; y += pixelStep)
    {
        for(int x = 0; x < m_imageWidth; x+= pixelStep)
        {
            int endX = MIN(m_imageWidth, x + pixelStep);
            int endY = MIN(m_imageHeight, y + pixelStep);
            
            int sR = 0;
            int sG = 0;
            int sB = 0;
            int nCount = 0;
            for (int yy = y; yy < endY; yy++)
            {
                for (int xx = x; xx < endX; xx++)
                {
                    RGBA rgba;
                    int index = yy * m_imageWidth + xx;
                    memcpy(&rgba, &m_pInBuffer[index], sizeof(RGBA));
                    sR += rgba.r;
                    sG += rgba.g;
                    sB += rgba.b;
                    
                    nCount++;
                }
            }
            
            RGBA averageRGB;
            averageRGB.r = sR / nCount;
            averageRGB.g = sG / nCount;
            averageRGB.b = sB / nCount;
            
            for (int yy = y; yy < endY; yy++)
            {
                for (int xx = x; xx < endX; xx++)
                {
                    int index = yy * m_imageWidth + xx;
                    memcpy(&m_pOutBuffer[index], &averageRGB, sizeof(RGBA));
                }
            }
        }
    }
    m_donePreprocess = YES;
}

- (UInt32)   getDirtyPixel:(RGBA *)rgba
{
    UInt8 minValue = 0x7F;
    if (rgba->r < minValue && rgba->g < minValue && rgba->b < minValue)
        return NO_DIRTY_PIXEL;
   
    int yellowValue = rgba->r + rgba->g;
    int greenValue = rgba->g + rgba->b;
    int pinkValue = rgba->r + rgba->b;
    if (yellowValue > greenValue && yellowValue > pinkValue)
        return NO_DIRTY_PIXEL;
    
    int distanceRedGreen = abs(rgba->r - rgba->g);
    int distanceGreenBlue = abs(rgba->g - rgba->b);
    int distanceRedBlue = abs(rgba->r - rgba->b);
    if (distanceRedBlue > 0xF && distanceGreenBlue > 0xF)
        return NO_DIRTY_PIXEL;
    
    if (MAX(MAX(distanceRedBlue, distanceGreenBlue), distanceRedGreen) < 0xF)
        return NO_DIRTY_PIXEL;
    
    BOOL isPinkSerial = pinkValue > greenValue;
    if (isPinkSerial)
    {
        m_nPinkCount++;
        return PINK_DIRTY_PIXEL;
    }
    else //means green serial
    {
        m_nBlueCount++;
        return BLUE_DIRTY_PIXEL;
    }
}

- (void) calculateDirtyValue
{
    _dirtyValue = (m_nBlueCount + m_nPinkCount * 0.5f) / (float)(m_imageWidth * m_imageHeight) * MAX_DIRTY_VALUE;
    
    // get local value
    int localRegionCount = 0;
    float localSumValue = 0.0f;
    int pixelStep = PIXEL_STEP;
    for (int y = 0; y < m_imageHeight; y += pixelStep)
    {
        for(int x = 0; x < m_imageWidth; x+= pixelStep)
        {
            int endX = MIN(m_imageWidth, x + pixelStep);
            int endY = MIN(m_imageHeight, y + pixelStep);
            
            int nPixelCount = 0;
            float sValue = 0.0f;
            for (int yy = y; yy < endY; yy++)
            {
                for (int xx = x; xx < endX; xx++)
                {
                    int index = yy * m_imageWidth + xx;
                    if (m_pOutBuffer[index] == PINK_DIRTY_PIXEL)
                        sValue += 0.5f;
                    else if (m_pOutBuffer[index] == BLUE_DIRTY_PIXEL)
                        sValue += 1.0f;
                    nPixelCount++;
                }
            }
          
            if (sValue > 0.0f)
            {
                localRegionCount++;
                localSumValue += sValue / (float)nPixelCount;
            }
        }
    }
    _localDirtyValue = localSumValue / (float)localRegionCount * MAX_DIRTY_VALUE;
    float kLocalAreaPercent = localRegionCount * PIXEL_STEP * PIXEL_STEP / (float)(m_imageWidth * m_imageHeight);
    if (kLocalAreaPercent < MIN_LOCAL_AREA_PERCENT)
        _localDirtyValue = 0.0f;
}

- (UIImage *) exportImage
{
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = CGBitmapContextCreate(m_pOutBuffer, m_imageWidth, m_imageHeight, 8, m_imageWidth * 4, colorSpace, kCGBitmapByteOrder32Little | kCGImageAlphaNoneSkipLast);
    CGImageRef image = CGBitmapContextCreateImage(context);
    CGContextRelease(context);
    CGColorSpaceRelease(colorSpace);
    
    UIImage *resultUIImage = [UIImage imageWithCGImage:image];
    CGImageRelease(image);
    
    return resultUIImage;
}

@end
