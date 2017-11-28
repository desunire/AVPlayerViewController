//
//  AQLoadingView.h
//  AQAVPlayerViewController
//
//  Created by desunire on 2017/11/23.
//  Copyright © 2017年 desunire. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AQLoadingView : UIView

/**
 开始动画
 */
- (void)starAnimation;

/**
 停止动画
 */
- (void)stopAnimation;


/** 一次动画所持续时长 默认2秒*/
@property(nonatomic,assign)NSTimeInterval duration;


/** 线条颜色*/
@property (nonatomic, strong) UIColor *strokeColor;

@end
