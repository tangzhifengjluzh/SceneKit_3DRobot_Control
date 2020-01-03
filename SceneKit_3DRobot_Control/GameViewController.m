//
//  GameViewController.m
//  game3
//
//  Created by xia luzheng on 2019/12/27.
//  Copyright © 2019 xia luzheng. All rights reserved.
//

#import "GameViewController.h"
#import "MyNode.h"
#import "HWCustomSlider.h"
#define kSCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define kSCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
@interface GameViewController ()<SCNNodeRendererDelegate,NodeDelegate>
{
    SCNView * scnView;
    SCNIKConstraint * ikConstraint;
    UISwipeGestureRecognizer * recognizer;
    
    
}
@property (nonatomic, strong)  SCNNode *mynode;               ;
@property (nonatomic ,assign)CGFloat screenRadius;
@property (nonatomic, strong) NSMutableArray               *nodes;
@property (nonatomic, strong) HWCustomSlider               *slider;
@property (nonatomic, strong) UILabel               *labelAngle;

@end
@implementation GameViewController

- (CGFloat)screenRadius{
    if (_screenRadius == 0) {
        _screenRadius = sqrt ((kSCREEN_HEIGHT*kSCREEN_HEIGHT + kSCREEN_WIDTH*kSCREEN_WIDTH));
    }
    return _screenRadius;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    

    // create a new scene
    SCNScene *scene = [SCNScene sceneNamed:@"art.scnassets/1(3).dae"];
    
    // create and add a camera to the scene
    SCNNode *cameraNode = [SCNNode node];
    cameraNode.camera = [SCNCamera camera];
    [scene.rootNode addChildNode:cameraNode];
    
    // place the camera
    cameraNode.position = SCNVector3Make(0, 0, 550);
    //    cameraNode.position = SCNVector3Make(0, 3, 15);
    UIButton *b;
    b.contentMode = 0;
    cameraNode.camera.automaticallyAdjustsZRange = true;
    
    // create and add a light to the scene
    SCNNode *lightNode = [SCNNode node];
    lightNode.light = [SCNLight light];
    lightNode.light.type = SCNLightTypeOmni;
    lightNode.position = SCNVector3Make(0, 10, 10);
    [scene.rootNode addChildNode:lightNode];
    
    // create and add an ambient light to the scene
    SCNNode *ambientLightNode = [SCNNode node];
    ambientLightNode.light = [SCNLight light];
    ambientLightNode.light.type = SCNLightTypeAmbient;
    ambientLightNode.light.color = [UIColor darkGrayColor];
    [scene.rootNode addChildNode:ambientLightNode];
    
    
    // retrieve the ship node
    SCNNode *ship = [scene.rootNode childNodeWithName:@"ship1" recursively:YES];
    
    // animate the 3d object
    //    [ship runAction:[SCNAction repeatAction:[SCNAction rotateByX:0 y:-1 z:0 duration:1] count:1]];
    
    // retrieve the SCNView
    scnView = (SCNView *)self.view;
    //    scnView = [[SCNView alloc] initWithFrame:self.view.bounds];
    //    [self.view addSubview:scnView];
    
    // set the scene to the view
    scnView.scene = scene;
    
    // allows the user to manipulate the camera
    //    scnView.allowsCameraControl = YES;
    
    // show statistics such as fps and timing information
    //    scnView.showsStatistics = YES;
    
    // configure the view
    scnView.backgroundColor = [UIColor blackColor];
    
    // add a tap gesture recognizer
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapHandle:)];
    NSMutableArray *gestureRecognizers = [NSMutableArray array];
    [gestureRecognizers addObject:tapGesture];
    [gestureRecognizers addObjectsFromArray:scnView.gestureRecognizers];
    scnView.gestureRecognizers = gestureRecognizers;
    
    
    //创建控制点
    SCNNode * controlNode=[SCNNode node];
    controlNode.name = @"控制点";
    
    controlNode.geometry=[SCNBox boxWithWidth:1 height:1 length:1 chamferRadius:0];;
    controlNode.geometry.firstMaterial.diffuse.contents=[UIColor whiteColor];
    //    [controlNode addChildNode:upperArm];
    controlNode.position=SCNVector3Make(0, 0, 0);
    scnView.scene.rootNode.geometry.firstMaterial.diffuse.contents = [UIImage imageNamed:@"texture"];
    
    [scnView.scene.rootNode addChildNode:controlNode];
    scnView.delegate=(id)self;
    //右手
    SCNNode *ship1 = [scene.rootNode childNodeWithName:@"ship1" recursively:YES];
    SCNNode *ship2 = [scene.rootNode childNodeWithName:@"ship2" recursively:YES];
    SCNNode *ship3 = [scene.rootNode childNodeWithName:@"ship3" recursively:YES];
    //左手
    SCNNode *ship4 = [scene.rootNode childNodeWithName:@"ship4" recursively:YES];
    SCNNode *ship5 = [scene.rootNode childNodeWithName:@"ship5" recursively:YES];
    SCNNode *ship6 = [scene.rootNode childNodeWithName:@"ship6" recursively:YES];
    //右脚
    SCNNode *ship7 = [scene.rootNode childNodeWithName:@"ship7" recursively:YES];
    SCNNode *ship8 = [scene.rootNode childNodeWithName:@"ship8" recursively:YES];
    SCNNode *ship9 = [scene.rootNode childNodeWithName:@"ship9" recursively:YES];
    SCNNode *ship10 = [scene.rootNode childNodeWithName:@"ship10" recursively:YES];
    SCNNode *ship11 = [scene.rootNode childNodeWithName:@"ship11" recursively:YES];
    //左脚
    SCNNode *ship12 = [scene.rootNode childNodeWithName:@"ship12" recursively:YES];
    SCNNode *ship13 = [scene.rootNode childNodeWithName:@"ship13" recursively:YES];
    SCNNode *ship14 = [scene.rootNode childNodeWithName:@"ship14" recursively:YES];
    SCNNode *ship15 = [scene.rootNode childNodeWithName:@"ship15" recursively:YES];
    SCNNode *ship16 = [scene.rootNode childNodeWithName:@"ship16" recursively:YES];
    
    
    [scnView.scene.rootNode addChildNode:ship1];
    [ship1 addChildNode:ship2];
    [ship2 addChildNode:ship3];
    
    [controlNode addChildNode:ship4];
    [ship4 addChildNode:ship5];
    [ship5 addChildNode:ship6];
    
    [controlNode addChildNode:ship7];
    [ship7 addChildNode:ship8];
    [ship8 addChildNode:ship9];
    [ship9 addChildNode:ship10];
    [ship10 addChildNode:ship11];
    
    [controlNode addChildNode:ship12];
    [ship12 addChildNode:ship13];
    [ship13 addChildNode:ship14];
    [ship14 addChildNode:ship15];
    [ship15 addChildNode:ship16];
    
    //    ship1.pivot=SCNMatrix4MakeTranslation(-27.142, 161.97, 3.364);
    //    NSLog(@"%f %f %f",ship1.position.x,ship1.position.y,ship1.position.z);
    //    ship2.pivot=SCNMatrix4MakeTranslation(-42, 162.535, 0);
    //    ship3.pivot=SCNMatrix4MakeTranslation(-45,  105 , 0);
    //
    //    ship4.pivot=SCNMatrix4MakeTranslation(27.142, 161.97, 3.364);
    //    ship5.pivot=SCNMatrix4MakeTranslation(42, 162.535, 0);
    //    ship6.pivot=SCNMatrix4MakeTranslation(44.712,  103.493 , 0);
    //
    //    ship7.pivot=SCNMatrix4MakeTranslation(-14.837, 119.353, 0);
    //    ship8.pivot=SCNMatrix4MakeTranslation(-17.118, 90.109, 0);
    //    ship9.pivot=SCNMatrix4MakeTranslation(-14.645,  68.041 , 0);
    //    ship10.pivot=SCNMatrix4MakeTranslation(-15.893, 34.554, 3.364);
    //    ship11.pivot=SCNMatrix4MakeTranslation(-15, 5, 0);
    //
    //    ship12.pivot=SCNMatrix4MakeTranslation(14.837, 119.353, 0);
    //    ship13.pivot=SCNMatrix4MakeTranslation(17.118, 90.109, 0);
    //    ship14.pivot=SCNMatrix4MakeTranslation(14.645,  68.041 , 0);
    //    ship15.pivot=SCNMatrix4MakeTranslation(15.893, 34.554, 3.364);
    //    ship16.pivot=SCNMatrix4MakeTranslation(15, 5, 0);
    
    
    //    [ship2 runAction:[SCNAction rotateToX:0 y:0 z:-self.angle2_5 duration:0]];
    //
    //    [ship5 runAction:[SCNAction rotateToX:0 y:0 z:self.angle2_5 duration:0]];
    
    for (int i = 0; i<16; i++) {
        MyNode *node = self.nodes[i];
        node.node = [scene.rootNode childNodeWithName:[NSString stringWithFormat:@"ship%d" ,i + 1] recursively:YES];
        node.node.pivot = SCNMatrix4MakeTranslation(node.node.position.x, node.node.position.y, node.node.position.z); //node.node.position;
        node.delegate = self;
    }
    
    
    //    ship3.position=SCNVector3Make(-8, 0, 0);
    //    if (@available(iOS 11.0, *)) {
    //        CGPoint p = [self change3DPointTo2DPoint2:ship2.worldPosition sceneView:scnView];
    //
    //
    //        NSLog(@"%f %f %f",ship2.worldPosition.x,ship2.worldPosition.y,ship2.worldPosition.z);
    //        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(p.y , p.x, 1, 1)];
    //        view.backgroundColor = [UIColor redColor];
    //        [self.view addSubview:view];
    //    } else {
    //        // Fallback on earlier versions
    //    }
    //    UITapGestureRecognizer *t = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(doubleClick)];
    //    t.numberOfTapsRequired = 2;
    //    [scnView addGestureRecognizer:t];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button addTarget:self action:@selector(doubleClick:) forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:@"立正" forState:UIControlStateNormal];
    [self.view addSubview:button];
    button.frame = CGRectMake(250, 450, 60, 30);
    
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
      [button1 addTarget:self action:@selector(doubleClick:) forControlEvents:UIControlEventTouchUpInside];
      [button1 setTitle:@"不可旋转" forState:UIControlStateNormal];
      [self.view addSubview:button1];
    button1.tag = 1;
      button1.frame = CGRectMake(250, 650, 80, 30);
      
      
    
    _slider = [[HWCustomSlider alloc]init];
    _slider.block = ^(float value) {
        
        NSString *name = self.mynode.name;
        if ([name containsString:@"ship"]) {
            name = [name stringByReplacingOccurrencesOfString:@"ship" withString:@""];
            NSInteger index = [name integerValue];
            MyNode *node = self.nodes[index - 1];
            if ((node.maxAngle - node.minAngle) < 1.58) {
                node.currentAngle = (node.maxAngle - node.minAngle) * value /1000.0 + node.minAngle;
                self.labelAngle.text = [NSString stringWithFormat:@"%d",(int)value];
                
            }else if([name isEqualToString:@"2"] ||[name isEqualToString:@"5"] ){//ship2 ship5
                
                node.currentAngle = (node.maxAngle - node.minAngle) * value /1000.0 - node.minAngle;
                self.labelAngle.text = [NSString stringWithFormat:@"%d",(int)value];
            }else{
                node.currentAngle = (node.maxAngle - node.minAngle) * value /1000.0 - node.maxAngle;
                self.labelAngle.text = [NSString stringWithFormat:@"%d",(int)value];
            }
            [node runAction:node.currentAngle changeDelegate:NO];
            
            //            [node runcurP:curP preP:preP];
            
        }
    };
    [self.view addSubview:_slider];
    _slider.frame = CGRectMake(20, CGRectGetMaxY(button.frame) + 50, kSCREEN_WIDTH - 40, 30);
    
    
    self.labelAngle = [UILabel new];
    self.labelAngle.textColor = [UIColor whiteColor];
    [self.view addSubview:self.labelAngle];
    self.labelAngle.frame = CGRectMake(150, CGRectGetMaxY(self.slider.frame), 60, 20);
    
    self.labelAngle.text = @"0";
    
}
- (void)doubleClick:(UIButton *)sender
{
    if (sender.tag == 1) {
        if ([sender.currentTitle isEqualToString:@"可旋转"]) {
            scnView.allowsCameraControl = NO;
            [sender setTitle:@"不可旋转" forState:UIControlStateNormal];
        }else{
            [sender setTitle:@"可旋转" forState:UIControlStateNormal];
            scnView.allowsCameraControl = YES;

        }
    }else{
        
        for (int i = 0; i<16; i++) {
            MyNode *node = self.nodes[i];
            [node reSet];
            //          node.node = [scene.rootNode childNodeWithName:[NSString stringWithFormat:@"ship%d" ,i + 1] recursively:YES];
        }
    }
}

-(NSMutableArray *)nodes
{
    if (_nodes == nil) {
        _nodes = [MyNode getNodesInfo];
    }
    return _nodes;
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
    UITouch *touch = touches.anyObject;
    CGPoint curP = [touch locationInView:self.view];
    CGPoint preP = [touch precisePreviousLocationInView:self.view];
    CGFloat offsetX=curP.x-preP.x;
    CGFloat offsetY=curP.y-preP.y;
    //    NSLog(@"%f  %f",curP.x,preP.x);
    //NSLog(@"%f,%f",offsetX ,offsetY);
    //    self.view.transform=CGAffineTransformTranslate(self.view.transform, offsetX, offsetY);
    
    if (curP.x == preP.x) {
        return;
    }
    
    NSString *name = self.mynode.name;
    if ([name containsString:@"ship"]) {
        name = [name stringByReplacingOccurrencesOfString:@"ship" withString:@""];
        NSInteger index = [name integerValue];
        MyNode *node = self.nodes[index - 1];
        [node runcurP:curP preP:preP];
        return;
        
    }


}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    //    SCNMaterial *m = [[SCNMaterial alloc]init];
    //    m.diffuse.contents = [UIColor whiteColor];
    //    self.mynode.geometry.materials = @[m];
    //    for (SCNNode *no in self.mynode.childNodes) {
    //
    //        no.geometry.firstMaterial = m;
    //    }
    //    self.mynode = nil;
    [self change:self.mynode color:[UIColor whiteColor]];
    
    NSLog(@"touchesCancelled");
}
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    //    SCNMaterial *m = [[SCNMaterial alloc]init];
    //    m.diffuse.contents = [UIColor whiteColor];
    //    self.mynode.geometry.firstMaterial = m;
    //
    //    for (SCNNode *no in self.mynode.childNodes) {
    //
    //        no.geometry.firstMaterial = m;
    //    }
    [self change:self.mynode color:[UIColor whiteColor]];
    
    //    self.mynode = nil;
    NSLog(@"touchesEnded");
    
}
//循环遍历子节点 变换材质
- (void)change:(SCNNode *)node color:(UIColor *)color
{
    for (SCNNode *n in node.childNodes) {
        [self change:n color:color];
    }
    SCNMaterial *m = [[SCNMaterial alloc]init];
    m.diffuse.contents = color;
    node.geometry.firstMaterial = m;
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
    //            CGPoint p = [gestureRecognize locationInView:scnView];
    
    UITouch *touch = touches.anyObject;
    CGPoint p = [touch locationInView:scnView];
    NSArray *hitResults = [scnView hitTest:p options:nil];
    SCNMaterial *m = [[SCNMaterial alloc]init];
    m.diffuse.contents = [UIColor whiteColor];
    self.mynode.geometry.firstMaterial = m;
    // check that we clicked on at least one object
    if([hitResults count] > 0){
        // retrieved the first clicked object
        SCNHitTestResult *result = [hitResults objectAtIndex:0];
        
        // get its material
        //        if (self.mynode) {
        //            return;
        //        }
        self.mynode = result.node;
        NSLog(@"name =%@",self.mynode.name);
        
        NSString *name = self.mynode.name;
        if ([name containsString:@"ship"]) {
            name = [name stringByReplacingOccurrencesOfString:@"ship" withString:@""];
            NSInteger index = [name integerValue];
            MyNode *node = self.nodes[index - 1];
            [self changeWith:node Angle:node.currentAngle];
            //            [node runcurP:curP preP:preP];
            //            return;
            [self change:self.mynode color:[UIColor greenColor]];
            
        }
    }
}
- (void)tapHandle:(UIGestureRecognizer*)gestureRecognize
{
    return;
    //    [self createNodeToScene:scnView.scene andConstraint:ikConstraint];
    
    // retrieve the SCNView
    //        SCNView *scnView = (SCNView *)self.view;
    
    // check what nodes are tapped
    CGPoint p = [gestureRecognize locationInView:scnView];
    NSArray *hitResults = [scnView hitTest:p options:nil];
    SCNMaterial *m = [[SCNMaterial alloc]init];
    m.diffuse.contents = [UIColor whiteColor];
    self.mynode.geometry.firstMaterial = m;
    // check that we clicked on at least one object
    if([hitResults count] > 0){
        // retrieved the first clicked object
        SCNHitTestResult *result = [hitResults objectAtIndex:0];
        
        // get its material
        self.mynode = result.node;
        
        NSLog(@"name =%@",self.mynode.name);
        SCNMaterial *material =  self.mynode.geometry.firstMaterial;// result.node.geometry.firstMaterial;
        material.emission.contents = [UIColor greenColor];
 

    }
}

- (BOOL)shouldAutorotate
{
    return YES;
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return UIInterfaceOrientationMaskAllButUpsideDown;
    } else {
        return UIInterfaceOrientationMaskAll;
    }
}
/*!
 将3D坐标转换为屏幕坐标
 @param position              需要转换的3D坐标
 @param sceneView             显示当前场景的SCNView
 */

- (CGPoint)change3DPointTo2DPoint2:(SCNVector3)position sceneView:(SCNView *)sceneView{
    CGPoint rs = CGPointZero;
    //fieldOfView这个属性从iOS 11开始出现
    if (@available(iOS 11.0, *)) {
        //需要显示信息的模型 与摄像机的相对点
        SCNVector3 changePoint =  [sceneView.scene.rootNode convertPosition:position toNode:scnView.pointOfView];
        //计算场景在摄像头中的比例 我使用了默认的摄像机控制器 如自定义摄像机控制器或自定义相机  请传入对应参数 反正就是要fieldOfView
        CGFloat viewScale = tan(M_PI*sceneView.defaultCameraController.pointOfView.camera.fieldOfView/360)*(-changePoint.z) * 2;
        //转换为屏幕比例
        CGFloat pointScale =  self.screenRadius/(2*viewScale);
        //转换为屏幕上的点
        //横向翻转模式下是这样计算
        rs.x = (changePoint.x *pointScale) + kSCREEN_HEIGHT/2;
        rs.y = (-changePoint.y*pointScale) + kSCREEN_WIDTH/2;
        //竖屏下changePoint.x/y 的正负 可能需要按照情况调换一下
        //rs.x = (changePoint.x *pointScale) + kSCREEN_WIDTH/2;
        //rs.y = (-changePoint.y*pointScale) + kSCREEN_HEIGHT/2;
    } else {
        // Fallback on earlier versions
    }
    
    return rs;
}

- (void)changeWith:(MyNode *)myNode Angle:(float)angle
{
    float number = angle - myNode.minAngle;
    
    float an = ceil(1000.0 * number / M_PI) ;
    NSLog(@"%f",1000.0 * number / M_PI);
    self.labelAngle.text = [NSString stringWithFormat:@"%d",(int)an];
    self.slider.value = an;
    
}

@end
