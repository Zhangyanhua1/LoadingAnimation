//
//  ViewController.m
//  圆跟着轨迹滚动
//
//  Created by 云书网 on 16/8/3.
//  Copyright © 2016年 云书网. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, strong) UIBezierPath *path123;
@property (nonatomic, strong) CAShapeLayer *shapeLayer;
@property (nonatomic,assign) CGRect rect;
@property(nonatomic,strong)UIView* roundView;
@property (nonatomic,strong)CAKeyframeAnimation *keyAnimation ;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.rect = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    [self circleAnimationTypeOne];
    [self animation];
    
    
    
    UIButton* Stop = [[UIButton alloc] initWithFrame:CGRectMake(150, 50, 50, 30)];
    [self.view addSubview:Stop];
    [Stop setTitle:@"暂停" forState:UIControlStateNormal];
    [Stop addTarget:self action:@selector(stop) forControlEvents:UIControlEventTouchUpInside];
    [Stop setBackgroundColor:[UIColor grayColor]];
    
    UIButton* Star = [[UIButton alloc] initWithFrame:CGRectMake(250, 50, 50, 30)];
    [self.view addSubview:Star];
    [Star setTitle:@"开始" forState:UIControlStateNormal];
    [Star addTarget:self action:@selector(Star) forControlEvents:UIControlEventTouchUpInside];
    [Star setBackgroundColor:[UIColor grayColor]];
}
-(void)stop
{
    CFTimeInterval pausedTime = [_roundView.layer convertTime:CACurrentMediaTime() fromLayer:nil];
    _roundView.layer.speed = 0.0;
    _roundView.layer.timeOffset = pausedTime;
}
-(void)Star
{
    CFTimeInterval pausedTime = [_roundView.layer timeOffset];
    _roundView.layer.speed = 1.0;
    _roundView.layer.timeOffset = 0.0;
    _roundView.layer.beginTime = 0.0;
    CFTimeInterval timeSincePause = [_roundView.layer convertTime:CACurrentMediaTime() fromLayer:nil] - pausedTime;
    _roundView.layer.beginTime = timeSincePause;

}
- (void)circleAnimationTypeOne
{
    self.path123 = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(100, 100, 30, 50) byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(5, 5)];
    [self.path123 stroke];
    //创建出CAShapeLayer
    self.shapeLayer = [CAShapeLayer layer];
    self.shapeLayer.frame = self.rect;
    self.shapeLayer.fillColor = [UIColor clearColor].CGColor;
    
    //设置线条的宽度和颜色
    self.shapeLayer.lineWidth = 3;
    self.shapeLayer.strokeColor = [UIColor grayColor].CGColor;
    
    //让贝塞尔曲线与CAShapeLayer产生联系
    self.shapeLayer.path = self.path123.CGPath;
    
    //添加并显示
    [self.view.layer addSublayer:self.shapeLayer];
    
    
    UIView* view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 10, 10)];
    view.center = CGPointMake(100, 100);
    view.layer.cornerRadius=5;
    view.layer.masksToBounds=YES;
    view.backgroundColor= [UIColor grayColor];
    //    view.backgroundColor= [UIColor redColor];
    _roundView=view;
    [self.view addSubview:view];
}

- (void)animation {
    CAKeyframeAnimation *keyAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    keyAnimation.path= self.path123.CGPath;
    keyAnimation.fillMode = kCAFillModeForwards;
    keyAnimation.calculationMode = kCAAnimationPaced;
    keyAnimation.duration = 4*0.7;
    keyAnimation.removedOnCompletion = NO;
    keyAnimation.repeatCount = MAXFLOAT;
    [_roundView.layer addAnimation:keyAnimation forKey:nil];
    self.keyAnimation =keyAnimation;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
