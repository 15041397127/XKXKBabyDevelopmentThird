//
//  XKPEBabyScsViewController.m
//  XKXKBabyDevelopmentThird
//
//  Created by 张旭 on 16/7/6.
//  Copyright © 2016年 zhangXu. All rights reserved.
//

#import "XKPEBabyScsViewController.h"
#import "XKPEBabySliderView.h"
#import "ViewController.h"
@interface XKPEBabyScsViewController ()
@property (weak, nonatomic) IBOutlet UILabel *titlLabel;
@property (weak, nonatomic) IBOutlet UILabel *blessingLabel;
@property (weak, nonatomic) IBOutlet UIButton *reachButton;
@property (nonatomic ,strong) NSArray *titlArr;
@property (nonatomic ,strong) NSArray *blessingLabelArr;
@property (nonatomic ,strong) XKPEBabySliderView *sliderView;
@property (nonatomic ,strong) ViewController  *RootVC;
@end

@implementation XKPEBabyScsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _titlArr = [NSArray arrayWithObjects:@"最爱宝贝一抬头的骄傲", @"宝宝就站在这里", @"我是超模",@"身体是我的好朋友",@"千里之行始于足下",@"你问我答",@"宝宝式俯卧撑",@"宝宝去哪儿了",@"我有水世界",@"小青蛙，呱呱呱",@"弹簧跳跳跳",@"翻身“逆袭”我做主",@"宝贝魔术师",@"毛毛虫出动",@"小牙才露尖尖角",@"体操宝贝",@"我是演说家",@"三驱宝宝",@"伸手有寓意",@"宝贝音乐盒",@"稳稳的幸福",@"小燕子，穿花衣",@"雨后春笋",@"仰卧起坐",@"稳稳吃起来",@"宝宝是数学家",@"劳动最光荣",nil];
    _blessingLabelArr = [NSArray arrayWithObjects: @"恭喜您！宝贝已经会抬头了，快记录下这一幸福瞬间吧！", @"恭喜您！宝贝已经会扶着东西站立了，快记录下这一幸福瞬间吧！",@"恭喜您！宝贝已经会站立了，快记录下这一幸福瞬间吧！",@"恭喜您！宝贝已经了解自己的身体部位了，快记录下这一幸福瞬间吧！", @"恭喜您！宝贝已经会穿鞋了，快记录下这一幸福瞬间吧！",@"恭喜您！宝贝已经认识日常物品了，快记录下这一幸福瞬间吧！",@"恭喜您！宝贝已经会抬起胸部了，快记录下这一幸福瞬间吧！",@"恭喜您！宝贝已经会躲猫猫了，快记录下这一幸福瞬间吧！",@"恭喜您！宝贝已经会自己拿着杯子喝水了，快记录下这一幸福瞬间吧！",@"恭喜您！宝贝已经会双脚跳了，快记录下这一幸福瞬间吧！",@"恭喜您！宝贝已经会单脚跳了，快记录下这一幸福瞬间吧！",@"恭喜您！宝贝已经会翻身了，快记录下这一幸福瞬间吧！",@"恭喜您！宝贝已经会双手互相传递东西了，快记录下这一幸福瞬间吧！",@"恭喜您！宝贝已经会爬了，快记录下这一幸福瞬间吧！",@"恭喜您！宝贝已经冒出小牙了，快记录下这一幸福瞬间吧！",@"恭喜您！宝贝已经会弯腰直立了，快记录下这一幸福瞬间吧！",@"恭喜您！宝贝已经会说简单话语了，快记录下这一幸福瞬间吧！",@"恭喜您！宝贝已经会骑三轮车了，快记录下这一幸福瞬间吧！",@"恭喜您！宝贝已经会抓东西了，快记录下这一幸福瞬间吧！",@"恭喜您！宝贝已经会发出音节了，快记录下这一幸福瞬间吧！",@"恭喜您！宝贝已经会走路了，快记录下这一幸福瞬间吧！",@"恭喜您！宝贝已经会穿脱简单衣服了，快记录下这一幸福瞬间吧！",@"恭喜您！宝贝已经陆续长新牙了，快记录下这一幸福瞬间吧！",@"恭喜您！宝贝已经会坐起来了，快记录下这一幸福瞬间吧！",@"恭喜您！宝贝已经会用汤匙吃饭了，快记录下这一幸福瞬间吧！",@"恭喜您！宝贝已经会数数了，快记录下这一幸福瞬间吧！",@"恭喜您！宝贝已经会简单劳动了，快记录下这一幸福瞬间吧！",nil];
    
    for (int i = 0; i<28; i++) {
        if ([_btnTag integerValue]==i) {
            _titlLabel.text = [NSString stringWithFormat:@"%@",[_titlArr objectAtIndex:i]];
            _blessingLabel.text = [NSString stringWithFormat:@"%@",[_blessingLabelArr objectAtIndex:i]];
        }
    }

      _sliderView = [[XKPEBabySliderView alloc]init];
    
    // Do any additional setup after loading the view from its nib.
}

-(void)viewWillDisappear:(BOOL)animated{
    
}

- (IBAction)reachButton:(id)sender {
  

//    _sliderView.sucussNum =1;
    

//        _sliderView.sucessImgView.hidden = NO;
    _RootVC =[[ViewController alloc]init];
    [_RootVC returnTag:^(NSInteger tag) {
        
        


    }];
    for (int i = 0; i<28; i++) {
        if ([_btnTag integerValue]==i) {
            _sliderView.sucessImgView.hidden = NO;
        }
    }
    
    NSString *select = _btnTag;
    [[NSNotificationCenter defaultCenter]postNotificationName:@"sucessImg" object:select];
    
    
    [self.navigationController popViewControllerAnimated:YES];

}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
