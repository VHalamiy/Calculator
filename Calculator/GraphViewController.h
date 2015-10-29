//
//  GraphViewController.h
//  Calculator
//
//  Created by Volodymyr Halamiy on 10/14/15.
//  Copyright (c) 2015 Volodymyr Halamiy. All rights reserved.
//

#import "ViewController.h"
#import "CorePlot-CocoaTouch.h"

@interface GraphViewController : ViewController <CPTPlotDataSource>

@property(strong, nonatomic) CPTXYGraph *graph;
@property(strong, nonatomic) NSMutableArray *sample;

//- (IBAction)backToView:(id)sender;

@end
