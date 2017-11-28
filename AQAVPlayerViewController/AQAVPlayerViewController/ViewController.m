//
//  ViewController.m
//  AQAVPlayerViewController
//
//  Created by desunire on 2017/11/22.
//  Copyright © 2017年 desunire. All rights reserved.
//

#import "ViewController.h"
#import "AQPlayerView.h"
@interface ViewController ()
/**CLplayer*/
@property (nonatomic,weak) AQPlayerView *playerView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //播放视频
    AQPlayerView *playerView = [[AQPlayerView alloc] initWithFrame:CGRectMake(0, 90, self.view.frame.size.width, 300)];
    
    _playerView = playerView;
    [self.view addSubview:_playerView];
    
    //    //重复播放，默认不播放
    //    _playerView.repeatPlay = YES;
    //    //当前控制器是否支持旋转，当前页面支持旋转的时候需要设置，告知播放器
//    _playerView.isLandscape = YES;
    //    //设置等比例全屏拉伸，多余部分会被剪切
    //    _playerView.fillMode = ResizeAspectFill;
    //    //设置进度条背景颜色
    //    _playerView.progressBackgroundColor = [UIColor purpleColor];
    //    //设置进度条缓冲颜色
    //    _playerView.progressBufferColor = [UIColor redColor];
    //    //设置进度条播放完成颜色
    //    _playerView.progressPlayFinishColor = [UIColor greenColor];
    //    //全屏是否隐藏状态栏
    //    _playerView.fullStatusBarHidden = NO;
    //    //是否静音，默认NO
    //    _playerView.mute = YES;
    //    //转子颜色
    //    _playerView.strokeColor = [UIColor redColor];
    //    //工具条消失时间，默认10s
    //    _playerView.toolBarDisappearTime = 15;
    //视频地址
    _playerView.url = [NSURL URLWithString:@"http://wvideo.spriteapp.cn/video/2016/1203/58425ad2a0c1d_wpd.mp4"];
    //播放
    [_playerView playVideo];
    //返回按钮点击事件回调,小屏状态才会调用，全屏默认变为小屏
    [_playerView backButton:^(UIButton *button) {
        NSLog(@"返回按钮被点击");
    }];
    //播放完成回调
    [_playerView endPlay:^{
        //销毁播放器
        //        [_playerView destroyPlayer];
        //        _playerView = nil;
        NSLog(@"播放完成");
    }];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
