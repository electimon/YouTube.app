//
//  AppDelegate.h
//  Youtube
//
//  Created by electimon on 6/29/19.
//  Copyright (c) 2019 1pwn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>
@property () BOOL restrictRotation;
@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) NSString *apiEndpoint;
@property (strong, nonatomic) NSString *oauthToken;
@property (nonatomic) int defRes;
@property (strong, nonatomic) NSCache *videoImageCache;
@end
