//
//  UIView+Theme.m
//  WonderPlayerDemo
//
//  Created by Yanjun Zhuang on 14/6/15.
//  Copyright (c) 2015 Tencent. All rights reserved.
//

#import "UIView+Theme.h"
#import <objc/runtime.h>
#import "ThemeManager.h"
#import "NSObject+DeallocBlock.h"

NSString *kThemeMapKeyImageName             = @"kThemeMapKeyImageName";
NSString *kThemeMapKeyHighlightedImageName  = @"kThemeMapKeyHighlightedImageName";
NSString *kThemeMapKeySelectedImageName     = @"kThemeMapKeySelectedImageName";
NSString *kThemeMapKeyDisabledImageName     = @"kThemeMapKeyDisabledImageName";

NSString *kThemeMapKeyColorName             = @"kThemeMapKeyColorName";
NSString *kThemeMapKeyHighlightedColorName  = @"kThemeMapKeyHighlightedColorName";
NSString *kThemeMapKeySelectedColorName     = @"kThemeMapKeySelectedColorName";
NSString *kThemeMapKeyDisabledColorName     = @"kThemeMapKeyDisabledColorName";

NSString *kThemeMapKeyBgColorName           = @"kThemeMapKeyBgColorName";

// Slider
NSString *kThemeMapKeyMinValueImageName     = @"kThemeMapKeyMinValueImageName";
NSString *kThemeMapKeyMaxValueImageName     = @"kThemeMapKeyMaxValueImageName";

NSString *kThemeMapKeyThumbImageName        = @"kThemeMapKeyThumbImageName";
NSString *kThemeMapKeyHighlightedThumbImageName = @"kThemeMapKeyHighlightedThumbImageName";
NSString *kThemeMapKeyDisabledThumbImageName    = @"kThemeMapKeyDisabledThumbImageName";

NSString *kThemeMapKeyMinTrackImageName     = @"kThemeMapKeyMinTrackImageName";
NSString *kThemeMapKeyHighlightedMinTrackImageName = @"kThemeMapKeyHighlightedMinTrackImageName";
NSString *kThemeMapKeyDisabledMinTrackImageName = @"kThemeMapKeyDisabledMinTrackImageName";

NSString *kThemeMapKeyMaxTrackImageName     = @"kThemeMapKeyMaxTrackImageName";
NSString *kThemeMapKeyHighlightedMaxTrackImageName = @"kThemeMapKeyHighlightedMaxTrackImageName";
NSString *kThemeMapKeyDisabledMaxTrackImageName = @"kThemeMapKeyDisabledMaxTrackImageName";

NSString *kThemeMapKeyMinTrackTintColorName = @"kThemeMapKeyMinTrackTintColorName";
NSString *kThemeMapKeyMaxTrackTintColorName = @"kThemeMapKeyMaxTrackTintColorName";




static void *kUIView_ThemeMap;
static void *kUIView_DeallocHelper;

@implementation UIView (Theme)
- (void)setThemeMap:(NSDictionary *)themeMap
{
    objc_setAssociatedObject(self, &kUIView_ThemeMap, themeMap, OBJC_ASSOCIATION_COPY_NONATOMIC);
    
    if (themeMap) {
        // Need to removeObserver in dealloc
        if (objc_getAssociatedObject(self, &kUIView_DeallocHelper) == nil) {
            __unsafe_unretained typeof(self) weakSelf = self; // NOTE: need to be __unsafe_unretained because __weak var will be reset to nil in dealloc
            id deallocHelper = [self addDeallocBlock:^{
                [[NSNotificationCenter defaultCenter] removeObserver:weakSelf];
            }];
            objc_setAssociatedObject(self, &kUIView_DeallocHelper, deallocHelper, OBJC_ASSOCIATION_ASSIGN);
        }
        
        [[NSNotificationCenter defaultCenter] removeObserver:self name:kThemeDidChangeNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(themeChanged) name:kThemeDidChangeNotification object:nil];
        [self themeChanged];
    }
    else {
        [[NSNotificationCenter defaultCenter] removeObserver:self name:kThemeDidChangeNotification object:nil];
    }
}

- (NSDictionary *)themeMap
{
    return objc_getAssociatedObject(self, &kUIView_ThemeMap);
}

- (void)themeChanged
{
    NSDictionary *map = self.themeMap;
    if ([self isKindOfClass:[UILabel class]]) {
        UILabel *obj = (UILabel *)self;
        if (map[kThemeMapKeyColorName]) {
            obj.textColor = TColor(map[kThemeMapKeyColorName]);
        }
        if (map[kThemeMapKeyHighlightedColorName]) {
            obj.highlightedTextColor = TColor(map[kThemeMapKeyHighlightedColorName]);
        }
        if (map[kThemeMapKeyBgColorName]) {
            obj.backgroundColor = TColor(map[kThemeMapKeyBgColorName]);
        }
    }
    else if ([self isKindOfClass:[UIButton class]]) {
        UIButton *obj = (UIButton *)self;
        if (map[kThemeMapKeyColorName]) {
            [obj setTitleColor:TColor(map[kThemeMapKeyColorName]) forState:UIControlStateNormal];
        }
        if (map[kThemeMapKeyHighlightedColorName]) {
            [obj setTitleColor:TColor(map[kThemeMapKeyHighlightedColorName]) forState:UIControlStateHighlighted];
        }
        if (map[kThemeMapKeySelectedColorName]) {
            [obj setTitleColor:TColor(map[kThemeMapKeySelectedColorName]) forState:UIControlStateSelected];
        }
        if (map[kThemeMapKeyDisabledColorName]) {
            [obj setTitleColor:TColor(map[kThemeMapKeyDisabledColorName]) forState:UIControlStateDisabled];
        }
        if (map[kThemeMapKeyImageName]) {
            [obj setImage:TImage(map[kThemeMapKeyImageName]) forState:UIControlStateNormal];
        }
        if (map[kThemeMapKeyHighlightedImageName]) {
            [obj setImage:TImage(map[kThemeMapKeyHighlightedImageName]) forState:UIControlStateHighlighted];
        }
        if (map[kThemeMapKeySelectedImageName]) {
            [obj setImage:TImage(map[kThemeMapKeySelectedImageName]) forState:UIControlStateSelected];
        }
        if (map[kThemeMapKeyDisabledImageName]) {
            [obj setImage:TImage(map[kThemeMapKeyDisabledImageName]) forState:UIControlStateDisabled];
        }
        if (map[kThemeMapKeyBgColorName]) {
            obj.backgroundColor = TColor(map[kThemeMapKeyBgColorName]);
        }
    }
    else if ([self isKindOfClass:[UIImageView class]]) {
        UIImageView *obj = (UIImageView *)self;
        if (map[kThemeMapKeyImageName]) {
            obj.image = TImage(map[kThemeMapKeyImageName]);
        }
        if (map[kThemeMapKeyHighlightedImageName]) {
            obj.highlightedImage = TImage(map[kThemeMapKeyHighlightedImageName]);
        }
        if (map[kThemeMapKeyColorName]) {
            obj.backgroundColor = TColor(map[kThemeMapKeyColorName]);
        }
    }
    else if ([self isKindOfClass:[UISlider class]]) {
        UISlider *obj = (UISlider *)self;
        if (map[kThemeMapKeyMinValueImageName]) {
            obj.minimumValueImage = TImage(map[kThemeMapKeyMinValueImageName]);
        }
        if (map[kThemeMapKeyMaxValueImageName]) {
            obj.maximumValueImage = TImage(map[kThemeMapKeyMaxValueImageName]);
        }
        
        if (map[kThemeMapKeyThumbImageName]) {
            [obj setThumbImage:TImage(map[kThemeMapKeyThumbImageName]) forState:UIControlStateNormal];
        }
        if (map[kThemeMapKeyHighlightedThumbImageName]) {
            [obj setThumbImage:TImage(map[kThemeMapKeyHighlightedThumbImageName]) forState:UIControlStateHighlighted];
        }
        if (map[kThemeMapKeyDisabledThumbImageName]) {
            [obj setThumbImage:TImage(map[kThemeMapKeyDisabledThumbImageName]) forState:UIControlStateDisabled];
        }
        
        if (map[kThemeMapKeyMinTrackImageName]) {
            [obj setMinimumTrackImage:TImage(map[kThemeMapKeyMinTrackImageName]) forState:UIControlStateNormal];
        }
        if (map[kThemeMapKeyHighlightedMinTrackImageName]) {
            [obj setMinimumTrackImage:TImage(map[kThemeMapKeyHighlightedMinTrackImageName]) forState:UIControlStateHighlighted];
        }
        if (map[kThemeMapKeyDisabledMinTrackImageName]) {
            [obj setMinimumTrackImage:TImage(map[kThemeMapKeyDisabledMinTrackImageName]) forState:UIControlStateDisabled];
        }
        
        if (map[kThemeMapKeyMaxTrackImageName]) {
            [obj setMaximumTrackImage:TImage(map[kThemeMapKeyMaxTrackImageName]) forState:UIControlStateNormal];
        }
        if (map[kThemeMapKeyHighlightedMaxTrackImageName]) {
            [obj setMaximumTrackImage:TImage(map[kThemeMapKeyHighlightedMaxTrackImageName]) forState:UIControlStateHighlighted];
        }
        if (map[kThemeMapKeyDisabledMaxTrackImageName]) {
            [obj setMaximumTrackImage:TImage(map[kThemeMapKeyDisabledMaxTrackImageName]) forState:UIControlStateDisabled];
        }
        
        if (map[kThemeMapKeyMinTrackTintColorName]) {
            obj.minimumTrackTintColor = TColor(map[kThemeMapKeyMinTrackTintColorName]);
        }
        if (map[kThemeMapKeyMaxTrackTintColorName]) {
            obj.maximumTrackTintColor = TColor(map[kThemeMapKeyMaxTrackTintColorName]);
        }
    }
    else if ([self isKindOfClass:[UITextField class]]) {
        UITextField *obj = (UITextField *)self;
        if (map[kThemeMapKeyColorName]) {
            obj.textColor = TColor(map[kThemeMapKeyColorName]);
        }
    }
    else if ([self isKindOfClass:[UITextView class]]) {
        UITextView *obj = (UITextView *)self;
        if (map[kThemeMapKeyColorName]) {
            obj.textColor = TColor(map[kThemeMapKeyColorName]);
        }
    }
    else {
        if (map[kThemeMapKeyColorName]) {
            self.backgroundColor = TColor(map[kThemeMapKeyColorName]);
        }
    }
}

@end
