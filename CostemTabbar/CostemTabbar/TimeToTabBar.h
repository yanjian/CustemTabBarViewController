//
//  TimeToTabBar.h
//  CostemTabbar
//
//  Created by IF on 2017/3/3.
//  Copyright © 2017年 zhilifang. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TimeToTabBar;

@protocol TimeToTabBarDelegate <UITabBarDelegate>

@optional
- (void)tabBarDidClickCenterButton:(TimeToTabBar *)tabBar;

@end

@interface TimeToTabBar : UITabBar

@property (nonatomic,assign,getter=isShowCenter) BOOL showCenter;//是否显示中间按钮,默认为YES。显示中间按钮..
@property (nonatomic,weak) id<TimeToTabBarDelegate> tabBarDelegate;


-(instancetype)initTabCenterButton:(UIImage *) centerImage;

-(void)addCenterButonWithImage:(UIImage *)img;

-(void)tabBarWillClickCenterButton:(void(^)(TimeToTabBar * tabBar))clickBlock;

@end
