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
extern NSString *kThemeMapKeyColorName;
extern NSString *kThemeMapKeyHighlightedColorName;
extern NSString *kThemeMapKeySelectedColorName;

@interface UIView (Theme)
@property (nonatomic, copy) NSDictionary *themeMap;

- (void)themeChanged;
@end
