//
//  VHSimpleCalculator.h
//  Calculator
//
//  Created by Volodymyr Halamiy on 10/8/15.
//  Copyright (c) 2015 Volodymyr Halamiy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UIKit/UIKit.h"

typedef NS_ENUM (NSInteger, calculationOperation) {
    noneOperation = 0,
    changeSignOperation = 1001,
    sinOperation = 1002,
    cosOperation = 1003,
    tanOperation = 1004,
    squareRootOperation = 1005,
    squareOperation = 1006,
    eulerExponentiationOperation = 1007,
    reciprocalOperation = 1008,
    remainderOperation = 1009,
    naturalLogarithmOperation = 1010,
    binaryLogarithmOperation = 1011,
    additionOperation = 2001,
    subtractionOperation = 2002,
    multiplicationOperation = 2003,
    divisionOperation = 2004,
    exponentiationOperation = 2005,
    logarithmOperation = 2006
};

typedef NS_ENUM (NSInteger, memoryOperation) {
    addMemoryOperation = 201,
    subMemoryOperation = 202,
    recallMemoryOperation = 203
};

static CGFloat dotCoefficient = 1.f;

@interface VHSimpleCalculator : NSObject

@property(assign, nonatomic) CGFloat currentNumber;
@property(assign, nonatomic) CGFloat resultNumber;
@property(assign, nonatomic) CGFloat memoryNumber;
@property(assign, nonatomic) calculationOperation calculationMethod;
@property(assign, nonatomic) memoryOperation memoryMethod;
@property(assign, nonatomic) BOOL dotEnabled;

- (void)saveCurrentNumber:(CGFloat)currentNumber;
- (void)executeMemoryMethod;
- (NSString *)calculate;
+ (VHSimpleCalculator *)sharedInstance;

@end
