//
//  UITabBarController+AQPlayerRotation.m
//  AQAVPlayerViewController
//
//  Created by desunire on 2017/11/23.
//  Copyright © 2017年 desunire. All rights reserved.
//

#import "UITabBarController+AQPlayerRotation.h"
#import <objc/runtime.h>
@implementation UITabBarController (AQPlayerRotation)

+ (void)load {
    SEL selectors[] = {
        @selector(selectedIndex)
    };
    for (NSUInteger index = 0; index < sizeof(selectors) / sizeof(SEL); ++index) {
        SEL originalSelector = selectors[index];
        SEL swizzledSelector = NSSelectorFromString([@"cl_" stringByAppendingString:NSStringFromSelector(originalSelector)]);
        Method originalMethod = class_getInstanceMethod(self, originalSelector);
        Method swizzledMethod = class_getInstanceMethod(self, swizzledSelector);
        if (class_addMethod(self, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod))) {
            class_replaceMethod(self, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
        } else {
            method_exchangeImplementations(originalMethod, swizzledMethod);
        }
    }
}
- (NSInteger)cl_selectedIndex {
    NSInteger index = [self cl_selectedIndex];
    if (index > self.viewControllers.count){
        return 0;
    }else{
        return index;
    }
}

// 是否支持自动转屏
- (BOOL)shouldAutorotate {
    UIViewController *vc = self.viewControllers[self.selectedIndex];
    if ([vc isKindOfClass:[UINavigationController class]]) {
        UINavigationController *nav = (UINavigationController *)vc;
        return [nav.topViewController shouldAutorotate];
    } else {
        return [vc shouldAutorotate];
    }
}
// 支持哪些屏幕方向
- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    UIViewController *vc = self.viewControllers[self.selectedIndex];
    if ([vc isKindOfClass:[UINavigationController class]]) {
        UINavigationController *nav = (UINavigationController *)vc;
        return [nav.topViewController supportedInterfaceOrientations];
    } else {
        return [vc supportedInterfaceOrientations];
    }
}
// 默认的屏幕方向
- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    UIViewController *vc = self.viewControllers[self.selectedIndex];
    if ([vc isKindOfClass:[UINavigationController class]]) {
        UINavigationController *nav = (UINavigationController *)vc;
        return [nav.topViewController preferredInterfaceOrientationForPresentation];
    } else {
        return [vc preferredInterfaceOrientationForPresentation];
    }
}

@end
