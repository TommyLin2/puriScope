//
//  ParameterDataModel.h
//  puriSCOPE
//
//  Created by Jordi on 04/02/17.
//
//

#import <Foundation/Foundation.h>

#define OBJECT_NAME @"object_name"
#define OBJECT_VALUE @"object_value"

@interface ParameterDataModel : NSObject

@property (nonatomic, retain) NSString	*objectName;
@property (nonatomic, assign) float objectValue;

- (void)storeParmeters;
- (void)setParmetersFromKey;
- (NSString *)getObjectName;
- (float)getObjectValue;
- (void)setWithObjectNameWithValue:(NSString *)objectName withObjectValue:(float)objectValue;

@end
