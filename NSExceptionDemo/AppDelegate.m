//
//  AppDelegate.m
//  NSExceptionDemo
//
//  Created by sunhuayu on 15/12/23.
//  Copyright © 2015年 sunhuayu. All rights reserved.
//

#import "AppDelegate.h"
#import <sys/utsname.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    
    NSString *exceptionInfo = [[NSUserDefaults standardUserDefaults] objectForKey:@"exceptionInfo"];
    
    if (exceptionInfo) {
        //说明上次运行崩溃了
        //......上传崩溃信息
        
        //上传后删除这次崩溃信息
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"exceptionInfo"];
    }
    
    
    
    //当程序启动完成时，立刻绑定一个函数，当程序将要崩溃时，就会调用这个函数，把崩溃信息作为参数传入函数中。
    NSSetUncaughtExceptionHandler(&getAnException);
    
    
    return YES;
}


void getAnException(NSException *exception){
    //NSLog(@"程序马上要崩溃了");
    
    NSLog(@"---name:%@",exception.name);
    
    NSLog(@"---reason%@",exception.reason);
    
    NSLog(@"---userInfo%@",exception.userInfo);
    
    NSLog(@"---StackAddress%@",exception.callStackReturnAddresses);
    
    NSLog(@"---StackSymbol%@",exception.callStackSymbols);
    
    
    //统计崩溃时间。
    NSDate *date = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy年MM月dd日 HH:mm:ss"];
    NSString *time = [formatter stringFromDate:date];
    
    //统计用户信息。（用户名。）
    
    //统计设备信息和系统信息
    UIDevice *device = [UIDevice currentDevice];
    
    //NSLog(@"name--%@",device.name);
    //NSLog(@"model--%@",device.model);
    //NSLog(@"systemName--%@",device.systemName);
    NSLog(@"systemVersion--%@",device.systemVersion);
    NSLog(@"UUID--%@",device.identifierForVendor);
    
    
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *deviceString = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    
    //把崩溃信息整合。
    NSString *exceptionInfo = [NSString stringWithFormat:@"%@-%@-%@-%@-%@-%@",exception.name,exception.reason,exception.callStackSymbols,device.systemVersion,deviceString,time];
    
    //把本次崩溃信息保存在本地。下次程序启动时首先查看有没有崩溃信息，有的话上传服务器。
    
    [[NSUserDefaults standardUserDefaults] setObject:exceptionInfo forKey:@"exceptionInfo"];
    
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
