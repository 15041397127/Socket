//
//  AppDelegate.m
//  Socket conncet
//
//  Created by zhang xu on 15/12/10.
//  Copyright © 2015年 zhang xu. All rights reserved.
//

#import "AppDelegate.h"
#include <sys/socket.h>
#include <netinet/in.h>
#include <arpa/inet.h>
@interface AppDelegate ()

@end

@implementation AppDelegate
{
    struct sockaddr_in server;
    
}



- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    int error =-1;
    
    int client_flag=socket(AF_INET, SOCK_STREAM, 0);
    
    server.sin_family=AF_INET;
    server.sin_port=htons(10000);
    server.sin_addr.s_addr=inet_addr("172.18.16.37");
    
    error=connect(client_flag, (struct sockaddr *)&server, sizeof(server));
    
    char message[] = "this is zhangxu!\n";
    send(client_flag, message, sizeof(message), 0);
    
    char buff[1024];
    
    int length=recv(client_flag, buff, sizeof(buff), 0);
    
    buff[length]='\0';
    printf("server say:%s\n",buff);
//    close(client_flag);
    
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

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
