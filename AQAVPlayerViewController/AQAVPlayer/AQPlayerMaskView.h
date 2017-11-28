//
//  AQPlayerMaskView.h
//  AQAVPlayerViewController
//
//  Created by desunire on 2017/11/23.
//  Copyright © 2017年 desunire. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AQSlider.h"
#import "AQLoadingView.h"

@protocol AQPlayerMaskViewDelegate <NSObject>
/**返回按钮代理*/
- (void)aq_backButtonAction:(UIButton *)button;
/**播放按钮代理*/
- (void)aq_playButtonAction:(UIButton *)button;
/**全屏按钮代理*/
- (void)aq_fullButtonAction:(UIButton *)button;
/**开始滑动*/
- (void)aq_progressSliderTouchBegan:(AQSlider *)slider;
/**滑动中*/
- (void)aq_progressSliderValueChanged:(AQSlider *)slider;
/**滑动结束*/
- (void)aq_progressSliderTouchEnded:(AQSlider *)slider;
/**失败按钮代理*/
- (void)aq_failButtonAction:(UIButton *)button;
@end


@interface AQPlayerMaskView : UIButton

/**顶部工具条*/
@property (nonatomic,strong) UIView *topToolBar;
/**底部工具条*/
@property (nonatomic,strong) UIView *bottomToolBar;
/**转子*/
@property (nonatomic,strong) AQLoadingView *activity;
/**顶部工具条返回按钮*/
@property (nonatomic,strong) UIButton *backButton;
/**底部工具条播放按钮*/
@property (nonatomic,strong) UIButton *playButton;
/**底部工具条全屏按钮*/
@property (nonatomic,strong) UIButton *fullButton;
/**底部工具条当前播放时间*/
@property (nonatomic,strong) UILabel *currentTimeLabel;
/**底部工具条视频总时间*/
@property (nonatomic,strong) UILabel *totalTimeLabel;
/**缓冲进度条*/
@property (nonatomic,strong) UIProgressView *progress;
/**播放进度条*/
@property (nonatomic,strong) AQSlider *slider;
/**加载失败按钮*/
@property (nonatomic,strong) UIButton *failButton;
/**代理*/
@property (nonatomic,weak) id<AQPlayerMaskViewDelegate> delegate;
/**进度条背景颜色*/
@property (nonatomic,strong) UIColor *progressBackgroundColor;
/**缓冲条缓冲进度颜色*/
@property (nonatomic,strong) UIColor *progressBufferColor;
/**进度条播放完成颜色*/
@property (nonatomic,strong) UIColor *progressPlayFinishColor;

@end
