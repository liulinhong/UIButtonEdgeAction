//
//  ViewController.m
//  testbutton
//
//  Created by LiuLinhong on 16/6/13.
//  Copyright © 2016年 LLH. All rights reserved.
//
//参考文章 http://feihu.me/blog/2015/trigger-condition-of-events-for-uibutton/
//http://stackoverflow.com/questions/14340122/uicontroleventtouchdragexit-triggers-when-100-pixels-away-from-uibutton/30320206#30320206

#import "ViewController.h"

@interface ViewController ()
{
    UIButton *button;
}
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(100, 240, 80, 60);
    [button setTitle:@"离开" forState:UIControlStateNormal];
    [button setTitle:@"进去" forState:UIControlStateHighlighted];
    button.backgroundColor = [UIColor greenColor];
    [self.view addSubview:button];
    
    //添加通知
    [button addTarget:self action:@selector(btnDragged:withEvent:) forControlEvents:UIControlEventTouchDragInside];
    [button addTarget:self action:@selector(btnDragged:withEvent:) forControlEvents:UIControlEventTouchDragOutside];
    
    [button addTarget:self action:@selector(btnTouchUp:withEvent:) forControlEvents:UIControlEventTouchUpInside];
    [button addTarget:self action:@selector(btnTouchUp:withEvent:) forControlEvents:UIControlEventTouchUpOutside];
}

- (void)btnDragged:(UIButton *)sender withEvent:(UIEvent *)event
{
    UITouch *touch = [[event allTouches] anyObject];
    CGFloat boundsExtension = 0.0f;
    CGRect outerBounds = CGRectInset(sender.bounds, -1 * boundsExtension, -1 * boundsExtension);
    BOOL touchOutside = !CGRectContainsPoint(outerBounds, [touch locationInView:sender]);
    if (touchOutside)
    {
        BOOL previewTouchInside = CGRectContainsPoint(outerBounds, [touch previousLocationInView:sender]);
        if (previewTouchInside)
        {
            // UIControlEventTouchDragExit 出来的一刻
            [button setTitle:@"离开" forState:UIControlStateHighlighted];
            NSLog(@"LLH......  出来的一刻");
        }
        else
        {
            // UIControlEventTouchDragOutside 一直在外面
            NSLog(@"LLH......  一直在外面");
        }
    }
    else
    {
        BOOL previewTouchOutside = !CGRectContainsPoint(outerBounds, [touch previousLocationInView:sender]);
        if (previewTouchOutside)
        {
            // UIControlEventTouchDragEnter 进去的一刻
            [button setTitle:@"进去" forState:UIControlStateHighlighted];
            NSLog(@"LLH......  进去的一刻");
        }
        else
        {
            // UIControlEventTouchDragInside 一直在里面
            NSLog(@"LLH......  一直在里面");
        }
    }
}

- (void)btnTouchUp:(UIButton *)sender withEvent:(UIEvent *)event
{
    UITouch *touch = [[event allTouches] anyObject];
    CGFloat boundsExtension = 0.0f;
    CGRect outerBounds = CGRectInset(sender.bounds, -1 * boundsExtension, -1 * boundsExtension);
    BOOL touchOutside = !CGRectContainsPoint(outerBounds, [touch locationInView:sender]);
    if (touchOutside)
    {
        // UIControlEventTouchUpOutside
        //在boundsExtension范围外,不做按钮响应
    }
    else
    {
        // UIControlEventTouchUpInside
        //在boundsExtension范围内,需要做按钮响应
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
