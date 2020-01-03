//
//  HWCustomSlider.h
//  LobotBit
//
//  Created by LOBOT on 2019/4/18.
//  Copyright © 2019年 LOBOT. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HWCustomSlider : UISlider
typedef void(^HWUhandBitSliderBlock)(float value);
@property (nonatomic, copy)HWUhandBitSliderBlock block ;
@end

NS_ASSUME_NONNULL_END
