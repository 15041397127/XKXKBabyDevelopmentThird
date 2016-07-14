//
//  ViewController.h
//  XKXKBabyDevelopmentThird
//
//  Created by 张旭 on 16/7/4.
//  Copyright © 2016年 zhangXu. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^RetrunImg)(NSInteger tag);
@interface ViewController : UIViewController
@property (nonatomic, copy) RetrunImg block;
- (void)returnTag:(RetrunImg)block ;
@end

