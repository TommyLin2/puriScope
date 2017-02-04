//
//  ParameterDataModel.m
//  puriSCOPE
//
//  Created by Jordi on 04/02/17.
//
//

#import "ParameterDataModel.h"


@implementation ParameterDataModel
-(id)init{
    if((self=[super init])){
        
    }
    return self;
}

-(id)initWithObjectNameWithValue:(NSString *)objectName withObjectValue:(float)objectValue
{
    self = [super init];
    if (self) {
        self.objectName = objectName;
        self.objectValue = objectValue;
    }
    return self;
}

- (void)storeParmeters{
    [[NSUserDefaults standardUserDefaults] setValue:self.objectName forKey:OBJECT_NAME];
    [[NSUserDefaults standardUserDefaults] setValue:[NSString stringWithFormat:@"%f",self.objectValue] forKey:OBJECT_VALUE];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)setParmetersFromKey{
    self.objectName = [[NSUserDefaults standardUserDefaults] stringForKey:OBJECT_NAME];
    self.objectValue = [[[NSUserDefaults standardUserDefaults] stringForKey:OBJECT_VALUE] floatValue];
}

- (void)setWithObjectNameWithValue:(NSString *)objectName withObjectValue:(float)objectValue{
    self.objectName = objectName;
    self.objectValue = objectValue;
}

- (NSString *)getObjectName{
    return self.objectName;
}

- (float)getObjectValue{
    return self.objectValue;
}

@end
