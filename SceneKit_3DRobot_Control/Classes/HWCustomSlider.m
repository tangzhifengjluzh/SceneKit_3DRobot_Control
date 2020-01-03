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

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self addTarget:self action:@selector(sliderChange:) forControlEvents:UIControlEventValueChanged];
//        [self addTarget:self action:@selector(sliderCancel:) forControlEvents:UIControlEventTouchUpInside];
//        [self addTarget:self action:@selector(sliderCancel:) forControlEvents:UIControlEventTouchDragExit];
//        [self addTarget:self action:@selector(sliderCancel:) forControlEvents:UIControlEventTouchDragOutside];
        self.minimumTrackTintColor = [UIColor whiteColor];// kLobotBitNavColor;
        self.maximumTrackTintColor = [UIColor whiteColor];
        self.minimumValue = 0;
        self.maximumValue = 1000;
        //    self.sliderCenter.thumbTintColor = kLobotBitNavColor;
//        self.continuous = NO;
//        [self setThumbImage:kGetImage(@"thumb_pressed2") forState:UIControlStateNormal];
//        self.rippleTimer = [NSTimer timerWithTimeInterval:0.7 target:self selector:@selector(canChange) userInfo:nil repeats:YES];
//        [[NSRunLoop currentRunLoop] addTimer:_rippleTimer forMode:NSRunLoopCommonModes];
    }
    return self;
}
- (void)canChange
{
    
}
- (void)sliderChange:(HWCustomSlider*)slider
{
    //    slider.continuous = NO;
    //    if (slider.value < 0.5 && self.currentValue > 0) {
    //        self.currentValue = self.currentValue - valueMagin;
    //    }else if (slider.value > 0.5 && self.currentValue < 180) {
    //        self.currentValue = self.currentValue + valueMagin;
    //
    //    }
    if (self.block) {
        self.block(slider.value);
    }
//    if (slider.value == 0 || slider.value == 1) {
//        [slider setValue:0.5 animated:YES];
//    }

    //    self.lableCenter.text = [NSString stringWithFormat:@"%ld",self.currentValue];
}


- (BOOL)beginTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event{
    //    BOOL begin = [super beginTrackingWithTouch:touch withEvent:event];
    //    if (!begin){
    //        return false;
    //    }
    
    //    if (self.sliderStart) {
    //        self.sliderStart(self);
    //    }
    //
    //    [self setUpType:ThumbViewTypeHightlight];
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
    //    if (self.sliderEnd) {
    //        self.sliderEnd(self);
    //    }
    //
    //    [self setUpType:ThumbViewTypeNormal];
    [super endTrackingWithTouch:touch withEvent:event];
//    [self setValue:0.5 animated:YES];
    
}

- (void)sliderCancel:(HWCustomSlider*)slider
{
//    NSLog(@"cancel");
//    NSLog(@"%f",slider.value);
//    [slider setValue:0.5 animated:NO];
//    NSLog(@"%f",slider.value);
    
    //    self.lableCenter.text = [NSString stringWithFormat:@"%ld",self.currentValue];
}

//- (CGRect)trackRectForBounds:(CGRect)bounds
//{
//    return CGRectMake(0, (bounds.size.height - 12) / 2.0, bounds.size.width, 12);
//}

@end
