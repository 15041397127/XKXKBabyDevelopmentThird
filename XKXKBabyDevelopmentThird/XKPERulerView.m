//
//  XKPERulerView.m
//  XKXKBabyDevelopmentThird
//
//  Created by 张旭 on 16/7/4.
//  Copyright © 2016年 zhangXu. All rights reserved.
//

#import "XKPERulerView.h"
#import "XKCircleMacros.h"
@implementation XKPERulerView

/**
 *  绘制标尺view
 *
 *  @param rect rect
 */
-(void)drawRect:(CGRect)rect
{
    
    
//    UIButton *bt = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 20, 10)];
//    bt.backgroundColor = [UIColor cyanColor];
//    [self addSubview:bt];
    
    //计算位置
    CGFloat startX = 0;
    
    CGFloat lineCenterX = dialGap;
    CGFloat shortLineY = 50- dialShort;
    CGFloat longLineY = 50 - dialLong;
    CGFloat bottomY = 0;
//    
//    if (_maxValue == 0)
//    {
//        _maxValue = 1000;
//    }
    CGFloat step = (_maxValue-_minValue);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetStrokeColorWithColor(context, [UIColor whiteColor].CGColor);
    //CGContextSetRGBStrokeColor(context, dialColorGrayscale, dialColorGrayscale, dialColorGrayscale, 1);//设置线的颜色, 如果不设置默认是黑色的
    CGContextSetLineWidth(context, 1);//设置线的宽度, 默认是1像素
    CGContextSetLineCap(context, kCGLineCapButt);
    for (int i = 0; i<320; i++)
    {

        
        
        if (i%4 == 0)
        {

            CGContextMoveToPoint(context,startX + lineCenterX*i, 10);//起使点
            _Num= [NSString stringWithFormat:@"%.f%@",(i*step+_minValue)/10,_unit];

            NSDictionary *attribute = @{NSFontAttributeName:textRulerFont,NSForegroundColorAttributeName:[UIColor colorWithWhite:textColorGrayscale alpha:1]};
            CGFloat width = [_Num boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX) options:0 attributes:attribute context:nil].size.width;
            [_Num drawInRect:CGRectMake(startX + lineCenterX*i-width/2, longLineY-14, width, 14) withAttributes:attribute];
            
//            if (i<=24) {
//                _Num= [NSString stringWithFormat:@"%.f%@",(i*step+_minValue)/10,_unit];
//
//            }else if (i==25){
//                
//                _Num = @"两岁半";
//            }else if (i==26){
//                
//                _Num = @"三周岁";
//            }

            
           


        }else if (_maxValue>250&&!(i%2==0)){
        
            CGContextMoveToPoint(context,startX +  lineCenterX*i,0);//起使点

        }
        else
        {
            CGContextMoveToPoint(context,startX +  lineCenterX*i, 5);//起使点
        }
        CGContextAddLineToPoint(context,startX +  lineCenterX*i, bottomY);
        CGContextStrokePath(context);//开始绘制
        
    }
    

}




/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
