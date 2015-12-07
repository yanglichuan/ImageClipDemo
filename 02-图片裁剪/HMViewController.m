//
//  HMViewController.m
//  02-图片裁剪
//
//  Created by apple on 14-9-4.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "HMViewController.h"

#import "UIImage+Tool.h"

@interface HMViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation HMViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    

    
//    _imageView.image = [UIImage imageWithName:@"阿狸头像" border:10 borderColor:[UIColor redColor]];
    
    [self clipCircle];
    
    
}

- (void)clipCircle
{
    // 圆环的宽度
    CGFloat borderW = 5;
    
    // 加载旧的图片
    UIImage *oldImage =  [UIImage imageNamed:@"阿狸头像"];
    
    // 新的图片尺寸
    CGFloat imageW = oldImage.size.width + 2 * borderW;
    CGFloat imageH = oldImage.size.height + 2 * borderW;
    
    // 设置新的图片尺寸
    CGFloat circirW = imageW > imageH ? imageH : imageW;
    
    // 开启上下文
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(circirW, circirW), NO, 0.0);
    
    // 画大圆
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, circirW, circirW)];
    
    // 获取当前上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    // 添加到上下文
    CGContextAddPath(ctx, path.CGPath);
    
    [[UIColor whiteColor] set];
    
    // 渲染
    CGContextFillPath(ctx);
    
    CGRect clipR = CGRectMake(borderW, borderW, oldImage.size.width, oldImage.size.height);
    
    // 画圆：正切于旧图片的圆
    UIBezierPath *clipPath = [UIBezierPath bezierPathWithOvalInRect:clipR];
    
    // 设置裁剪区域
    [clipPath addClip];
    
    
    // 画图片
    [oldImage drawAtPoint:CGPointMake(borderW, borderW)];
    
    // 获取新的图片
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // 关闭上下文
    UIGraphicsEndImageContext();
    
    _imageView.image = newImage;
}

- (void)clip
{
    // 1.加载旧的图片
    UIImage *oldImage = [UIImage imageNamed:@"阿狸头像"];
    
    // 2.开启上下文
    UIGraphicsBeginImageContextWithOptions(oldImage.size, NO, 0.0);
    
    // 3.画圆：正切于上下文
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, oldImage.size.width, oldImage.size.height)];
    
    // 4.设为裁剪区域
    [path addClip];
    
    // 5.画图片
    [oldImage drawAtPoint:CGPointZero];
    
    
    // 6.生成一个新的图片
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // 7.关闭上下文
    UIGraphicsEndImageContext();
}
@end
