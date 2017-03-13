//
//  ParameterDataModel.h
//  puriSCOPE
//
//  Created by Jordi on 04/02/17.
//
//

#import <Foundation/Foundation.h>

#define FIRST_OBJECT_NAME @"object_name"
#define FIRST_OBJECT_VALUE @"object_value"

#define SECOND_OBJECT_NAME @"second_object_name"
#define SECOND_OBJECT_VALUE @"second_object_value"


@interface ParameterDataModel : NSObject
@property (nonatomic, retain) NSString	*nameKey;
@property (nonatomic, retain) NSString	*valueKey;

@property (nonatomic, retain) NSString	*objectName;
@property (nonatomic, assign) float objectValue;

- (void)saveWithObjectNameWithValue:(NSString *)objectName
                    withObjectValue:(float)objectValue
                        withNameKey:(NSString *)nameKey
                       withvalueKey:(NSString *)valueKey;
-(void)setValueWithNameKey:(NSString *)nameKey withValueKey:(NSString *)valueKey;


@end
