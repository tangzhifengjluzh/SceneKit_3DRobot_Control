//
//  MyNode.m
//  demoPerson
//
//  Created by xia luzheng on 2019/12/31.
//  Copyright © 2019 xia luzheng. All rights reserved.
//

#import "MyNode.h"
#define kAnglePoint  0.1
@implementation MyNode
+ (NSMutableArray *)getNodesInfo
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"node" ofType:@"plist"];
    NSArray *array = [NSArray arrayWithContentsOfFile:path];
    NSMutableArray *arr = [NSMutableArray array];
    for (int i = 0; i < array.count; i++) {
        MyNode *node = [MyNode new];
        [node setValuesForKeysWithDictionary:array[i]] ;
        [arr addObject:node];
    }
    return arr;
}

- (void)runcurP:(CGPoint)curP preP:(CGPoint)preP
{
    if (self.axisHorizontal) {
        if (curP.x > preP.x) {
            self.currentAngle = self.currentAngle + kAnglePoint;
        }else if (curP.x < preP.x){
            self.currentAngle = self.currentAngle - kAnglePoint;
        }
        NSLog(@"%@ x",self.node.name);
    }else{
        NSLog(@"%@ y",self.node.name);
        if (self.left) {
            if (curP.y < preP.y) {
                self.currentAngle = self.currentAngle - kAnglePoint;
            }else if (curP.y > preP.y){
                self.currentAngle = self.currentAngle + kAnglePoint;
            }
        }else{
            if (curP.y < preP.y) {
                self.currentAngle = self.currentAngle + kAnglePoint;
            }else if (curP.y > preP.y){
                self.currentAngle = self.currentAngle - kAnglePoint;
            }
        }
    }
    if (self.currentAngle > self.maxAngle) {
        self.currentAngle = self.maxAngle;
    }
    if (self.currentAngle < self.minAngle) {
        self.currentAngle = self.minAngle;
    }
    NSLog(@"currentAngle = %f",self.currentAngle);
    [self runAction:self.currentAngle changeDelegate:YES];
}

- (void)runAction:(float)angle changeDelegate:(BOOL)flag
{
    if (self.Tox) {
        [self.node runAction:[SCNAction rotateToX:angle y:0 z:0 duration:0]];
    }else if (self.Toy){
        [self.node runAction:[SCNAction rotateToX:0 y:angle z:0 duration:0]];
    }else{
        [self.node runAction:[SCNAction rotateToX:0 y:0 z:angle duration:0]];
    }
    if (flag && [self.delegate respondsToSelector:@selector(changeWith:Angle:)]) {
        [self.delegate changeWith:self Angle:angle];
    }
}
- (void)reSet
{
    NSLog(@"reSet %f",self.stantandAngle);
    if (self.Tox) {
        [self.node runAction:[SCNAction rotateToX:self.stantandAngle y:0 z:0 duration:0]];
    }else if (self.Toy){
        [self.node runAction:[SCNAction rotateToX:0 y:self.stantandAngle z:0 duration:0]];
    }else{
        [self.node runAction:[SCNAction rotateToX:0 y:0 z:self.stantandAngle duration:0]];
    }
    self.currentAngle = self.stantandAngle;
}
@end
