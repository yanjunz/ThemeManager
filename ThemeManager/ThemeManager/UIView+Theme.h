//
//  UIView+Theme.h
//  WonderPlayerDemo
//
//  Created by Yanjun Zhuang on 14/6/15.
//  Copyright (c) 2015 Tencent. All rights reserved.
//

#import <UIKit/UIKit.h>



extern NSString *kThemeMapKeyImageName;
extern NSString *kThemeMapKeyHighlightedImageName;
extern NSString *kThemeMapKeySelectedImageName;
extern NSString *kThemeMapKeyDisabledImageName;

extern NSString *kThemeMapKeyColorName;
extern NSString *kThemeMapKeyHighlightedColorName;
extern NSString *kThemeMapKeySelectedColorName;
extern NSString *kThemeMapKeyDisabledColorName;

extern NSString *kThemeMapKeyBgColorName;

extern NSString *kThemeMapKeyMinValueImageName;
extern NSString *kThemeMapKeyMaxValueImageName;

extern NSString *kThemeMapKeyThumbImageName;
extern NSString *kThemeMapKeyHighlightedThumbImageName;
extern NSString *kThemeMapKeyDisabledThumbImageName;

extern NSString *kThemeMapKeyMinTrackImageName;
extern NSString *kThemeMapKeyHighlightedMinTrackImageName;
extern NSString *kThemeMapKeyDisabledMinTrackImageName;

extern NSString *kThemeMapKeyMaxTrackImageName;
extern NSString *kThemeMapKeyHighlightedMaxTrackImageName;
extern NSString *kThemeMapKeyDisabledMaxTrackImageName;

extern NSString *kThemeMapKeyMinTrackTintColorName;
extern NSString *kThemeMapKeyMaxTrackTintColorName;

@interface UIView (Theme)
@property (nonatomic, copy) NSDictionary *themeMap;

- (void)themeChanged;
@end
