//
//  ViewController.m
//  NSExceptionDemo
//
//  Created by sunhuayu on 15/12/23.
//  Copyright © 2015年 sunhuayu. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //断言，当某个条件不满足程序执行需求时，强制结束程序。
//    NSAssert(NO, @"  name不能为空");
    
    
    NSArray *array = @[@"123",@"abc"];
    
    [array objectAtIndex:5];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end











