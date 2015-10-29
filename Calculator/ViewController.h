//
//  ViewController.h
//  Calculator
//
//  Created by Volodymyr Halamiy on 10/8/15.
//  Copyright (c) 2015 Volodymyr Halamiy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *resultLabel;
@property (weak, nonatomic) IBOutlet UILabel *memoryLabel;

- (IBAction)numberButtonPressed:(UIButton *)sender;
- (IBAction)unaryArithmeticButtonPressed:(UIButton *)sender;
- (IBAction)binaryArithmeticButtonPressed:(UIButton *)sender;
- (IBAction)memoryButtonPressed:(UIButton *)sender;
- (IBAction)clearButtonPressed:(id)sender;
- (IBAction)dotButtonPressed:(id)sender;
- (IBAction)resultButtonPressed:(id)sender;
- (IBAction)clearMemoryButtonPressed:(id)sender;

@end

