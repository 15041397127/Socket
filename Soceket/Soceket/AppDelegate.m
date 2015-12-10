//
//  AppDelegate.m
//  Soceket
//
//  Created by zhang xu on 15/12/10.
//  Copyright © 2015年 zhang xu. All rights reserved.
//

#import "AppDelegate.h"
@interface AppDelegate ()

@end
/**
 *  
  -Socket技术
      - 基于网络通信
      - 和http协议相比
      - 具体实现过程
      - 长连接,http是短连接
      - http协议用来做超文本传输
      - Socket 什么都可以传 Socket更加底层
  -ios 
     -GCDAsyncSocket <= CFNetWork <=sys/socket.h
     -NSNetService
  -socket 技术
    -TCP/ip和UDP
     -tcp/ip,传输控制协议
     -udp,广播类型协议
     -tcp/ip,会更加安全,三次握手的过程是在传输数据前
     -udp,传输速度更快,不可靠性就大,效率慢
  -winsocket 用在windows
 */


#include <sys/socket.h>
#include <netinet/in.h>
@implementation AppDelegate
{
    //服务端的标识位
    int server_flag;
    
    //客户端的标识位
    int client_flag;
    
    //计算机地址
    struct sockaddr_in addr;
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    int error=-1;
    //服务端
    //1.创建服务端的标识符(int) ipv4 ipv6 流媒体 0
    server_flag=socket(AF_INET, SOCK_STREAM, 0);
    //2.讲服务端的标识符,绑定到一个具体的计算机(ip,port)里sockaddr_in
    addr.sin_port=htons(3009);
    addr.sin_family=AF_INET;
    addr.sin_addr.s_addr=INADDR_ANY;
    
    error=bind(server_flag, (struct sockaddr *)&addr, sizeof(addr));
    //3.服务端要做好能同时处理多少个链接的事情
    error=listen(server_flag, 100);
    //4.服务端做好等待客户端链接请求的准备
    while (1) {
        //5.将收到的客户端链接请求生成一个标志位,作为某个客户端的标识

        client_flag=accept(server_flag, NULL, NULL);
        
        //6.通过客户端的标识位进行消息传输
        char buff[1024];
        int length =recv(client_flag, buff, (long)1024, -1);
        buff[length]='\0';
        printf("client say:%s",buff);
        
        //发送消息...
        send(client_flag, "may name is zhangxu!\n",50,-1);
        //7.关闭取消链接的客户端标识位
        close(client_flag);
    }
    
    //8.
    
    
    
    
    
    
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
