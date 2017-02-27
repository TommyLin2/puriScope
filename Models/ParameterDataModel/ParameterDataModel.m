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

-(void)setValueWithNameKey:(NSString *)nameKey withValueKey:(NSString *)valueKey
{
    self.nameKey = nameKey;
    self.valueKey = valueKey;
    self.objectName = [[NSUserDefaults standardUserDefaults] stringForKey:nameKey];
    self.objectValue = [[[NSUserDefaults standardUserDefaults] stringForKey:valueKey] floatValue];
}

- (void)saveWithObjectNameWithValue:(NSString *)objectName
                   withObjectValue:(float)objectValue
                       withNameKey:(NSString *)nameKey
                      withvalueKey:(NSString *)valueKey{
    self.objectName = objectName;
    self.objectValue = objectValue;
    self.nameKey = nameKey;
    self.valueKey = valueKey;
    [[NSUserDefaults standardUserDefaults] setValue:self.objectName forKey:nameKey];
    [[NSUserDefaults standardUserDefaults] setValue:[NSString stringWithFormat:@"%f",self.objectValue] forKey:valueKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (NSString *)getObjectName{
    return self.objectName;
}

- (float)getObjectValue{
    return self.objectValue;
}

@end
