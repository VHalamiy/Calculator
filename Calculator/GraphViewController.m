//
//  GraphViewController.m
//  Calculator
//
//  Created by Volodymyr Halamiy on 10/14/15.
//  Copyright (c) 2015 Volodymyr Halamiy. All rights reserved.
//

#import "GraphViewController.h"
#import "VHSimpleCalculator.h"

#define ACCURACY_SAMPLE 100
#define RANGE_SAMPLE 1
#define X_VAL @"X_VAL"
#define Y_VAL @"Y_VAL"

@interface GraphViewController ()

@property(strong, nonatomic) VHSimpleCalculator *simpleCalculator;

@end

@implementation GraphViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.simpleCalculator = [VHSimpleCalculator sharedInstance];
    [self generateDataSample];
    //CPTMutableLineStyle.
    CGFloat xAxisStart = -fabs(self.simpleCalculator.currentNumber) - RANGE_SAMPLE;
    CGFloat xAxisLength = fabs(self.simpleCalculator.currentNumber) - xAxisStart + RANGE_SAMPLE;
    CGFloat yAxisStart = -fabs(self.simpleCalculator.currentNumber) - RANGE_SAMPLE;
    CGFloat yAxisLength = fabs(self.simpleCalculator.currentNumber) - yAxisStart + RANGE_SAMPLE;
    
    CPTGraphHostingView *hostingView = [[CPTGraphHostingView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:hostingView];
    self.graph = [[CPTXYGraph alloc] initWithFrame:hostingView.bounds];
    hostingView.hostedGraph = self.graph;
    
    CPTXYPlotSpace *plotSpace = (CPTXYPlotSpace *)self.graph.defaultPlotSpace;
    plotSpace.xRange = [CPTPlotRange plotRangeWithLocation:CPTDecimalFromDouble(xAxisStart)
                                                    length:CPTDecimalFromDouble(xAxisLength)];
    plotSpace.yRange = [CPTPlotRange plotRangeWithLocation:CPTDecimalFromDouble(yAxisStart)
                                                    length:CPTDecimalFromDouble(yAxisLength)];
    
    CPTScatterPlot *dataSourceLinePlot = [CPTScatterPlot new];
    dataSourceLinePlot.dataSource = self;
    
    [self.graph addPlot:dataSourceLinePlot];
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)generateDataSample {
    double x = 0, y = 0;
    CGFloat length = 2 * (fabs(self.simpleCalculator.currentNumber) + RANGE_SAMPLE);
    CGFloat delta = length / (ACCURACY_SAMPLE - 1);
    self.sample = [[NSMutableArray alloc] initWithCapacity:ACCURACY_SAMPLE];
    for (int i = 0; i < ACCURACY_SAMPLE; i++) {
        x = -fabs(self.simpleCalculator.currentNumber) - RANGE_SAMPLE + (delta * i);
        switch (self.simpleCalculator.calculationMethod) {
            case noneOperation:
                y = self.simpleCalculator.currentNumber;
                break;
            case exponentiationOperation:
                y = pow(x, self.simpleCalculator.currentNumber);
                break;
            case logarithmOperation:
                y = log(x) / log(self.simpleCalculator.currentNumber);
                break;
            case changeSignOperation:
                y = self.simpleCalculator.currentNumber;
                break;
            case sinOperation:
                y = sin(x);
                break;
            case cosOperation:
                y = cos(x);
                break;
            case tanOperation:
                y = tan(x);
                break;
            case squareRootOperation:
                y = sqrt(x);
                break;
            case squareOperation:
                y = pow(x, 2.f);
                break;
            case eulerExponentiationOperation:
                y = exp(x);
                break;
            case reciprocalOperation:
                y = 1 / x;
                break;
            case remainderOperation:
                y = self.simpleCalculator.currentNumber;
                break;
            case naturalLogarithmOperation:
                y = log(x);
                break;
            case binaryLogarithmOperation:
                y = log2(x);
                break;
            default:
                y = self.simpleCalculator.resultNumber;
                break;
        }
        NSDictionary *couple = [NSDictionary dictionaryWithObjectsAndKeys:
                                [NSNumber numberWithDouble:x], X_VAL,
                                [NSNumber numberWithDouble:y], Y_VAL,
                                nil];
        [self.sample addObject:couple];
    }
}

- (NSUInteger)numberOfRecordsForPlot:(CPTPlot *)plot {
    return ACCURACY_SAMPLE;
}

- (id)numberForPlot:(CPTPlot *)plot field:(NSUInteger)fieldEnum recordIndex:(NSUInteger)idx {
    NSDictionary *couple = [self.sample objectAtIndex:idx];
    if (fieldEnum == CPTScatterPlotFieldX) {
        return [couple valueForKey:X_VAL];
    }
    else return [couple valueForKey:Y_VAL];
}

//- (IBAction)backToView:(id)sender {
//
//}

@end
