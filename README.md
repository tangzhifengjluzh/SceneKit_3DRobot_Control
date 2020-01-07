# SceneKit_3DRobot_Control（有问题可以留言，我也是在探索中，我们可以互相交流学习）
公司要求用3D的效果来显示机器人，并可以随意控制其他关节的转动，查资料，用SceneKit可以实现3D效果，起初自己也不知道能不能实现，也不知道怎么实现，经过自己的慢慢的探索，最终用SceneKit实现了自己想要的功能。功能有：3D模型的节点添加，转动,可通过手势滑动、滑杆来控制节点的转动。


这只是一个简单的 demo，写的比较粗糙，谢谢大家的支持！如果你觉得我写的 demo 对你有所帮助，请在 github 上下载的时候顺手给个 star，不胜感激！




![image](https://github.com/tangzhifengjluzh/SceneKit_3DRobot_Control/blob/master/SceneKit_3DRobot_Control/gif/ScreenRecording_01-03-2020-17-18-32_1_.gif)


# 重点部分
```ruby
    for (int i = 0; i<16; i++) {
        MyNode *node = self.nodes[i];
        //根据节点名获取节点  ship 为自己定义的 具体可以查看 移动后的效果图.dae  双击节点可修改节点名
        node.node = [scene.rootNode childNodeWithName:[NSString stringWithFormat:@"ship%d" ,i + 1] recursively:YES];
#warning 这句很重要。解决3D模型节点错位的问题。我是根据（原型.dae）为原型。由于它所有的节点的原点都是在(0,0,0),所以节点转动起来不是自己想要的效果，

后来我就平移节点，移动后的效果图为(移动后的效果图.dae)。使要转动的节点的原点处于我想要转动的那个轴点上。
但这样做节点会错位。所以通过下面这句很好的解决了这个问题。
        node.node.pivot = SCNMatrix4MakeTranslation(node.node.position.x, node.node.position.y, node.node.position.z);
        node.delegate = self;
    }
```
