//
//  ViewController.m
//  XKXKBabyDevelopmentThird
//
//  Created by 张旭 on 16/7/4.
//  Copyright © 2016年 zhangXu. All rights reserved.
//

#import "ViewController.h"
#import "XKCircleMacros.h"
#import "XKPERulerView.h"
#import "XKPEBabyTargetDrawView.h"
#import "XKPEBabySliderView.h"
#import "XKPEBabyScsViewController.h"
@interface ViewController ()<ZXPushVCDelegate>
@property (nonatomic ,strong)XKPEBabyTargetDrawView *drawView;
@property (nonatomic ,strong)XKPERulerView *rulerView;
@property (nonatomic ,strong) XKPEBabySliderView *productSlider;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.navigationController.navigationBar.hidden = YES;
    _drawView = [[XKPEBabyTargetDrawView  alloc]initWithFrame:CGRectMake(0,0,  XKUIScreenwidth,  XKUIScreenheight)];
    self.view.backgroundColor =[UIColor colorWithRed:32/255.0 green:180/255.0 blue:230/255.0 alpha:1.0];
    
//    [self.view addSubview:_drawView];

  _productSlider  = [[XKPEBabySliderView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 385)
                                                                    Title:@""
                                                                 MinValue:0
                                                                 MaxValue:320
                                                                     Step:1
                                                                     Unit:@"个月"
   
                                          
                                                                     HasDeleteBtn:NO];
    
    _productSlider.delegateOne =self;

    
    [self.view addSubview:_productSlider];
    
    
    // Do any additional setup after loading the view, typically from a nib.
}


-(void)PushVC:(UIButton *)sender{
    
    XKPEBabyScsViewController *babyScesVC = [[XKPEBabyScsViewController alloc]init];
    
    babyScesVC.btnTag = [NSString stringWithFormat:@"%ld",(long)sender.tag];
    NSInteger tag = sender.tag;
    if (self.block) {
        self.block(tag);
    }
    
    NSLog(@"!!!!!!%ld",(long)sender.tag);
    [self.navigationController pushViewController:babyScesVC animated:YES];
    
}

- (void)returnTag:(RetrunImg)block{
    self.block = block;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
