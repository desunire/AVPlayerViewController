//
//  AQPlayerMaskView.m
//  AQAVPlayerViewController
//
//  Created by desunire on 2017/11/23.
//  Copyright © 2017年 desunire. All rights reserved.
//

#import "AQPlayerMaskView.h"
#import "AQSlider.h"

//间隙
#define Padding        10
//顶部底部工具条高度
#define ToolBarHeight     50

@implementation AQPlayerMaskView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self initViews];
    }
    return self;
}
- (void)initViews{
    [self addSubview:self.topToolBar];
    [self addSubview:self.bottomToolBar];
    [self addSubview:self.activity];
    [self addSubview:self.failButton];
    [self.topToolBar addSubview:self.backButton];
    [self.bottomToolBar addSubview:self.playButton];
    [self.bottomToolBar addSubview:self.fullButton];
    [self.bottomToolBar addSubview:self.currentTimeLabel];
    [self.bottomToolBar addSubview:self.totalTimeLabel];
    [self.bottomToolBar addSubview:self.progress];
    [self.bottomToolBar addSubview:self.slider];
    self.topToolBar.backgroundColor = [UIColor colorWithRed:0.00000f green:0.00000f blue:0.00000f alpha:0.20000f];
    self.bottomToolBar.backgroundColor = [UIColor colorWithRed:0.00000f green:0.00000f blue:0.00000f alpha:0.20000f];
}
#pragma mark - 约束
- (void)makeConstraints{
    
    
    //顶部工具条
    self.topToolBar.frame = CGRectMake(0, 0, self.frame.size.width, ToolBarHeight);
    
    
    //底部工具条
    
    self.bottomToolBar.frame = CGRectMake(0, self.frame.size.height-ToolBarHeight, self.frame.size.width, ToolBarHeight);
    
    //转子
    
//    self.activity.center = self.center;
    [self.activity setFrame:CGRectMake(self.center.x-20, self.center.y-20, 40, 40)];
    
    
    //返回按钮
    
    CGFloat backButtonWidth = self.topToolBar.frame.size.height-Padding*2;
    
    self.backButton.frame = CGRectMake(Padding, Padding, backButtonWidth, backButtonWidth);
    
    
    //播放按钮
    
    self.playButton.frame = CGRectMake(Padding, Padding, backButtonWidth, backButtonWidth);
    
    //全屏按钮
    
    self.fullButton.frame = CGRectMake(self.frame.size.width-Padding-backButtonWidth,0.5*ToolBarHeight-0.5*backButtonWidth, backButtonWidth,backButtonWidth);
    
    //当前播放时间
    
    self.currentTimeLabel.frame = CGRectMake(Padding*2+backButtonWidth, 0.5*ToolBarHeight-10, 45, 20);
    
    //总时间
    
    self.totalTimeLabel.frame = CGRectMake(self.frame.size.width-Padding-45-backButtonWidth, 0.5*ToolBarHeight-10, 45, 20);
    
    //缓冲条
    self.progress.frame = CGRectMake(Padding*2+backButtonWidth+Padding+45, 0.5*ToolBarHeight, self.frame.size.width-Padding*4-45*2-backButtonWidth*2, 2);
    
    
    //滑杆
    
    self.slider.frame = CGRectMake(Padding+Padding+backButtonWidth+Padding+45, 0.5*ToolBarHeight, self.frame.size.width-Padding*4-45*2-backButtonWidth*2, 2);
    
    
    //失败按钮
    self.failButton.frame = CGRectMake(self.center.x-100, self.center.y-20, 200, 40);
//    self.failButton.center = self.center;
    
}
#pragma mark -- 设置颜色
-(void)setProgressBackgroundColor:(UIColor *)progressBackgroundColor{
    _progressBackgroundColor = progressBackgroundColor;
    _progress.trackTintColor = progressBackgroundColor;
}
-(void)setProgressBufferColor:(UIColor *)progressBufferColor{
    _progressBufferColor        = progressBufferColor;
    _progress.progressTintColor = progressBufferColor;
}
-(void)setProgressPlayFinishColor:(UIColor *)progressPlayFinishColor{
    _progressPlayFinishColor      = progressPlayFinishColor;
    _slider.minimumTrackTintColor = _progressPlayFinishColor;
}
#pragma mark - 懒加载
//顶部工具条
- (UIView *) topToolBar{
    if (_topToolBar == nil){
        _topToolBar = [[UIView alloc] init];
        _topToolBar.userInteractionEnabled = YES;
    }
    return _topToolBar;
}
//底部工具条
- (UIView *) bottomToolBar{
    if (_bottomToolBar == nil){
        _bottomToolBar = [[UIView alloc] init];
        _bottomToolBar.userInteractionEnabled = YES;
    }
    return _bottomToolBar;
}
//转子
- (AQLoadingView *) activity{
    if (_activity == nil){
        _activity = [[AQLoadingView alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
        _activity.strokeColor = [UIColor whiteColor];
        [_activity starAnimation];
    }
    return _activity;
}
//返回按钮
- (UIButton *) backButton{
    if (_backButton == nil){
        _backButton = [[UIButton alloc] init];
        [_backButton setImage:[UIImage imageNamed:@"backBtn"] forState:UIControlStateNormal];
        [_backButton setImage:[UIImage imageNamed:@"backBtn"] forState:UIControlStateHighlighted];
        [_backButton addTarget:self action:@selector(backButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _backButton;
}
//播放按钮
- (UIButton *) playButton{
    if (_playButton == nil){
        _playButton = [[UIButton alloc] init];
        [_playButton setImage:[UIImage imageNamed:@"playBtn"] forState:UIControlStateNormal];
        [_playButton setImage:[UIImage imageNamed:@"pauseBtn"] forState:UIControlStateSelected];
        [_playButton addTarget:self action:@selector(playButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _playButton;
}
//全屏按钮
- (UIButton *) fullButton{
    if (_fullButton == nil){
        _fullButton = [[UIButton alloc] init];
        [_fullButton setImage:[UIImage imageNamed:@"maxBtn"] forState:UIControlStateNormal];
        [_fullButton setImage:[UIImage imageNamed:@"minBtn"] forState:UIControlStateSelected];
        [_fullButton addTarget:self action:@selector(fullButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _fullButton;
}
//当前播放时间
- (UILabel *) currentTimeLabel{
    if (_currentTimeLabel == nil){
        _currentTimeLabel = [[UILabel alloc] init];
        _currentTimeLabel.textColor = [UIColor whiteColor];
        _currentTimeLabel.adjustsFontSizeToFitWidth = YES;
        _currentTimeLabel.text = @"00:00";
        _currentTimeLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _currentTimeLabel;
}
//总时间
- (UILabel *) totalTimeLabel{
    if (_totalTimeLabel == nil){
        _totalTimeLabel = [[UILabel alloc] init];
        _totalTimeLabel.textColor = [UIColor whiteColor];
        _totalTimeLabel.adjustsFontSizeToFitWidth = YES;
        _totalTimeLabel.text = @"00:00";
        _totalTimeLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _totalTimeLabel;
}
//缓冲条
- (UIProgressView *) progress{
    if (_progress == nil){
        _progress = [[UIProgressView alloc] init];
    }
    return _progress;
}
//滑动条
- (AQSlider *) slider{
    if (_slider == nil){
        _slider = [[AQSlider alloc] init];
        // slider开始滑动事件
        [_slider addTarget:self action:@selector(progressSliderTouchBegan:) forControlEvents:UIControlEventTouchDown];
        // slider滑动中事件
        [_slider addTarget:self action:@selector(progressSliderValueChanged:) forControlEvents:UIControlEventValueChanged];
        // slider结束滑动事件
        [_slider addTarget:self action:@selector(progressSliderTouchEnded:) forControlEvents:UIControlEventTouchUpInside | UIControlEventTouchCancel | UIControlEventTouchUpOutside];
        //右边颜色
        _slider.maximumTrackTintColor = [UIColor clearColor];
    }
    return _slider;
}
//加载失败按钮
- (UIButton *) failButton
{
    if (_failButton == nil) {
        _failButton = [[UIButton alloc] init];
        _failButton.hidden = YES;
        [_failButton setTitle:@"加载失败,点击重试" forState:UIControlStateNormal];
        [_failButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _failButton.titleLabel.font = [UIFont systemFontOfSize:14.0];
        _failButton.backgroundColor = [UIColor colorWithRed:0.00000f green:0.00000f blue:0.00000f alpha:0.50000f];
        [_failButton addTarget:self action:@selector(failButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _failButton;
}
#pragma mark - 按钮点击事件
//返回按钮
- (void)backButtonAction:(UIButton *)button{
    if (_delegate && [_delegate respondsToSelector:@selector(aq_backButtonAction:)]) {
        [_delegate aq_backButtonAction:button];
    }else{
        NSLog(@"没有实现代理或者没有设置代理人");
    }
}
//播放按钮
- (void)playButtonAction:(UIButton *)button{
    button.selected = !button.selected;
    if (_delegate && [_delegate respondsToSelector:@selector(aq_playButtonAction:)]) {
        [_delegate aq_playButtonAction:button];
    }else{
        NSLog(@"没有实现代理或者没有设置代理人");
    }
}
//全屏按钮
- (void)fullButtonAction:(UIButton *)button{
    button.selected = !button.selected;
    if (_delegate && [_delegate respondsToSelector:@selector(aq_fullButtonAction:)]) {
        [_delegate aq_fullButtonAction:button];
    }else{
        NSLog(@"没有实现代理或者没有设置代理人");
    }
}
//失败按钮
- (void)failButtonAction:(UIButton *)button{
    self.failButton.hidden = YES;
    [self.activity starAnimation];
    self.activity.hidden   = NO;
    if (_delegate && [_delegate respondsToSelector:@selector(aq_failButtonAction:)]) {
        [_delegate aq_failButtonAction:button];
    }else{
        NSLog(@"没有实现代理或者没有设置代理人");
    }
}
#pragma mark - 滑杆
//开始滑动
- (void)progressSliderTouchBegan:(AQSlider *)slider{
    if (_delegate && [_delegate respondsToSelector:@selector(aq_progressSliderTouchBegan:)]) {
        [_delegate aq_progressSliderTouchBegan:slider];
    }else{
        NSLog(@"没有实现代理或者没有设置代理人");
    }
}
//滑动中
- (void)progressSliderValueChanged:(AQSlider *)slider{
    if (_delegate && [_delegate respondsToSelector:@selector(aq_progressSliderValueChanged:)]) {
        [_delegate aq_progressSliderValueChanged:slider];
    }else{
        NSLog(@"没有实现代理或者没有设置代理人");
    }
}
//滑动结束
- (void)progressSliderTouchEnded:(AQSlider *)slider{
    if (_delegate && [_delegate respondsToSelector:@selector(aq_progressSliderTouchEnded:)]) {
        [_delegate aq_progressSliderTouchEnded:slider];
    }else{
        NSLog(@"没有实现代理或者没有设置代理人");
    }
}
#pragma mark - 布局
-(void)layoutSubviews{
    [super layoutSubviews];
    [self makeConstraints];
}
//#pragma mark - 获取资源图片
//- (UIImage *)getPictureWithName:(NSString *)name{
//    NSBundle *bundle = [NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:@"AQPlayer" ofType:@"bundle"]];
//    NSString *path   = [bundle pathForResource:name ofType:@"png"];
//    NSLog(@"image:%@",[UIImage imageWithContentsOfFile:path]);
//    return [UIImage imageWithContentsOfFile:path];
//}

@end
