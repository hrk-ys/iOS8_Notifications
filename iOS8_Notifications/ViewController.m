//
//  ViewController.m
//  iOS8_Notifications
//
//  Created by Hiroki Yoshifuji on 2014/06/28.
//  Copyright (c) 2014年 Hiroki Yoshifuji. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)tappedRegisteringButton:(id)sender {
    UIUserNotificationType types = UIUserNotificationTypeBadge |
    UIUserNotificationTypeSound | UIUserNotificationTypeAlert;
    
    UIUserNotificationSettings *mySettings = [UIUserNotificationSettings
                                              settingsForTypes:types categories:nil];
    [[UIApplication sharedApplication] registerUserNotificationSettings:mySettings];
}

- (IBAction)tappedGettingButton:(id)sender {
    
    UIUserNotificationSettings *currentSettings = [[UIApplication
                                                    sharedApplication] currentUserNotificationSettings];
    
    NSLog(@"currentSettings:%@", currentSettings);

}


// ------------


- (IBAction)tappedNotificationActionRegisteringButton:(id)sender {
    
    // Actionの作成
    
    UIMutableUserNotificationAction *acceptAction = [[UIMutableUserNotificationAction alloc] init];
    acceptAction.identifier = @"ACT1_IDENTIFIER";
    acceptAction.title = @"Act1";
    acceptAction.activationMode = UIUserNotificationActivationModeBackground;
    acceptAction.destructive = NO;
    acceptAction.authenticationRequired = NO;
    

    UIMutableUserNotificationAction *maybeAction = [[UIMutableUserNotificationAction alloc] init];
    maybeAction.identifier = @"ACT2_IDENTIFIER";
    maybeAction.title = @"Act2";
    maybeAction.activationMode = UIUserNotificationActivationModeBackground;
    maybeAction.destructive = YES;
    maybeAction.authenticationRequired = YES;
    
    UIMutableUserNotificationAction *act3 = [[UIMutableUserNotificationAction alloc] init];
    act3.identifier = @"ACT3_IDENTIFIER";
    act3.title = @"Act3";
    act3.activationMode = UIUserNotificationActivationModeForeground;
    act3.destructive = NO;
    act3.authenticationRequired = NO;

    UIMutableUserNotificationAction *act4 = [[UIMutableUserNotificationAction alloc] init];
    act4.identifier = @"ACT4_IDENTIFIER";
    act4.title = @"Act4";
    act4.activationMode = UIUserNotificationActivationModeForeground;
    act4.destructive = NO;
    act4.authenticationRequired = YES;

    
    // Category の作成
    
    UIMutableUserNotificationCategory *inviteCategory =
    [[UIMutableUserNotificationCategory alloc] init];
    
    inviteCategory.identifier = @"INVITE_CATEGORY";
    
    [inviteCategory setActions:@[act4, acceptAction, maybeAction, act3]
                    forContext:UIUserNotificationActionContextDefault];
    
     // 設定
    
    NSSet *categories = [NSSet setWithObject:inviteCategory];
    
    UIUserNotificationSettings *settings =
    [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeBadge |
     UIUserNotificationTypeSound | UIUserNotificationTypeAlert
                                      categories:categories];
    
    [[UIApplication sharedApplication]
     registerUserNotificationSettings:settings];

}


- (IBAction)tappedLocalNotificationButton:(id)sender {

    UILocalNotification *notification = [[UILocalNotification alloc] init];


    NSDate* date = [NSDate date];
    notification.fireDate = [date dateByAddingTimeInterval:5];
    notification.alertBody = @"Fire!";
    notification.alertAction = @"OPEN";
    notification.timeZone = [NSTimeZone localTimeZone];
    notification.category = @"INVITE_CATEGORY";

    
    [[UIApplication sharedApplication] scheduleLocalNotification:notification];
}

@end
