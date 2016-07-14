//
//  XKView.h
//  XKBabyDevelopment
//
//  Created by 张旭 on 16/6/18.
//  Copyright © 2016年 zhangXu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XKPEBabyTargetDrawView : UIView
@property (nonatomic ,strong)UIImageView *navView;
@property (nonatomic ,strong)UIButton *babyButton;
@property (nonatomic ,strong)UIImageView *maskImgView;
@property (nonatomic ,strong)UIView  *rulerView;
@property (nonatomic ,strong)UILabel *weightLabel;
@property (nonatomic ,strong)UILabel *weightNumLabel;
@property (nonatomic ,strong)UILabel *heightLabel;
@property (nonatomic ,strong)UILabel *heightNumLabel;
@property (nonatomic ,strong)UIView *backViewOne;
@property (nonatomic ,strong)UIView *backViewTwo;
@property (nonatomic ,strong)UIView *backViewTrd;
@property (nonatomic ,strong)UIView *backViewfour;
@property (nonatomic ,strong)UIView *backViewfive;

-(id)initWithFrame:(CGRect)frame;


@end
