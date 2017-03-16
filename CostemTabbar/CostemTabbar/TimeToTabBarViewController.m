//
//  TimeToTabBarViewController.m
//  Timeto
//
//  Created by IF on 2017/3/3.
//  Copyright © 2017年 zhilifang. All rights reserved.
//

#import "TimeToTabBarViewController.h"
#import "TimeToTabBar.h"
#import "TimeToDiscoverViewController.h"
#import "GoMainViewController.h"
#import "GoActiveListViewController.h"
#import "GoAddFriendViewController.h"
#import "GoSettingsVC.h"

@interface TimeToTabBarViewController ()<TimeToTabBarDelegate,UITabBarControllerDelegate>

@property (nonatomic,strong) TimeToDiscoverViewController  *discoverVC  ;
@property (nonatomic,strong) GoActiveListViewController    *myActivityVC;
@property (nonatomic,strong) GoAddFriendViewController     *friendVC;
@property (nonatomic,strong) GoSettingsVC                  *setingVC;
@end

@implementation TimeToTabBarViewController

+(void)initialize{
   // [[UITabBar appearance] setBackgroundImage:[UIImage imageNamed:@"tabbar-light"]];
    NSDictionary *dict = @{  NSForegroundColorAttributeName:[UIColor orangeColor] };
    [[UITabBarItem appearance] setTitleTextAttributes:dict forState:UIControlStateSelected];
}

- (void)viewDidLoad {
    [super viewDidLoad];
   
    TimeToTabBar *tabBar = [[TimeToTabBar alloc] initTabCenterButton:[UIImage imageNamed:@"tabBar_3"]];
    tabBar.tabBarDelegate = self;
    [self setValue:tabBar forKeyPath:@"tabBar"];

    self.delegate = self;
    
    // 初始化所有的自控制器
    [self setupAllChildController];
}


-(void)setupAllChildController{
    
    // 1.发现
    TimeToDiscoverViewController *discoverVC = [[TimeToDiscoverViewController alloc] init];
    [self setNavOneChildViewController:discoverVC title: @"发现" image:@"tabBar_1"];
    self.discoverVC = discoverVC ;
    
    // 2.我的活动
    GoActiveListViewController *myActivityVC = [[GoActiveListViewController alloc] init];
    [self setNavOneChildViewController:myActivityVC  title:@"我的活动" image:@"tabBar_2"];
    self.myActivityVC = myActivityVC ;
    
    // 3.好友
    GoAddFriendViewController *friendVC = [[GoAddFriendViewController alloc] init];
    [self setNavOneChildViewController:friendVC title:@"好友" image:@"tabBar_4"];
    self.friendVC = friendVC ;
    
    // 3.我的
    GoSettingsVC *setingVC = [[GoSettingsVC alloc] init];
    [self setNavOneChildViewController:setingVC title:@"我的" image:@"tabBar_5"];
    self.setingVC = setingVC ;

}


/*
 *初始化一个子控制器的方法
 */
- (void)setNavOneChildViewController:(UIViewController *)vc title:(NSString *)title image:(NSString *)image {
    vc.tabBarItem.title = title;
    vc.tabBarItem.image = [self imageRenderingModeAlwaysOriginal:image];
    NSString *selImage  = [NSString stringWithFormat:@"%@_Sel",image];
    vc.tabBarItem.selectedImage = [self imageRenderingModeAlwaysOriginal:selImage];
   
    [self addChildViewController:[[UINavigationController alloc] initWithRootViewController:vc]];
}


- (void)tabBarDidClickCenterButton:(TimeToTabBar *)tabBar{
    GoMainViewController * mainVC = [[GoMainViewController alloc] init];
    
    [self presentViewController:mainVC animated:YES completion:^{
        
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIImage *)imageRenderingModeAlwaysOriginal:(NSString *)imageName {
    UIImage *image = [UIImage imageNamed:imageName];
    return [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}

@end
