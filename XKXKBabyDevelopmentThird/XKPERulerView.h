//
//  XKPERulerView.h
//  XKXKBabyDevelopmentThird
//
//  Created by 张旭 on 16/7/4.
//  Copyright © 2016年 zhangXu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XKPERulerView : UIView
@property (nonatomic, assign) int minValue;
@property (nonatomic, assign) int maxValue;
@property (nonatomic, copy) NSString *unit;
@property (nonatomic, strong)NSString *Num;
@property (nonatomic, strong)NSString *Num1;
@end
