//
//  JBAppDelegate.m
//  JingleBoard
//
//  Created by Max Winde on 28.09.12.
//  Copyright (c) 2012 Max Winde. All rights reserved.
//

#import <DropboxSDK/DropboxSDK.h>
#import "JBAppDelegate.h"

#import "JBDrumPadViewController.h"

@implementation JBAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    DBSession *dropBoxSession = [[DBSession alloc] initWithAppKey:@"fwwqp03rf1ki0yk"
                                                        appSecret:@"wk8yskimdobkx6e"
                                                             root:kDBRootAppFolder];
    [DBSession setSharedSession:dropBoxSession];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    JBDrumPadViewController *viewController = [[JBDrumPadViewController alloc] initWithCollectionViewLayout:flowLayout];
    
    self.viewController = [[UINavigationController alloc] initWithRootViewController:viewController];
    self.window.rootViewController = self.viewController;
    [self.window makeKeyAndVisible];
    
    int64_t delayInSeconds = 0.5;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        if (![DBSession sharedSession].isLinked) {
            [[DBSession sharedSession] linkFromController:self.viewController];
        }
    });
    
    return YES;
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url;
{
    if ([[DBSession sharedSession] handleOpenURL:url]) {
        return YES;
    }
    
    return NO;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
