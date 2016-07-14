//
//  XKPEFooterView.m
//  XKXKBabyDevelopmentThird
//
//  Created by 张旭 on 16/7/4.
//  Copyright © 2016年 zhangXu. All rights reserved.
//

#import "XKPEFooterView.h"
#import "XKCircleMacros.h"
@implementation XKPEFooterView

-(void)drawRect:(CGRect)rect
{
    CGFloat longLineY = 50 - dialLong;
    CGContextRef context = UIGraphicsGetCurrentContext();
//    CGContextSetRGBStrokeColor(context, dialColorGrayscale, dialColorGrayscale, dialColorGrayscale, 1);//设置线的颜色, 如果不设置默认是黑色的
    CGContextSetLineWidth(context, 1.0);//设置线的宽度, 默认是1像素
    CGContextSetLineCap(context, kCGLineCapButt);
    
    CGContextMoveToPoint(context,0, 10);//起使点
    NSString *Num = [NSString stringWithFormat:@"%d%@",_maxValue,_unit];
    if ([Num floatValue]>1000000)
    {
        Num = [NSString stringWithFormat:@"%.f万%@",[Num floatValue]/10000.f,_unit];
    }
    
    NSDictionary *attribute = @{NSFontAttributeName:textRulerFont,NSForegroundColorAttributeName:[UIColor colorWithWhite:textColorGrayscale alpha:1]};
    CGFloat width = [Num boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX) options:0 attributes:attribute context:nil].size.width;
    [Num drawInRect:CGRectMake(0-width/2, longLineY-14, width, 14) withAttributes:attribute];
    CGContextAddLineToPoint(context,0, 0);
    CGContextStrokePath(context);//开始绘制
}





/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
