//
//  TimeToTabBar.m
//  CostemTabbar
//
//  Created by IF on 2017/3/3.
//  Copyright © 2017年 zhilifang. All rights reserved.
//

#import "TimeToTabBar.h"

typedef void(^ClickCenterButtonBlock)(TimeToTabBar * tabBar);

@interface TimeToTabBar ()

@property (nonatomic,strong) UIButton * centerButton;
@property (nonatomic,strong) ClickCenterButtonBlock clickBlock;
@end

@implementation TimeToTabBar


-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
       
        _showCenter = YES ;
        
        [self addSubview:self.centerButton];
    }
    return self;
}


-(instancetype)initTabCenterButton:(UIImage *) centerImage{
    if (self = [super init]) {
        _showCenter = YES ;
        
        [self addSubview:self.centerButton];
        
        [self addCenterButonWithImage:centerImage];
        
    }
    return self;
}


-(void)tabBarWillClickCenterButton:(void(^)(TimeToTabBar * tabBar))clickBlock{
    if(clickBlock){
        self.clickBlock = clickBlock ;
    }
}


- (void)clickCenterButton:(UIButton *)sender
{
    if (self.clickBlock) {
        self.clickBlock(self);
    }
    // 通知代理
    if ([self.tabBarDelegate respondsToSelector:@selector(tabBarDidClickCenterButton:)]) {
        [self.tabBarDelegate tabBarDidClickCenterButton:self];
    }
    
}



-(void)addCenterButonWithImage:(UIImage *)img{
    if (!img) { return; }
    
    [self.centerButton setImage:img forState:UIControlStateNormal];
    CGRect  tmpRect = self.centerButton.frame ;
    tmpRect.size = self.centerButton.currentImage.size ;
    self.centerButton.frame = tmpRect ;
   
    [self setNeedsLayout]; 
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    if (!_showCenter) { return; }
    
    // 1.设置加号按钮的位置
    CGPoint temp = self.centerButton.center;
    temp.x = self.frame.size.width * 0.5f;
    temp.y = self.frame.size.height* 0.5f;
    self.centerButton.center  = temp;
    
    // 2.设置其它UITabBarButton的位置和尺寸
    CGFloat tabbarButtonW = self.frame.size.width / 5;
    CGFloat tabbarButtonIndex = 0;
    for (UIView *child in self.subviews) {
        Class class = NSClassFromString(@"UITabBarButton");
        if ([child isKindOfClass:class]) {
            // 设置宽度
            CGRect temp1 =  child.frame;
            temp1.size.width = tabbarButtonW;
            temp1.origin.x   = tabbarButtonIndex * tabbarButtonW;
            child.frame = temp1;
            // 增加索引
            tabbarButtonIndex++;
            if (tabbarButtonIndex == 2) {
                tabbarButtonIndex++;
            }
        }
    }
}


-(void)setShowCenter:(BOOL)showCenter{
    _showCenter = showCenter;
    if (!_showCenter) {
        self.centerButton.hidden  = YES ;
    }else{
        self.centerButton.hidden  = NO ;
    }
    
    [self setNeedsLayout];
}


-(UIButton *)centerButton{
    if (!_centerButton) {
        UIButton * centerBtn = [[UIButton alloc] init];
        
        [centerBtn addTarget:self action:@selector(clickCenterButton:) forControlEvents:UIControlEventTouchUpInside];
        
        _centerButton = centerBtn ;
    }
    return _centerButton ;
}

@end
