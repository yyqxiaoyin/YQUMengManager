//
//  AppDelegate.m
//  UMengShareDemo
//
//  Created by Mopon on 16/6/14.
//  Copyright © 2016年 Mopon. All rights reserved.
//

#import "AppDelegate.h"
#import "YQUmengManager.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [YQUmengManager setUmengAppKey:@"575f688c67e58e790a000e32"];
    [YQUmengManager setSinaSSOWithSinaAppKey:@"1957158193" appSecret:@"6c1b4191b69d0c4d9c878cbfd4bdb427" RedirectURL:@"http://sns.whalecloud.com/sina2/callback"];
    [YQUmengManager setWXAppId:@"wx881de17eb9530173" appSecret:@"d1fb72815529aa4c01562a7a5e82b4f1" url:@"http://sns.whalecloud.com/sina2/callback"];
    
    return YES;
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


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
/**
 这里处理新浪微博SSO授权之后跳转回来，和微信分享完成之后跳转回来
 */
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    return  [YQUmengManager umengHandleOpenURL:url];
}



@end
