//
//  VHSimpleCalculator.m
//  Calculator
//
//  Created by Volodymyr Halamiy on 10/8/15.
//  Copyright (c) 2015 Volodymyr Halamiy. All rights reserved.
//

#import "VHSimpleCalculator.h"
#import "math.h"

@implementation VHSimpleCalculator

+ (VHSimpleCalculator *)sharedInstance
{
        static VHSimpleCalculator *myInstance = nil;
        if (nil == myInstance) {
            myInstance  = [[self class] new];
            myInstance.currentNumber = 0;
            myInstance.resultNumber = 0;
            myInstance.memoryNumber = 0;
            myInstance.calculationMethod = 0;
            myInstance.memoryMethod = 0;
            myInstance.dotEnabled = NO;
        }
        return myInstance;
    
//    static dispatch_once_t once;
//    static VHSimpleCalculator *sharedInstance = nil;
//    
//    dispatch_once(&once, ^
//                  {
//                      sharedInstance = [[VHSimpleCalculator alloc] init];
//                      
//                      sharedInstance.currentNumber = 0;
//                      sharedInstance.resultNumber = 0;
//                      sharedInstance.memoryNumber = 0;
//                      sharedInstance.calculationMethod = 0;
//                      sharedInstance.memoryMethod = 0;
//                      sharedInstance.dotEnabled = NO;
//                  });
//    
//    
//    
//    return sharedInstance;
}

- (void)saveCurrentNumber:(CGFloat)currentNumber {
    if (currentNumber == -1) {
        dotCoefficient = 1;
        self.dotEnabled = NO;
        self.currentNumber = 0;
    }
    else if (self.dotEnabled) {
        dotCoefficient /= 10;
        self.currentNumber += (currentNumber * dotCoefficient);
    }
    else {
        dotCoefficient = 1;
        self.currentNumber *= 10;
        self.currentNumber += currentNumber;
    }
}

- (void)executeMemoryMethod {
    switch (self.memoryMethod) {
        case addMemoryOperation:
            self.memoryNumber += self.currentNumber;
            break;
        case subMemoryOperation:
            self.memoryNumber -= self.currentNumber;
            break;
        case recallMemoryOperation:
            self.currentNumber = self.memoryNumber;
            break;
        default:
            break;
    }
}

- (NSString *)calculate {
    switch (self.calculationMethod) {
        case noneOperation:
            self.resultNumber = self.currentNumber;
            break;
        case additionOperation:
            self.resultNumber += self.currentNumber;
            break;
        case subtractionOperation:
            self.resultNumber -= self.currentNumber;
            break;
        case multiplicationOperation:
            self.resultNumber *= self.currentNumber;
            break;
        case divisionOperation:
            if (self.currentNumber == 0) {
                return @"Can't divide by zero, mate.";
            }
            self.resultNumber /= self.currentNumber;
            break;
        case exponentiationOperation:
            if (self.resultNumber < 0 && self.currentNumber > 0 && self.currentNumber <1) {
                return @"Base of an exponentiation operation can't be negative, if exponent value between 0 and 1.";
            }
            self.resultNumber = pow(self.resultNumber, self.currentNumber);
            break;
        case logarithmOperation:
            if (self.resultNumber <= 0) {
                return @"Argument of the logarithm can't be negative or equal 0.";
            }
            if (self.currentNumber <= 0 || self.currentNumber == 1) {
                return @"Base of the logarithm can't be negative, equal 0 or 1.";
            }
            self.resultNumber = log(self.resultNumber) / log(self.currentNumber);
            break;
        case changeSignOperation:
            self.currentNumber /= -1;
            break;
        case sinOperation:
            if (fmod(self.currentNumber, 180.f) == 0) {
                self.currentNumber = 0;
            }
            else self.currentNumber = sin(self.currentNumber * M_PI / 180);
            break;
        case cosOperation:
            if (fmod(self.currentNumber - 90, 180.f) == 0) {
                self.currentNumber = 0;
            }
            else self.currentNumber = cos(self.currentNumber * M_PI / 180);
            break;
        case tanOperation:
            if (fmod(self.currentNumber - 90, 180.f) == 0) {
                return @"Result value too great, mate.";
            }
            if (fmod(self.currentNumber, 180.f) == 0) {
                self.currentNumber = 0;
            }
            else self.currentNumber = tan(self.currentNumber * M_PI / 180);
            break;
        case squareRootOperation:
            if (self.currentNumber < 0) {
                return @"Argument of the square root can't be negative, mate.";
            }
            self.currentNumber = sqrt(self.currentNumber);
            break;
        case squareOperation:
            self.currentNumber = pow(self.currentNumber, 2.f);
            break;
        case eulerExponentiationOperation:
            self.currentNumber = exp(self.currentNumber);
            break;
        case reciprocalOperation:
            if (self.currentNumber == 0) {
                return @"Can't divide by zero, mate.";
            }
            self.currentNumber = 1 / self.currentNumber;
            break;
        case remainderOperation:
            self.currentNumber /= 100;
            break;
        case naturalLogarithmOperation:
            if (self.currentNumber <= 0) {
                return @"Argument of the logarithm can't be negative or equal 0, mate.";
            }
            self.currentNumber = log(self.currentNumber);
            break;
        case binaryLogarithmOperation:
            if (self.currentNumber <= 0) {
                return @"Argument of the logarithm can't be negative or equal 0, mate.";
            }
            self.currentNumber = log2(self.currentNumber);
            break;
        default:
            break;
    }
    return nil;
}

@end
