//
//  HWCustomSlider.m
//  LobotBit
//
//  Created by LOBOT on 2019/4/18.
//  Copyright © 2019年 LOBOT. All rights reserved.
//

#import "HWCustomSlider.h"
@interface HWCustomSlider()
@property (nonatomic, strong) NSTimer *rippleTimer;
@property (nonatomic, assign) BOOL  canChangeValue;
@end
@implementation HWCustomSlider


- (instancetype)init
{
    self = [super init];
    if (self) {
        [self addTarget:self action:@selector(sliderChange:) forControlEvents:UIControlEventValueChanged];

        self.minimumTrackTintColor = [UIColor whiteColor];// kLobotBitNavColor;
        self.maximumTrackTintColor = [UIColor whiteColor];
        self.minimumValue = 0;
        self.maximumValue = 1000;

    }
    return self;
}
- (void)canChange
{
    
}
- (void)sliderChange:(HWCustomSlider*)slider
{

    if (self.block) {
        self.block(slider.value);
    }

}


- (BOOL)beginTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event{

    [super beginTrackingWithTouch:touch withEvent:event];
    return true;
}

- (BOOL)continueTrackingWithTouch:(UITouch *)touch withEvent:(nullable UIEvent *)event
{
    if (self.block) {
        self.block(self.value);
    }
    return [super continueTrackingWithTouch:touch withEvent:event];
}
- (void)endTrackingWithTouch:(nullable UITouch *)touch withEvent:(nullable UIEvent *)event{

    //
    [super endTrackingWithTouch:touch withEvent:event];
    
}

- (void)sliderCancel:(HWCustomSlider*)slider
{

}

//- (CGRect)trackRectForBounds:(CGRect)bounds
//{
//    return CGRectMake(0, (bounds.size.height - 12) / 2.0, bounds.size.width, 12);
//}

@end
