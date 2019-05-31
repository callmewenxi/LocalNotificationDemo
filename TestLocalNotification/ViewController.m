//
//  ViewController.m
//  TestLocalNotification
//
//  Created by 小小文西 on 2019/5/31.
//  Copyright © 2019年 小小文西. All rights reserved.
//

#import "ViewController.h"

#import <UserNotifications/UserNotifications.h>

@interface ViewController ()

@property (nonatomic, strong) UIButton *sendButton;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self.view addSubview:self.sendButton];
    self.sendButton.frame = CGRectMake(0, 0, 200, 50);
    self.sendButton.layer.cornerRadius = 25;
    self.sendButton.layer.masksToBounds = YES;
    self.sendButton.center = self.view.center;
    [self.sendButton addTarget:self action:@selector(sendLocalNotification) forControlEvents:UIControlEventTouchUpInside];
}

- (void)sendLocalNotification {
    NSLog(@"sendLocalNotification");
    [self addCommonLocalNotification];
}

- (void)addCommonLocalNotification {
    UNMutableNotificationContent *content = [[UNMutableNotificationContent alloc] init];
    //标题,有加粗
    content.title = @"Title: Nonolive 录屏推流";
    //副标题.有加粗
    content.subtitle = @"subtitle: 我是subtitle";
    //body,没有加粗,但支持换行
    content.body = @"body: 录屏已开始,请处从这里点击回到App->直播->录屏推流->Start Live";
    //角标数字
    content.badge = @1;
    //推送声音
    content.sound = [UNNotificationSound defaultSound];
    //自定义推送声音
//    content.sound = [UNNotificationSound soundNamed:@"bing.mp3"];
    //定时触发的任务,当repeats设置为YES时,triggerWithTimeInterval不能低于60s,repeats设置为NO时,无限制
    //time interval must be at least 60 if repeating
    
    //添加图片
    NSString *imagePath = [[NSBundle mainBundle] pathForResource:@"apple" ofType:@"png"];
    UNNotificationAttachment *attachment = [UNNotificationAttachment attachmentWithIdentifier:@"image" URL:[NSURL fileURLWithPath:imagePath] options:nil error:nil];
    content.attachments = @[attachment];
    
    //添加额外信息
    content.userInfo = @{@"link":@"https://www.facebook.com/franksIosApp/"};
    
    UNTimeIntervalNotificationTrigger *target = [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:5 repeats:NO];
    target = nil;
    UNNotificationRequest *request = [UNNotificationRequest requestWithIdentifier:@"LocalNotification" content:content trigger:target];
    UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
    [center addNotificationRequest:request withCompletionHandler:^(NSError * _Nullable error) {
        if (!error) {
            NSLog(@"推送成功");
        } else {
            NSLog(@"推送失败");
        }
    }];
}

- (UIButton *)sendButton {
    if (!_sendButton) {
        _sendButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_sendButton setTitle:@"Send Notification" forState:UIControlStateNormal];
        _sendButton.backgroundColor = [UIColor darkGrayColor];
        _sendButton.titleLabel.font = [UIFont systemFontOfSize:20];
    }
    return _sendButton;
}


@end
