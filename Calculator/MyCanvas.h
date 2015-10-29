//
//  MyCanvas.h
//  graphTest
//
//  Created by Alexey Pelekh on 10/11/15.
//  Copyright (c) 2015 Alexey Pelekh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyCanvas : UIView

@property (nonatomic, copy) NSString *neededGraph;

- (void)setNeededGraph:(NSString *)neededGraph;

@end
