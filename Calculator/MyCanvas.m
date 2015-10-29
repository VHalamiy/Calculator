//
//  MyCanvas.m
//  graphTest
//
//  Created by Alexey Pelekh on 10/11/15.
//  Copyright (c) 2015 Alexey Pelekh. All rights reserved.
//

#import "MyCanvas.h"

@implementation MyCanvas

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextClearRect(context, rect);
    
    NSInteger y = 0;
    for(int x=rect.origin.x; x < rect.size.width; x++)
    {
        if ([self.neededGraph isEqualToString:@"sin"])
        {
        y = ((rect.size.height/15) * sin(x * M_PI/180) + rect.size.height / 2 );
            CGContextSetStrokeColorWithColor(context, [UIColor redColor].CGColor);
        }
        else if ([self.neededGraph isEqualToString:@"cos"])
        {
            y = ((rect.size.height/15) * cos(x * M_PI/180) + rect.size.height / 2 );
            CGContextSetStrokeColorWithColor(context, [UIColor greenColor].CGColor);
        }
        else if ([self.neededGraph isEqualToString:@"tan"])
        {
            y = ((rect.size.height/15) * tan(x * M_PI/180) + rect.size.height / 2 );
            CGContextSetStrokeColorWithColor(context, [UIColor blueColor].CGColor);
        }
        else if ([self.neededGraph isEqualToString:@"ctg"])
        {
            y = ((rect.size.height/15) * (1/tan(x * M_PI/180)) + rect.size.height / 2 );
            CGContextSetStrokeColorWithColor(context, [UIColor magentaColor].CGColor);
        }

        if (x == 0) CGContextMoveToPoint(context, x, y);
        else CGContextAddLineToPoint(context, x, y);
    }
    
    CGContextStrokePath(context);
}

@end
