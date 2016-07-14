//
//  XKPEBabySliderView.m
//  XKXKBabyDevelopmentThird
//
//  Created by 张旭 on 16/7/4.
//  Copyright © 2016年 zhangXu. All rights reserved.
//

#import "XKPEBabySliderView.h"
#import "XKCircleMacros.h"
#import "XKPEFooterView.h"
#import "XKPEHeaderView.h"
#import "XKPERulerView.h"
#import "XKPEBabyTargetDrawView.h"
#import "XKPEBabyScsViewController.h"
#import "ViewController.h"
@interface XKPEBabySliderView()<UIScrollViewDelegate,UITextFieldDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong) XKPEBabyTargetDrawView *babyTargetDrawView;
@property (nonatomic, strong) XKPEBabyScsViewController *babyScsVC;
@property (nonatomic, strong) UIButton         *deleteBtn;
@property (nonatomic, strong) UILabel          *titleLabel;
@property (nonatomic, strong) UITextField      *valueTF;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic ,strong) UIImageView      *pointerView;
@property (nonatomic, strong) UIButton         *todayBtn;
@property (nonatomic, strong) UIButton         *historyBtn;
@property (nonatomic, strong) UILabel          *nameLabel;
@property (nonatomic, strong) NSArray   *targetOneArr;
@property (nonatomic, strong) NSArray   *targetTwoArr;
@property (nonatomic, strong) NSArray   *targetThreeArr;
@property (nonatomic, strong) NSArray   *targetFourArr;
@property (nonatomic, strong) NSArray   *targetFiveArr;


@property (nonatomic, assign) int              stepNum;
@property (nonatomic, assign) int              value;
@property (nonatomic, assign) BOOL             scrollByHand;
@end
@implementation XKPEBabySliderView
-(instancetype)initWithFrame:(CGRect)frame Title:(NSString *)title MinValue:(int)minValue MaxValue:(int)maxValue Step:(int)step Unit:(NSString *)unit HasDeleteBtn:(BOOL)hasDeleteBtn
{
    if(self = [super initWithFrame:frame])
    {
        
        
        
        //readOnly设置
        _title = title;
        _minValue = minValue;
        _maxValue = maxValue;
        _step = step;
        _stepNum = (_maxValue-_minValue)/_step/10;
        _unit = unit;
        _scrollByHand = NO;
        
    
        _babyTargetDrawView = [[XKPEBabyTargetDrawView alloc]init];
       _babyScsVC = [[XKPEBabyScsViewController alloc]init];
        [self  creatBackView];

        
        //输入框
        _valueTF                          = [[UITextField alloc]initWithFrame:CGRectMake(0, 70, frame.size.width, 20)];
        _valueTF.defaultTextAttributes    = @{NSUnderlineColorAttributeName:[UIColor orangeColor],
                                              NSUnderlineStyleAttributeName:@(1),
                                              NSFontAttributeName:[UIFont systemFontOfSize:18],
                                              NSForegroundColorAttributeName:[UIColor orangeColor]};
        _valueTF.textAlignment            = NSTextAlignmentCenter;
        _valueTF.delegate                 = self;
        _valueTF.keyboardType             = UIKeyboardTypeNumberPad;
        
        _valueTF.attributedPlaceholder    = [[NSAttributedString alloc]initWithString:@"滑动标尺或输入"
                                                                           attributes:@{NSUnderlineColorAttributeName:[UIColor lightGrayColor],
                                                                                        NSUnderlineStyleAttributeName:@(1),
                                                                                        NSFontAttributeName:[UIFont systemFontOfSize:12],
                                                                                        NSForegroundColorAttributeName:[UIColor grayColor]}];
        [self addSubview:_valueTF];
        
        //标尺
        UICollectionViewFlowLayout *flowLayout =[[UICollectionViewFlowLayout alloc]init];
        [flowLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
        [flowLayout setSectionInset:UIEdgeInsetsMake(0, 0, 0, 0)];
        _collectionView  =[[UICollectionView alloc]initWithFrame:CGRectMake(0,CGRectGetMaxY(_rulerView.frame), self.bounds.size.width, 385) collectionViewLayout:flowLayout];
        self.backgroundColor = [UIColor clearColor];
        _collectionView.backgroundColor = [UIColor clearColor];
        
        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"systemCell"];
        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"custemCell"];
        
        _collectionView.bounces = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        [self addSubview:_collectionView];
        

        UILabel *label = [[UILabel alloc]init];
        label.font = [UIFont systemFontOfSize:11.0f];
        label.backgroundColor = [UIColor colorWithRed:32/255.0 green:180/255.0 blue:230/255.0 alpha:1.0];
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = [UIColor whiteColor];
        label.frame =CGRectMake(XKUIScreenwidth/2-dialGap+36*dialGap,17, 60, 15);
        label.text = @"9个月";

        UILabel *label1 = [[UILabel alloc]init];
        label1.font = [UIFont systemFontOfSize:11.0f];
        label1.backgroundColor = [UIColor colorWithRed:32/255.0 green:180/255.0 blue:230/255.0 alpha:1.0];
        label1.textAlignment = NSTextAlignmentCenter;
        label1.textColor = [UIColor whiteColor];
        label1.frame =CGRectMake(XKUIScreenwidth/2-dialGap+40*dialGap-6,17, 60, 15);
        label1.text = @"10个月";
        
        UILabel *label2 = [[UILabel alloc]init];
        label2.font = [UIFont systemFontOfSize:11.0f];
        label2.backgroundColor = [UIColor colorWithRed:32/255.0 green:180/255.0 blue:230/255.0 alpha:1.0];
        label2.textAlignment = NSTextAlignmentCenter;
        label2.textColor = [UIColor whiteColor];
        label2.frame =CGRectMake(XKUIScreenwidth/2-dialGap+44*dialGap-6,17, 60, 15);
        label2.text = @"11个月";
        
        UILabel *label3 = [[UILabel alloc]init];
        label3.font = [UIFont systemFontOfSize:11.0f];
        label3.backgroundColor = [UIColor colorWithRed:32/255.0 green:180/255.0 blue:230/255.0 alpha:1.0];
        label3.textAlignment = NSTextAlignmentCenter;
        label3.textColor = [UIColor whiteColor];
        label3.frame =CGRectMake(XKUIScreenwidth/2-dialGap+100*dialGap,17, 60, 15);
        label3.text = @"2岁半";
        
        
        UILabel *label4 = [[UILabel alloc]init];
        label4.font = [UIFont systemFontOfSize:11.0f];
        label4.backgroundColor = [UIColor colorWithRed:32/255.0 green:180/255.0 blue:230/255.0 alpha:1.0];
        label4.textAlignment = NSTextAlignmentCenter;
        label4.textColor = [UIColor whiteColor];
        label4.frame =CGRectMake(XKUIScreenwidth/2-dialGap+104*dialGap,17, 60, 15);
        label4.text = @"3周岁";
        
        
        UILabel *label5 = [[UILabel alloc]init];
        label5.font = [UIFont systemFontOfSize:11.0f];
        label5.backgroundColor = [UIColor colorWithRed:32/255.0 green:180/255.0 blue:230/255.0 alpha:1.0];
        label5.textAlignment = NSTextAlignmentCenter;
        label5.textColor = [UIColor whiteColor];
        label5.frame =CGRectMake(XKUIScreenwidth/2-dialGap+108*dialGap,17, 60, 15);
        label5.text = @"3岁半";
        
        UILabel *label6 = [[UILabel alloc]init];
        label6.font = [UIFont systemFontOfSize:11.0f];
        label6.backgroundColor = [UIColor colorWithRed:32/255.0 green:180/255.0 blue:230/255.0 alpha:1.0];
        label6.textAlignment = NSTextAlignmentCenter;
        label6.textColor = [UIColor whiteColor];
        label6.frame =CGRectMake(XKUIScreenwidth/2-dialGap+112*dialGap,17, 60, 15);
        label6.text = @"4周岁";
        
        
        UILabel *label7 = [[UILabel alloc]init];
        label7.font = [UIFont systemFontOfSize:11.0f];
        label7.backgroundColor = [UIColor colorWithRed:32/255.0 green:180/255.0 blue:230/255.0 alpha:1.0];
        label7.textAlignment = NSTextAlignmentCenter;
        label7.textColor = [UIColor whiteColor];
        label7.frame =CGRectMake(XKUIScreenwidth/2-dialGap+116*dialGap,17, 60, 15);
        label7.text = @"4岁半";
        
        UILabel *label8 = [[UILabel alloc]init];
        label8.font = [UIFont systemFontOfSize:11.0f];
        label8.backgroundColor = [UIColor colorWithRed:32/255.0 green:180/255.0 blue:230/255.0 alpha:1.0];
        label8.textAlignment = NSTextAlignmentCenter;
        label8.textColor = [UIColor whiteColor];
        label8.frame =CGRectMake(XKUIScreenwidth/2-dialGap+120*dialGap,17, 60, 15);
        label8.text = @"5周岁";
        
        UILabel *label9 = [[UILabel alloc]init];
        label9.font = [UIFont systemFontOfSize:11.0f];
        label9.backgroundColor = [UIColor colorWithRed:32/255.0 green:180/255.0 blue:230/255.0 alpha:1.0];
        label9.textAlignment = NSTextAlignmentCenter;
        label9.textColor = [UIColor whiteColor];
        label9.frame =CGRectMake(XKUIScreenwidth/2-dialGap+124*dialGap,17, 60, 15);
        label9.text = @"5岁半";
        
        UILabel *label10 = [[UILabel alloc]init];
        label10.font = [UIFont systemFontOfSize:11.0f];
        label10.backgroundColor = [UIColor colorWithRed:32/255.0 green:180/255.0 blue:230/255.0 alpha:1.0];
        label10.textAlignment = NSTextAlignmentCenter;
        label10.textColor = [UIColor whiteColor];
        label10.frame =CGRectMake(XKUIScreenwidth/2-dialGap+128*dialGap,17, 60, 15);
        label10.text = @"6周岁";
        
        [_collectionView addSubview:label];
        [_collectionView addSubview:label1];
        [_collectionView addSubview:label2];
        [_collectionView addSubview:label3];
        [_collectionView addSubview:label4];
        [_collectionView addSubview:label5];
        [_collectionView addSubview:label6];
        [_collectionView addSubview:label7];
        [_collectionView addSubview:label8];
        [_collectionView addSubview:label9];
        [_collectionView addSubview:label10];
        
        
        
        _pointerView = [[UIImageView alloc]initWithFrame:CGRectMake(XKUIScreenwidth/2-2.5,CGRectGetMaxY(_rulerView.frame), 5,194)];
        _pointerView.image = [UIImage imageNamed:@"指针@2x(1)"];
        [self addSubview:_pointerView];
        

        
        _todayBtn = [[UIButton alloc]initWithFrame:CGRectMake(15,CGRectGetMaxY(_navView.frame)+20, 50, 25)];
        _todayBtn.layer.borderWidth = 1;
        _todayBtn.layer.borderColor = [UIColor whiteColor].CGColor;
        _todayBtn.layer.cornerRadius = 10.0f;
        [_todayBtn setTitle:@"今天" forState:UIControlStateNormal];
        _todayBtn.titleLabel.textColor = [UIColor whiteColor];
        _todayBtn.titleLabel.font = [UIFont systemFontOfSize:15.0f];
        [_todayBtn addTarget:self action:@selector(button1BackGroundHighlighted:) forControlEvents:UIControlEventTouchDown];
        [_todayBtn addTarget:self action:@selector(button1BackGroundNormal:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_todayBtn];
        
        _historyBtn = [[UIButton alloc]initWithFrame:CGRectMake(XKUIScreenwidth-15-_todayBtn.frame.size.width, CGRectGetMinY(_todayBtn.frame), 50, 25)];
        _historyBtn.layer.borderWidth = 1;
        _historyBtn.layer.borderColor = [UIColor whiteColor].CGColor;
        _historyBtn.layer.cornerRadius = 10.0f;
        [_historyBtn setTitle:@"历程" forState:UIControlStateNormal];
        _historyBtn.titleLabel.textColor = [UIColor whiteColor];
        _historyBtn.titleLabel.font = [UIFont systemFontOfSize:15.0f];
        [_historyBtn addTarget:self action:@selector(button1BackGroundHighlighted:) forControlEvents:UIControlEventTouchDown];
        [_historyBtn addTarget:self action:@selector(button1BackGroundNormal:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_historyBtn];
        
        _nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_todayBtn.frame),CGRectGetMaxY(_babyButton.frame), XKUIScreenwidth-2*CGRectGetMaxX(_todayBtn.frame), 30)];
        _nameLabel.textColor = [UIColor whiteColor];
        _nameLabel.backgroundColor = [UIColor clearColor];
        _nameLabel.textAlignment = NSTextAlignmentCenter;
        _nameLabel.font = [UIFont systemFontOfSize:14.0f];
        _nameLabel.text = @"小豆芽  8岁一个月";
        [self addSubview:_nameLabel];

        
       [self creatTargetBtn];

        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(changeIm:) name:@"sucessImg" object:nil];
    }
    return self;
}

-(void)creatBackView{
    self.navView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, XKUIScreenwidth, 100)];
    self.navView.image = [UIImage imageNamed:@"顶部栏"];
    [self addSubview:self.navView];
    
    self.weightLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 60, 50,10)];
    self.weightLabel.font = [UIFont systemFontOfSize:11.0f];
    self.weightLabel.text = @"体重";
    self.weightLabel.textColor = [UIColor whiteColor];
    [self.navView addSubview:self.weightLabel];
    
    self.weightNumLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(self.weightLabel.frame), CGRectGetMaxY(self.weightLabel.frame)+5, 100, 20)];
    self.weightNumLabel.font = [UIFont systemFontOfSize:15.0f];
    self.weightNumLabel.textColor = [UIColor whiteColor];
    if (_babySexNum ==0) {
        _weightNumLabel.text = @"2.4-4.3kg";
    }else{
        _weightNumLabel.text = @"2.2-4.0kg";
    }
    [self.navView addSubview:self.weightNumLabel];
    
    self.heightLabel = [[UILabel alloc]initWithFrame:CGRectMake(XKUIScreenwidth-65, 60, 50, 10)];
    self.heightLabel.font = [UIFont systemFontOfSize:11.0f];
    self.heightLabel.text = @"身高";
    self.heightLabel.textAlignment = NSTextAlignmentRight;
    self.heightLabel.textColor = [UIColor whiteColor];
    [self.navView addSubview:self.heightLabel];
    
    self.heightNumLabel = [[UILabel alloc]initWithFrame:CGRectMake(XKUIScreenwidth-135, CGRectGetMaxY(self.heightLabel.frame)+5, 120, 20)];
    self.heightNumLabel.font = [UIFont systemFontOfSize:15.0f];
    self.heightNumLabel.textColor = [UIColor whiteColor];
    self.heightNumLabel.textAlignment = NSTextAlignmentRight;
    if (_babySexNum ==0) {
        self.heightNumLabel.text = @"45.9-55.1cm";
    }else{
        self.heightNumLabel.text = @"45.5-54.2cm";
    }
    
    [self.navView addSubview:self.heightNumLabel];
    self.maskImgView = [[UIImageView alloc]initWithFrame:CGRectMake(0,CGRectGetHeight(self.navView.frame), self.navView.frame.size.width, 60)];
    self.maskImgView.image= [UIImage imageNamed:@"阴影750x60px"];
    [self addSubview:self.maskImgView];
    
    self.babyButton = [[UIButton alloc]initWithFrame:CGRectMake(XKUIScreenwidth/2-42, 42, 84, 84)];
    self.babyButton.layer.cornerRadius = 21;
    self.babyButton.layer.masksToBounds = YES;
    [self.babyButton setBackgroundImage:[UIImage imageNamed:@"头像小王子"] forState:UIControlStateNormal];
    [self addSubview:self.babyButton];
    
    self.rulerView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.navView.frame)+64, XKUIScreenwidth, 1)];
    self.rulerView.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.rulerView];
    
    self.backViewOne = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.navView.frame)+98, XKUIScreenwidth, 32)];
    self.backViewOne.backgroundColor =  [UIColor colorWithRed:229/255.0 green:248/255.0 blue:255/255.0 alpha:1.0];
    [self addSubview:self.backViewOne];
    
    self.backViewTwo = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.backViewOne.frame), XKUIScreenwidth, 32)];
    self.backViewTwo.backgroundColor =  [UIColor colorWithRed:204/255.0 green:241/255.0 blue:255/255.0 alpha:1.0];
    [self addSubview:self.backViewTwo];
    
    self.backViewTrd = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.backViewTwo.frame), XKUIScreenwidth, 32)];
    self.backViewTrd.backgroundColor =   [UIColor colorWithRed:178/255.0 green:235/255.0 blue:255/255.0 alpha:1.0];
    [self addSubview:self.backViewTrd];
    
    self.backViewfour = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.backViewTrd.frame), XKUIScreenwidth, 32)];
    self.backViewfour.backgroundColor =   [UIColor colorWithRed:153/255.0 green:228/255.0 blue:255/255.0 alpha:1.0];
    [self addSubview:self.backViewfour];
    
    
    self.backViewfive = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.backViewfour.frame), XKUIScreenwidth, 32)];
    self.backViewfive.backgroundColor =   [UIColor colorWithRed:127/255.0 green:221/255.0 blue:255/255.0 alpha:1.0];
    [self addSubview:self.backViewfive];
    
 
    

    
}


-(void)creatTargetBtn{
    
    
    
    _targetOneArr = [[NSArray arrayWithObjects:@"俯卧时能抬头1-2秒，逐渐抬头稳定",@"能扶着物体维持站立姿势",@"自己能站一会",@"能正确的指出身体的一个部分，逐渐指出各部位",@"会穿鞋",@"能说出3种物体的成分", nil]init];
    _targetTwoArr = [[NSArray arrayWithObjects:@"趴着时手能支起胸部",@"会玩躲猫猫",@"能拿住杯子喝水",@"能双脚跳",@"能单脚跳",nil]init];
    _targetThreeArr = [[NSArray arrayWithObjects:@"会翻身",@"将积木从一手移至另一手",@"会爬",@"长牙",@"弯腰后能平稳地恢复到站立姿势", @"会说2-3个词组成的简单语句",@"会骑三轮车",nil]init];
    _targetFourArr = [[NSArray arrayWithObjects:@"手能伸向物体、摸东西",@"发出无意识的“ba da ma”",@"逐渐开始会走的很稳",@"会穿脱简单衣服",nil]init];
     _targetFiveArr = [[NSArray arrayWithObjects:@"长牙",@"自己能坐起",@"用汤匙吃东西很少溢出来，逐渐熟练使用汤匙吃饭",@"会数数，逐渐增加数数个数",@"小劳动",nil]init];
    
 
   
    
    
    UILabel *label = [[UILabel alloc]initWithFrame:_targetBtnOne.frame];
    label.text = @"宝宝会爬了";
    [_targetBtnOne addSubview:label];
    

    
  
    /**
     *  第一行
     */
    for (int i =0; i<6; i++) {
        
        _targetBtnOne = [UIButton buttonWithType:UIButtonTypeCustom];
        UILabel *label = [[UILabel alloc]initWithFrame:_targetBtnOne.frame];
        label.text = @"宝宝会爬了";
        [_targetBtnOne addSubview:label];
      
    _sucessImgView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"选中"]];
        _sucessImgView.hidden = YES;

            [_targetBtnOne setTitle:[_targetOneArr objectAtIndex:i]forState:UIControlStateNormal];
            [_targetBtnOne setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            _targetBtnOne.titleLabel.tintColor = [UIColor whiteColor];
        _targetBtnOne.titleLabel.font = [UIFont systemFontOfSize:12.0f];
        
        [_targetBtnOne addTarget:self action:@selector(nextPageOne:) forControlEvents:UIControlEventTouchUpInside];
        
        _targetBtnOne.tag = i;

        if (i==0) {
            _targetBtnOne.frame = CGRectMake(XKUIScreenwidth/2 , 33, dialGap*12, 32);
            _sucessImgView.frame = CGRectMake(_targetBtnOne.frame.size.width-16, 0, 16, 16);
        }
        else if(i==1){
            _targetBtnOne.frame = CGRectMake(XKUIScreenwidth/2+dialGap*18 , 33, dialGap*18, 32);
                    _sucessImgView.frame = CGRectMake(_targetBtnOne.frame.size.width-16, 0, 16, 16);
        }else if(i==2){
            _targetBtnOne.frame = CGRectMake(XKUIScreenwidth/2+dialGap*36 , 33, dialGap*16, 32);
                    _sucessImgView.frame = CGRectMake(_targetBtnOne.frame.size.width-16, 0, 16, 16);
        }else if(i==3){
            _targetBtnOne.frame = CGRectMake(XKUIScreenwidth/2+dialGap*52 , 33, dialGap*38, 32);
                    _sucessImgView.frame = CGRectMake(_targetBtnOne.frame.size.width-16, 0, 16, 16);
        }else if(i==4){
            _targetBtnOne.frame = CGRectMake(XKUIScreenwidth/2+dialGap*104 , 33, dialGap*6, 32);
                    _sucessImgView.frame = CGRectMake(_targetBtnOne.frame.size.width-16, 0, 16, 16);
        }else if(i==5){
            _targetBtnOne.frame = CGRectMake(XKUIScreenwidth/2+dialGap*112 , 33, dialGap*16, 32);
                    _sucessImgView.frame = CGRectMake(_targetBtnOne.frame.size.width-16, 0, 16, 16);
        }
        
        
        
        if (i==0) {
            
            _targetBtnOne.backgroundColor = [UIColor colorWithRed:255/255.0 green:188/255.0 blue:147/255.0 alpha:1];
 
        }else if (i==1){
               _targetBtnOne.backgroundColor = [UIColor colorWithRed:255/255.0 green:129/255.0 blue:147/255.0 alpha:1];
        }else if (i==2){
            _targetBtnOne.backgroundColor = [UIColor colorWithRed:57/255.0 green:208/255.0 blue:222/255.0 alpha:1];
        }else if (i==3){
            _targetBtnOne.backgroundColor = [UIColor colorWithRed:137/255.0 green:205/255.0 blue:70/255.0 alpha:1];
        }else if (i==4){
            _targetBtnOne.backgroundColor = [UIColor colorWithRed:255/255.0 green:188/255.0 blue:147/255.0 alpha:1];
        }else if (i==5){
            _targetBtnOne.backgroundColor = [UIColor colorWithRed:137/255.0 green:205/255.0 blue:70/255.0 alpha:1];
        }
                [_targetBtnOne addSubview:_sucessImgView];
        [_collectionView addSubview:_targetBtnOne];
        
    }
    
    /**
     *  第2行
     */
    for (int i =0; i<5; i++) {
        _targetBtnTwo = [UIButton buttonWithType:UIButtonTypeCustom];
        [_targetBtnTwo setTitle:[_targetTwoArr objectAtIndex:i] forState:UIControlStateNormal];
        [_targetBtnTwo setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _targetBtnTwo.titleLabel.tintColor = [UIColor whiteColor];
         _targetBtnTwo.titleLabel.font = [UIFont systemFontOfSize:12.0f];
        
        [_targetBtnTwo addTarget:self action:@selector(nextPageOne:) forControlEvents:UIControlEventTouchUpInside];
        
        _targetBtnTwo.tag = i+6;
        
        _sucessImgView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"选中"]];
        _sucessImgView.hidden = YES;
        if (i==0) {
            _targetBtnTwo.frame = CGRectMake(XKUIScreenwidth/2+dialGap*8 ,CGRectGetMaxY(_targetBtnOne.frame), dialGap*8, 32);
            _sucessImgView.frame = CGRectMake(_targetBtnTwo.frame.size.width-16, 0, 16, 16);

        }else if(i ==1){
            _targetBtnTwo.frame = CGRectMake(XKUIScreenwidth/2+dialGap*20,CGRectGetMaxY(_targetBtnOne.frame), dialGap*16, 32);
                        _sucessImgView.frame = CGRectMake(_targetBtnTwo.frame.size.width-16, 0, 16, 16);
        }else if(i ==2){
            _targetBtnTwo.frame = CGRectMake(XKUIScreenwidth/2+dialGap*36 ,CGRectGetMaxY(_targetBtnOne.frame), dialGap*30, 32);
                        _sucessImgView.frame = CGRectMake(_targetBtnTwo.frame.size.width-16, 0, 16, 16);
        }else if(i ==3){
            _targetBtnTwo.frame = CGRectMake(XKUIScreenwidth/2+dialGap*92 ,CGRectGetMaxY(_targetBtnOne.frame), dialGap*8, 32);
                        _sucessImgView.frame = CGRectMake(_targetBtnTwo.frame.size.width-16, 0, 16, 16);
        }else if(i ==4){
            _targetBtnTwo.frame = CGRectMake(XKUIScreenwidth/2+dialGap*104 ,CGRectGetMaxY(_targetBtnOne.frame), dialGap*16, 32);
                        _sucessImgView.frame = CGRectMake(_targetBtnTwo.frame.size.width-16, 0, 16, 16);
        }
        
        if (i==0) {
        _targetBtnTwo.backgroundColor = [UIColor colorWithRed:77/255.0 green:191/255.0 blue:233/255.0 alpha:1];
        }else if (i==1){
        _targetBtnTwo.backgroundColor = [UIColor colorWithRed:255/255.0 green:188/255.0 blue:147/255.0 alpha:1];
        }else if (i==2){
        _targetBtnTwo.backgroundColor = [UIColor colorWithRed:255/255.0 green:129/255.0 blue:147/255.0 alpha:1];
        }else if (i==3){
            _targetBtnTwo.backgroundColor =[UIColor colorWithRed:137/255.0 green:205/255.0 blue:70/255.0 alpha:1];
        }
        else if (i==4){
             _targetBtnTwo.backgroundColor=[UIColor colorWithRed:57/255.0 green:208/255.0 blue:222/255.0 alpha:1];
        }
    
        [_targetBtnTwo addSubview:_sucessImgView];

        [_collectionView addSubview:_targetBtnTwo];
        
    }
    
    /**
     *  第3行
     */
    for (int i =0; i<7; i++) {
        _targetBtnThree = [UIButton buttonWithType:UIButtonTypeCustom];
        [_targetBtnThree setTitle:[_targetThreeArr objectAtIndex:i] forState:UIControlStateNormal];
        [_targetBtnThree setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _targetBtnThree.titleLabel.tintColor = [UIColor whiteColor];
             _targetBtnThree.titleLabel.font = [UIFont systemFontOfSize:12.0f];
        [_targetBtnThree addTarget:self action:@selector(nextPageOne:) forControlEvents:UIControlEventTouchUpInside];
        _targetBtnThree.tag = i+11;
        
        _sucessImgView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"选中"]];
        _sucessImgView.hidden = YES;
        
        if (i==0) {
            _targetBtnThree.frame = CGRectMake(XKUIScreenwidth/2+dialGap*10,CGRectGetMaxY(_targetBtnTwo.frame), dialGap*10, 32);
            _sucessImgView.frame = CGRectMake(_targetBtnThree.frame.size.width-16, 0, 16, 16);

        }else if(i==1){
            _targetBtnThree.frame = CGRectMake(XKUIScreenwidth/2+dialGap*20 ,CGRectGetMaxY(_targetBtnTwo.frame), dialGap*10, 32);
                   _sucessImgView.frame = CGRectMake(_targetBtnThree.frame.size.width-16, 0, 16, 16);
        }else if(i==2){
            _targetBtnThree.frame = CGRectMake(XKUIScreenwidth/2+dialGap*32,CGRectGetMaxY(_targetBtnTwo.frame), dialGap*4, 32);
                   _sucessImgView.frame = CGRectMake(_targetBtnThree.frame.size.width-16, 0, 16, 16);
        }else if(i==3){
            _targetBtnThree.frame = CGRectMake(XKUIScreenwidth/2+dialGap*36,CGRectGetMaxY(_targetBtnTwo.frame), dialGap*2, 32);
                  _sucessImgView.frame = CGRectMake(_targetBtnThree.frame.size.width-16, 0, 16, 16);
        }else if(i==4){
            _targetBtnThree.frame = CGRectMake(XKUIScreenwidth/2+dialGap*42,CGRectGetMaxY(_targetBtnTwo.frame), dialGap*24, 32);
                   _sucessImgView.frame = CGRectMake(_targetBtnThree.frame.size.width-16, 0, 16, 16);
        }else if(i==5){
            _targetBtnThree.frame = CGRectMake(XKUIScreenwidth/2+dialGap*70,CGRectGetMaxY(_targetBtnTwo.frame), dialGap*28, 32);
                   _sucessImgView.frame = CGRectMake(_targetBtnThree.frame.size.width-16, 0, 16, 16);
        }else if(i==6){
            _targetBtnThree.frame = CGRectMake(XKUIScreenwidth/2+dialGap*100,CGRectGetMaxY(_targetBtnTwo.frame), dialGap*8, 32);
                   _sucessImgView.frame = CGRectMake(_targetBtnThree.frame.size.width-16, 0, 16, 16);
        }
        
        if (i==0) {
             _targetBtnThree.backgroundColor = [UIColor colorWithRed:57/255.0 green:208/255.0 blue:222/255.0 alpha:1];
        }else if (i==1){
             _targetBtnThree.backgroundColor = [UIColor colorWithRed:77/255.0 green:191/255.0 blue:233/255.0 alpha:1];

        }else if (i==2){
            
              _targetBtnThree.backgroundColor = [UIColor colorWithRed:137/255.0 green:205/255.0 blue:70/255.0 alpha:1];
        }else if (i==3){
            
            _targetBtnThree.backgroundColor =  [UIColor colorWithRed:255/255.0 green:129/255.0 blue:147/255.0 alpha:1];
        }else if (i==4){
            
            _targetBtnThree.backgroundColor = [UIColor colorWithRed:255/255.0 green:188/255.0 blue:147/255.0 alpha:1];
        }else if (i==5){
            _targetBtnThree.backgroundColor = [UIColor colorWithRed:137/255.0 green:205/255.0 blue:70/255.0 alpha:1];
        }else if (i==6){
            _targetBtnThree.backgroundColor = [UIColor colorWithRed:57/255.0 green:208/255.0 blue:222/255.0 alpha:1];
        }
        [_targetBtnThree addSubview:_sucessImgView];

        [_collectionView addSubview:_targetBtnThree];
        
    }
    /**
     *  第4行
     */
    
    for (int i =0; i<4; i++) {
        _targetBtnFour = [UIButton buttonWithType:UIButtonTypeCustom];
        [_targetBtnFour setTitle:[_targetFourArr objectAtIndex:i] forState:UIControlStateNormal];
        [_targetBtnFour setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _targetBtnFour.titleLabel.tintColor = [UIColor whiteColor];
                     _targetBtnFour.titleLabel.font = [UIFont systemFontOfSize:12.0f];
        [_targetBtnFour addTarget:self action:@selector(nextPageOne:) forControlEvents:UIControlEventTouchUpInside];
        
        _targetBtnFour.tag = i+18;
        _sucessImgView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"选中"]];
        _sucessImgView.hidden = YES;
        if (i==0) {
            _targetBtnFour.frame = CGRectMake(XKUIScreenwidth/2+dialGap*12 ,CGRectGetMaxY(_targetBtnThree.frame), dialGap*8, 32);
                               _sucessImgView.frame = CGRectMake(_targetBtnFour.frame.size.width-16, 0, 16, 16);
        }else if (i==1){
            _targetBtnFour.frame = CGRectMake(XKUIScreenwidth/2+dialGap*22 ,CGRectGetMaxY(_targetBtnThree.frame), dialGap*8, 32);
            
        }else if (i==2){
            _targetBtnFour.frame = CGRectMake(XKUIScreenwidth/2+dialGap*42 ,CGRectGetMaxY(_targetBtnThree.frame), dialGap*14, 32);
            _sucessImgView.frame = CGRectMake(_targetBtnFour.frame.size.width-16, 0, 16, 16);
        }else if (i==3){
            _targetBtnFour.frame = CGRectMake(XKUIScreenwidth/2+dialGap*100 ,CGRectGetMaxY(_targetBtnThree.frame), dialGap*22, 32);
                  _sucessImgView.frame = CGRectMake(_targetBtnFour.frame.size.width-16, 0, 16, 16);
        }
        
        if (i==0) {
            _targetBtnFour.backgroundColor = [UIColor colorWithRed:255/255.0 green:129/255.0 blue:147/255.0 alpha:1];
          
        }else if (i==1){
            _targetBtnFour.backgroundColor=[UIColor colorWithRed:255/255.0 green:188/255.0 blue:147/255.0 alpha:1];
        }else if (i==2){
            _targetBtnFour.backgroundColor = [UIColor colorWithRed:77/255.0 green:191/255.0 blue:233/255.0 alpha:1];
        }else if (i==3){
            _targetBtnFour.backgroundColor = [UIColor colorWithRed:255/255.0 green:129/255.0 blue:147/255.0 alpha:1];
        }
        [_targetBtnFour addSubview:_sucessImgView];
        [_collectionView addSubview:_targetBtnFour];
        
    }
    
    
    /**
     *  第5行
     */
    for (int i =0; i<5; i++) {
        _targetBtnFive = [UIButton buttonWithType:UIButtonTypeCustom];
        [_targetBtnFive setTitle:[_targetFiveArr objectAtIndex:i] forState:UIControlStateNormal];
        [_targetBtnFive setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _targetBtnFive.titleLabel.tintColor = [UIColor whiteColor];
        _targetBtnFive.titleLabel.font = [UIFont systemFontOfSize:12.0f];
        [_targetBtnFive addTarget:self action:@selector(nextPageOne:) forControlEvents:UIControlEventTouchUpInside];
        _sucessImgView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"选中"]];
        _sucessImgView.hidden = YES;
        _targetBtnFive.tag = i+22;
        if (i==0) {
            _targetBtnFive.frame = CGRectMake(XKUIScreenwidth/2+dialGap*16 ,CGRectGetMaxY(_targetBtnFour.frame), dialGap*2, 32);
            _sucessImgView.frame = CGRectMake(_targetBtnFive.frame.size.width-16, 0, 16, 16);

        }else if(i==1){
            _targetBtnFive.frame = CGRectMake(XKUIScreenwidth/2+dialGap*24 ,CGRectGetMaxY(_targetBtnFour.frame), dialGap*22, 32);
            _sucessImgView.frame = CGRectMake(_targetBtnFive.frame.size.width-16, 0, 16, 16);
        }else if(i==2){
            _targetBtnFive.frame = CGRectMake(XKUIScreenwidth/2+dialGap*50 ,CGRectGetMaxY(_targetBtnFour.frame), dialGap*48, 32);
                      _sucessImgView.frame = CGRectMake(_targetBtnFive.frame.size.width-16, 0, 16, 16);
        }else if(i==3){
            _targetBtnFive.frame = CGRectMake(XKUIScreenwidth/2+dialGap*100 ,CGRectGetMaxY(_targetBtnFour.frame), dialGap*20, 32);
                        _sucessImgView.frame = CGRectMake(_targetBtnFive.frame.size.width-16, 0, 16, 16);
        }else if(i==4){
            _targetBtnFive.frame = CGRectMake(XKUIScreenwidth/2+dialGap*124 ,CGRectGetMaxY(_targetBtnFour.frame), dialGap*4, 32);
                        _sucessImgView.frame = CGRectMake(_targetBtnFive.frame.size.width-16, 0, 16, 16);
        }
        
        if(i==0){
            _targetBtnFive.backgroundColor = [UIColor colorWithRed:137/255.0 green:205/255.0 blue:70/255.0 alpha:1];
        }else if (i==1){
          _targetBtnFive.backgroundColor = [UIColor colorWithRed:255/255.0 green:129/255.0 blue:147/255.0 alpha:1];
        }else if (i==2){
            _targetBtnFive.backgroundColor = [UIColor colorWithRed:57/255.0 green:208/255.0 blue:222/255.0 alpha:1];
        }else if (i==3){
            _targetBtnFive.backgroundColor = [UIColor colorWithRed:137/255.0 green:205/255.0 blue:70/255.0 alpha:1];
        }else if (i==4){
            _targetBtnFive.backgroundColor = [UIColor colorWithRed:255/255.0 green:129/255.0 blue:147/255.0 alpha:1];
        }
        

        [_collectionView addSubview:_targetBtnFive];
        
    }
    
    
}

-(void)nextPageOne:(UIButton *)sender{
    
    if (self.delegateOne &&[self.delegateOne respondsToSelector:@selector(PushVC:)]) {
        [self.delegateOne PushVC:sender];
        

     
//            sender.tag = (long)(UIButton*)[_collectionView viewWithTag:0];
//        
//        //_targetBtnOne = (UIButton*)[_collectionView viewWithTag:1];
//        //    for (int i=0; i<6; i++) {
//        ////        _targetBtnOne.tag=i;
//        //        [_targetBtnOne viewWithTag:i];
//        //    }
//        
//        //    sender.tag =_targetBtnOne.tag;
//        if (   sender.tag==0) {
//            NSLog(@"######%ld",(long)_targetBtnOne.tag);
//            sender.tag=0;
//        }else if (sender.tag==1){
//            NSLog(@"%%%%%%%%%%^%@",_targetBtnOne);
//            sender.tag=1;
//            
//        }
//        
//        
//        //    _targetBtnOne.tag = j;
//        //   sender.tag =_targetBtnOne.tag;
//        NSLog(@"%ld",(long)_targetBtnOne.tag);
    }
}

- (void)changeIm:(NSNotification *)notification{
    
    
    if (_sucussNum == [notification.object integerValue]) {
    
        _sucessImgView.hidden = NO;
    }
  
}

/**
 *  设置button点击状态下的背景色
 */

- (void)button1BackGroundNormal:(UIButton *)sender
{
    sender.backgroundColor = [UIColor clearColor];
}
- (void)button1BackGroundHighlighted:(UIButton *)sender
{
    sender.backgroundColor = [UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:0.2];
  
}

+(CGFloat)heightWithBoundingWidth:(CGFloat )width Title:(NSString *)title
{
    CGFloat height  = [title boundingRectWithSize:CGSizeMake(width-10-18-6-15, CGFLOAT_MAX)
                                          options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading
                                       attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]}
                                          context:nil].size.height;
    return 40+height+10+20+50;
}

#pragma setter
-(void)setRealValue:(float)realValue
{
    [self setRealValue:realValue Animated:NO];
}

-(void)setTitle:(NSString *)title
{
    _title = title;
    _titleLabel.text = _title;
}

-(void)setRealValue:(float)realValue Animated:(BOOL)animated
{
    _realValue = realValue;
    _valueTF.text = [NSString stringWithFormat:@"%d",(int)(_realValue*_step)];
    [_collectionView setContentOffset:CGPointMake((int)realValue*dialGap, 0) animated:animated];
    

    /**
     *  当大于两岁的时候刻度变化
     */
    if ((int)_realValue>=101) {
        if(!((int)_realValue%2==0)){
            [_collectionView setContentOffset:CGPointMake((int)(realValue)*dialGap+dialGap, 0) animated:animated];
        }
    }
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(ZXScrollView:ChangeValue:)])
    {
        [self.delegate ZXScrollView:self ChangeValue:realValue*_step];
    }
}

#pragma UITextFieldDelegate
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    
    NSString *newStr = [textField.text stringByReplacingCharactersInRange:range withString:string];
    if ([newStr intValue] > _maxValue)
    {
        _valueTF.text = [NSString stringWithFormat:@"%d",_maxValue];
        [self performSelector:@selector(didChangeValue) withObject:nil afterDelay:0];
        return NO;
    }
    else
    {
        _scrollByHand = NO;
        [NSObject cancelPreviousPerformRequestsWithTarget:self];
        [self performSelector:@selector(didChangeValue) withObject:nil afterDelay:1];
        return YES;
    }
}

-(void)didChangeValue
{
    [self setRealValue:[_valueTF.text floatValue]/(float)_step Animated:YES];
}

-(void)deleteAction
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(ZXScrollDidDelete:)])
    {
        [self.delegate ZXScrollDidDelete:self];
    }
}


#pragma mark UICollectionViewDataSource & Delegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 2+_stepNum;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.item == 0 || indexPath.item == _stepNum+1)
    {
        UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"systemCell" forIndexPath:indexPath];
        
        
        UIView *halfView = [cell.contentView viewWithTag:9527];
        if (!halfView)
        {
            if (indexPath.item == 0)
            {
                halfView = [[XKPEHeaderView  alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width/2, 33)];
                XKPEHeaderView *header = (XKPEHeaderView *)halfView;
                header.backgroundColor = [UIColor colorWithRed:32/255.0 green:180/255.0 blue:230/255.0 alpha:1.0];
                header.minValue = _minValue;
                header.unit = _unit;
                [cell.contentView addSubview:header];
            }
            else
            {
                halfView = [[XKPEFooterView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width/2, 33)];
                XKPEFooterView *footer = (XKPEFooterView *)halfView;
                footer.backgroundColor = [UIColor colorWithRed:32/255.0 green:180/255.0 blue:230/255.0 alpha:1.0];
                footer.maxValue = _maxValue;
                footer.unit = _unit;
                [cell.contentView addSubview:footer];
            }
        }
        
        return cell;
    }
    else
    {
        UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"custemCell" forIndexPath:indexPath];
    
        XKPERulerView *ruleView = [cell.contentView viewWithTag:9527];
        if (!ruleView)
        {
            ruleView                 = [[XKPERulerView alloc]initWithFrame:CGRectMake(0, 0, dialGap*4, 34)];
            ruleView.backgroundColor = [UIColor clearColor];
            ruleView.tag             = 9527;
            ruleView.unit            = _unit;
            [cell.contentView addSubview:ruleView];
        }
        ruleView.minValue = _step*10.f*(indexPath.item);
        ruleView.maxValue = _step*10.f*indexPath.item;
        [ruleView setNeedsDisplay];
        
        
        return cell;
    }
}

-(CGSize )collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.item == 0 || indexPath.item == _stepNum+1)
    {
        return CGSizeMake(self.frame.size.width/2, 385.f);
    }
    else
    {
        return CGSizeMake(dialGap*4.0f, 385.f);
    }
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}


- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 0.f;
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 0.f;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    CGPoint point = [[touches anyObject] locationInView:self];
    if (point.y < self.frame.size.height-50-20)
    {
        if (self.delegate && [self.delegate respondsToSelector:@selector(ZXScrollDidTouch:)])
        {
            [self.delegate ZXScrollDidTouch:self];
        }
    }
}

#pragma mark UIScrollViewDelegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (_scrollByHand)
    {
        int value = scrollView.contentOffset.x/(dialGap);
        _valueTF.text = [NSString stringWithFormat:@"%d",value*_step];
        
        if (value*_step ==0 ){
            
            if (_babySexNum ==0) {
                _weightNumLabel.text = @"2.4-4.3kg";
                _heightNumLabel.text = @"45.9-55.1cm";
            }else{
                _weightNumLabel.text = @"2.2-4.0kg";
                _heightNumLabel.text = @"45.5-54.2cm";
            }
        
        }else if (value*_step >0&&value*_step<=4){
            if (_babySexNum ==0) {
                _weightNumLabel.text = @"2.9-5.6kg";
                _heightNumLabel.text = @"49.7-59.5cm";
            }else{
                _weightNumLabel.text = @"2.8-5.1kg";
                _heightNumLabel.text = @"49.0-58.1cm";
            }
        }else if (value*_step >4&&value*_step<=8){
            if (_babySexNum ==0) {
                _weightNumLabel.text = @"3.5-6.8kg";
                _heightNumLabel.text = @"52.9-63.2cm";
            }else{
                _weightNumLabel.text = @"3.3-6.1kg";
                _heightNumLabel.text = @"52.0-61.6cm";
            }
        }else if (value*_step >8&&value*_step<=12){
            if (_babySexNum ==0) {
                _weightNumLabel.text = @"4.1-7.7kg";
                _heightNumLabel.text = @"55.6-66.4cm";
            }else{
                _weightNumLabel.text = @"3.9-7.0kg";
                _heightNumLabel.text = @"54.6-64.5cm";
            }
        }else if (value*_step >12&&value*_step<=16){
            if (_babySexNum ==0) {
                _weightNumLabel.text = @"4.7-8.5kg";
                _heightNumLabel.text = @"58.3-69.1cm";
            }else{
                _weightNumLabel.text = @"4.5-7.7kg";
                _heightNumLabel.text = @"56.9-67.1cm";
            }
        }else if (value*_step >16&&value*_step<=20){
            if (_babySexNum ==0) {
                _weightNumLabel.text = @"5.3-9.2kg";
                _heightNumLabel.text = @"60.5-71.3cm";
            }else{
                _weightNumLabel.text = @"5.0-8.4kg";
                _heightNumLabel.text = @"58.9-69.3cm";
            }
        }else if (value*_step >20&&value*_step<=24){
            if (_babySexNum ==0) {
                _weightNumLabel.text = @"5.9-9.8kg";
                _heightNumLabel.text = @"62.4-73.2cm";
            }else{
                _weightNumLabel.text = @"5.5-9.0kg";
                _heightNumLabel.text = @"60.6-71.2cm";
            }
        }else if (value*_step >24&&value*_step<=32){
            if (_babySexNum ==0) {
                _weightNumLabel.text = @"6.9-10.8kg";
                _heightNumLabel.text = @"65.7-76.3cm";
            }else{
                _weightNumLabel.text = @"6.3-10.1kg";
                _heightNumLabel.text = @"63.7-74.5cm";
            }
        }else if (value*_step >32&&value*_step<=40){
            if (_babySexNum ==0) {
                _weightNumLabel.text = @"7.6-11.7kg";
                _heightNumLabel.text = @"68.3-78.9cm";
            }else{
                _weightNumLabel.text = @"6.9-10.9kg";
                _heightNumLabel.text = @"66.2-77.3cm";
            }
        }else if (value*_step >40&&value*_step<=48){
            if (_babySexNum ==0) {
                _weightNumLabel.text = @"8.1-12.4kg";
                _heightNumLabel.text = @"70.7-81.5cm";
            }else{
                _weightNumLabel.text = @"7.4-11.6kg";
                _heightNumLabel.text = @"68.6-80.0cm";
            }
        }else if (value*_step >48&&value*_step<=60){
            if (_babySexNum ==0) {
                _weightNumLabel.text = @"8.7-13.2kg";
                _heightNumLabel.text = @"73.7-85.1cm";
            }else{
                _weightNumLabel.text = @"8.0-12.4kg";
                _heightNumLabel.text = @"71.9-83.7cm";
            }
        }else if (value*_step >60&&value*_step<=72){
            if (_babySexNum ==0) {
                _weightNumLabel.text = @"9.1-13.9kg";
                _heightNumLabel.text = @"76.3-88.5cm";
            }else{
                _weightNumLabel.text = @"8.5-13.1kg";
                _heightNumLabel.text = @"74.8-87.1cm";
            }
        }else if (value*_step >72&&value*_step<=96){
            if (_babySexNum ==0) {
                _weightNumLabel.text = @"9.9-15.2kg";
                _heightNumLabel.text = @"70.9-94.4cm";
            }else{
                _weightNumLabel.text = @"9.4-14.5kg";
                _heightNumLabel.text = @"79.9-93.0cm";
            }
        }else if (value*_step >96&&value*_step<=100){
            if (_babySexNum ==0) {
                _weightNumLabel.text = @"10.8-16.7kg";
                _heightNumLabel.text = @"84.0-98.4cm";
            }else{
                _weightNumLabel.text = @"10.3-16.2kg";
                _heightNumLabel.text = @"83.2-97.2cm";
            }
        }else if (value*_step >100&&value*_step<=104){
            if (_babySexNum ==0) {
                _weightNumLabel.text = @"11.4-18.3kg";
                _heightNumLabel.text = @"87.3-102.5cm";
            }else{
                _weightNumLabel.text = @"11.2-17.9kg";
                _heightNumLabel.text = @"86.5-101.4cm";
            }
        }else if (value*_step >104&&value*_step<=108){
            if (_babySexNum ==0) {
                _weightNumLabel.text = @"12.1-19.5kg";
                _heightNumLabel.text = @"91.0-107.2cm";
            }else{
                _weightNumLabel.text = @"11.9-19.4kg";
                _heightNumLabel.text = @"90.2-105.7cm";
            }
        }else if (value*_step >108&&value*_step<=112){
            if (_babySexNum ==0) {
                _weightNumLabel.text = @"12.9-20.8kg";
                _heightNumLabel.text = @"94.4-111.5cm";
            }else{
                _weightNumLabel.text = @"12.6-20.7kg";
                _heightNumLabel.text = @"93.5-109.7cm";
            }
        }else if (value*_step >112&&value*_step<=116){
            if (_babySexNum ==0) {
                _weightNumLabel.text = @"13.7-22.1kg";
                _heightNumLabel.text = @"97.7-115.4cm";
            }else{
                _weightNumLabel.text = @"13.2-22.0kg";
                _heightNumLabel.text = @"96.7-113.5cm";
            }
        }else if (value*_step >116&&value*_step<=120){
            if (_babySexNum ==0) {
                _weightNumLabel.text = @"14.4-23.5kg";
                _heightNumLabel.text = @"100.7-119.cm";
            }else{
                _weightNumLabel.text = @"13.8-23.2kg";
                _heightNumLabel.text = @"99.5-117.2cm";
            }
        }else if (value*_step >120&&value*_step<=124){
            if (_babySexNum ==0) {
                _weightNumLabel.text = @"15.2-25.0kg";
                _heightNumLabel.text = @"103.6-122.9cm";
            }else{
                _weightNumLabel.text = @"14.4-24.6kg";
                _heightNumLabel.text = @"102.2-120.9cm";
            }
        }else if (value*_step >124&&value*_step<=128){
            if (_babySexNum ==0) {
                _weightNumLabel.text = @"16.0-26.6kg";
                _heightNumLabel.text = @"106.4-125.8cm";
            }else{
                _weightNumLabel.text = @"15.0-26.2kg";
                _heightNumLabel.text = @"104.8-124.5cm";
            }
        }
     
    }
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    _scrollByHand = YES;
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (!decelerate)//拖拽时没有滑动动画
    {
        [self setRealValue:round(scrollView.contentOffset.x/(dialGap)) Animated:YES];
//        if (_maxValue>100) {
//            [self setRealValue:round(scrollView.contentOffset.x/(dialGap))+1 Animated:YES];
//        }
        
        
    }
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self setRealValue:round(scrollView.contentOffset.x/(dialGap)) Animated:YES];
    
//    if (_maxValue>100) {
//        [self setRealValue:round(scrollView.contentOffset.x/(dialGap))+1 Animated:YES];
//    }
}





/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
