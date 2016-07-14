//
//  XKPEBabySliderView.h
//  XKXKBabyDevelopmentThird
//
//  Created by 张旭 on 16/7/4.
//  Copyright © 2016年 zhangXu. All rights reserved.
//

#import <UIKit/UIKit.h>
@class XKPEBabySliderView;
typedef NS_ENUM(NSInteger, XKBabySex){
    male = 1,
    female = 2
};
@protocol ZXScrollViewDelegate <NSObject>
-(void)ZXScrollView:(XKPEBabySliderView *)Sldier ChangeValue:(int)value;

@optional
-(void)ZXScrollDidDelete:(XKPEBabySliderView *)slider;
-(void)ZXScrollDidTouch:(XKPEBabySliderView *)slider;

@end
@protocol ZXPushVCDelegate<NSObject>

- (void)PushVC:(UIButton*)sender;
@end

@interface XKPEBabySliderView : UIView
@property (nonatomic, copy ) NSString *title;
@property (nonatomic, copy ,  readonly) NSString *unit;
@property (nonatomic, assign ,readonly) int minValue;
@property (nonatomic, assign ,readonly) int maxValue;
@property (nonatomic, assign ,readonly) int step;
@property (nonatomic, weak) id<ZXScrollViewDelegate> delegate;
@property (nonatomic, weak) id<ZXPushVCDelegate> delegateOne;
@property (nonatomic ,assign) XKBabySex babySexNum;
@property (nonatomic, assign) float realValue;

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

@property (nonatomic, strong) UIButton         *targetBtnOne;
@property (nonatomic, strong) UIButton         *targetBtnTwo;
@property (nonatomic, strong) UIButton         *targetBtnThree;
@property (nonatomic, strong) UIButton         *targetBtnFour;
@property (nonatomic, strong) UIButton         *targetBtnFive;
@property (nonatomic, strong) UIImageView      *sucessImgView;

@property (nonatomic, assign)NSInteger sucussNum;
-(void)setRealValue:(float)realValue Animated:(BOOL)animated;

-(instancetype)initWithFrame:(CGRect)frame Title:(NSString *)title MinValue:(int)minValue MaxValue:(int)maxValue Step:(int)step Unit:(NSString *)unit HasDeleteBtn:(BOOL)hasDeleteBtn;
+(CGFloat)heightWithBoundingWidth:(CGFloat )width Title:(NSString *)title;

@end
