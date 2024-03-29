//
//  AppDelegate.m
//  Youtube
//
//  Created by electimon on 6/29/19.
//  Copyright (c) 2019 1pwn. All rights reserved.
//

#import "AppDelegate.h"
#include "TuberAPI.h"

@implementation AppDelegate
@synthesize apiEndpoint;
@synthesize oauthToken;
@synthesize videoImageCache;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSError *error;
    NSString *urlString = @"https://oauth2.googleapis.com/token";
    NSURL *url = [NSURL URLWithString:urlString];
    videoImageCache = [NSCache new];
    
    if ([defaults objectForKey:@"refreshToken"]) {
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
        
        NSString *parameterString = [NSString stringWithFormat:@"client_id=277136978076-las5e1p14oe1vg6m357279bqqc97etcn.apps.googleusercontent.com&grant_type=refresh_token&refresh_token=%@", [defaults valueForKey:@"refreshToken"]];
        
        NSLog(@"%@",parameterString);
        
        [request setHTTPMethod:@"POST"];
        
        [request setURL:url];
        
        NSData *postData = [parameterString dataUsingEncoding:NSUTF8StringEncoding];
        
        [request setHTTPBody:postData];
        
        NSData *finalData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:&error];
        
        NSLog(@"honour = %@", [[NSString alloc] initWithData:finalData encoding:NSUTF8StringEncoding]);
        error = nil;
        NSDictionary *finalArray = [NSJSONSerialization JSONObjectWithData:finalData options:kNilOptions error:&error];
        if (error != nil || [finalArray objectForKey:@"error"]) {
            // error contains something gay check it
            NSLog(@"a shack deep in the forest no one ever comes near");
            if ([[finalArray valueForKey:@"error"] isEqualToString:@"invalid_grant"]) {
                // ALert user that the token in settings needs to be refreshed
                
            }
        } else {
            NSLog(@"finallyArray = %@", finalArray);
            [defaults setValue:[finalArray valueForKey:@"access_token"] forKey:@"accessToken"];
            [defaults setValue:[finalArray valueForKey:@"expires_in"] forKey:@"tokenExpiresIn"];
            [defaults synchronize];
        }
    }
    
    if ([TuberAPI initialize]) {
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
