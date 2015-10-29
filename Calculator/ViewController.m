//
//  ViewController.m
//  Calculator
//
//  Created by Volodymyr Halamiy on 10/8/15.
//  Copyright (c) 2015 Volodymyr Halamiy. All rights reserved.
//

#import "ViewController.h"
#import "VHSimpleCalculator.h"

@interface ViewController ()

@property(strong, nonatomic) VHSimpleCalculator *simpleCalculator;
@property(assign, nonatomic) BOOL resultPressed;
@property(assign, nonatomic) BOOL unaryPressed;
@property(assign, nonatomic) BOOL binaryPressed;
@property(strong, nonatomic) NSString *resultCalculation;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.simpleCalculator = [VHSimpleCalculator sharedInstance];
    [self refreshResultLabel];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)clearCalculation {
    self.simpleCalculator.currentNumber = 0;
    self.simpleCalculator.resultNumber = 0;
    self.simpleCalculator.memoryNumber = 0;
    self.simpleCalculator.calculationMethod = 0;
    self.simpleCalculator.memoryMethod = 0;
    self.simpleCalculator.dotEnabled = NO;
    self.resultPressed = NO;
    self.binaryPressed = NO;
    self.unaryPressed = NO;
    self.resultCalculation = nil;
}

- (void)refreshResultLabel {
    self.resultLabel.text = [NSString stringWithFormat:@"%.10G", self.simpleCalculator.currentNumber];
}

- (void)showResult {
    self.resultLabel.text = [NSString stringWithFormat:@"%.10G", self.simpleCalculator.resultNumber];
}

-(void)showAlert:(NSString *)alertMessage {
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Error"
                                                                   message:alertMessage
                                                            preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK"
                                                            style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * action) {}];
    
    [alert addAction:defaultAction];
    self.simpleCalculator.resultNumber = 0;
    self.simpleCalculator.calculationMethod = 0;
    [self presentViewController:alert animated:YES completion:nil];
}

- (IBAction)clearButtonPressed:(id)sender {
    [self clearCalculation];
    [self refreshResultLabel];
}

- (IBAction)numberButtonPressed:(UIButton *)sender {
    if (self.resultPressed) {
        self.simpleCalculator.currentNumber = 0;
        self.simpleCalculator.calculationMethod = 0;
    }
    if (self.binaryPressed || self.unaryPressed) {
        self.simpleCalculator.currentNumber = 0;
    }
    [self.simpleCalculator saveCurrentNumber:sender.tag];
    self.resultPressed = NO;
    self.unaryPressed = NO;
    self.binaryPressed = NO;
    [self refreshResultLabel];
}

- (IBAction)unaryArithmeticButtonPressed:(UIButton *)sender {
    NSInteger previousCalculationMethodPressed = self.simpleCalculator.calculationMethod;
    if (self.resultPressed) {
        self.simpleCalculator.currentNumber = self.simpleCalculator.resultNumber;
    }
    self.simpleCalculator.calculationMethod = sender.tag;
    self.resultCalculation = [self.simpleCalculator calculate];
    if (self.resultCalculation) {
        [self showAlert:self.resultCalculation];
    }
    //else self.simpleCalculator.calculationMethod = previousCalculationMethodPressed; //critical logic for build graph
    self.simpleCalculator.dotEnabled = NO;
    self.resultPressed = NO;
    self.unaryPressed = YES;
    [self refreshResultLabel];
}

- (IBAction)binaryArithmeticButtonPressed:(UIButton *)sender {
    if (!self.resultPressed) {
        self.resultCalculation = [self.simpleCalculator calculate];
        if (self.resultCalculation) {
            [self showAlert:self.resultCalculation];
            self.simpleCalculator.currentNumber = 0;
        }
        [self showResult];
    }
    else if (self.binaryPressed && !self.resultPressed) {
        self.simpleCalculator.resultNumber = self.simpleCalculator.currentNumber;
    }
    self.simpleCalculator.calculationMethod = sender.tag;
    self.simpleCalculator.dotEnabled = NO;
    self.resultPressed = NO;
    self.binaryPressed = YES;
}

- (IBAction)memoryButtonPressed:(UIButton *)sender {
    [self.memoryLabel setHidden:NO];
    self.simpleCalculator.memoryMethod = sender.tag;
    [self.simpleCalculator executeMemoryMethod];
    self.simpleCalculator.dotEnabled = NO;
    self.unaryPressed = YES;
    [self refreshResultLabel];
}

- (IBAction)dotButtonPressed:(id)sender {
    if (self.binaryPressed || self.unaryPressed) {
        [self.simpleCalculator saveCurrentNumber:-1];
    }
    self.simpleCalculator.dotEnabled = YES;
}

- (IBAction)resultButtonPressed:(id)sender {
    self.resultCalculation = [self.simpleCalculator calculate];
    if (self.resultCalculation) {
        [self showAlert:self.resultCalculation];
        self.simpleCalculator.currentNumber = 0;
    }
    self.simpleCalculator.dotEnabled = NO;
    self.resultPressed = YES;
    self.binaryPressed = NO;
    [self showResult];
}

- (IBAction)clearMemoryButtonPressed:(id)sender {
 //   self.simpleCalculator.memoryNumber = 0;
    [self.memoryLabel setHidden:YES];
}

@end
