//
//  MyNode.h
//  demoPerson
//
//  Created by xia luzheng on 2019/12/31.
//  Copyright © 2019 xia luzheng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SceneKit/SceneKit.h>

NS_ASSUME_NONNULL_BEGIN
@class MyNode;
@protocol NodeDelegate <NSObject>

- (void)changeWith:(MyNode *)myNode Angle:(float)angle;

@end
@interface MyNode : NSObject
@property (nonatomic, strong) SCNNode               *node;//节点
@property (nonatomic, assign) BOOL                  left;//是否左边的节点
@property (nonatomic, assign) float               minAngle;//最小转动角度
@property (nonatomic, assign) float               maxAngle;//最大转动角度
@property (nonatomic, assign) float               currentAngle;//当前角度
@property (nonatomic, assign) BOOL               Tox;//绕着x轴转动
@property (nonatomic, assign) BOOL               Toy;//绕着y轴转动
@property (nonatomic, assign) BOOL               Toz;//绕着z轴转动
@property (nonatomic, assign) BOOL               axisHorizontal;//水平滑动变换角度
@property (nonatomic, assign) float               stantandAngle;//标准角度，初始化角度

@property (nonatomic, assign) float               tx;//暂时无用
@property (nonatomic, assign) float               ty;//暂时无用
@property (nonatomic, assign) float               tz;//暂时无用


@property (nonatomic, weak) id<NodeDelegate>               delegate;
+ (NSMutableArray *)getNodesInfo;//获取位置及角度等其他信息
- (void)runcurP:(CGPoint)curP preP:(CGPoint)preP;//根据滑动前后的点来给节点做动作 做角度旋转
- (void)reSet;//立正
- (void)runAction:(float)angle changeDelegate:(BOOL)flag;
@end

NS_ASSUME_NONNULL_END
