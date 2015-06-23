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
NSString *kThemeMapKeyColorName             = @"kThemeMapKeyColorName";
NSString *kThemeMapKeyHighlightedColorName  = @"kThemeMapKeyHighlightedColorName";
NSString *kThemeMapKeySelectedColorName     = @"kThemeMapKeySelectedColorName";

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
        if (map[kThemeMapKeyImageName]) {
            [obj setImage:TImage(map[kThemeMapKeyImageName]) forState:UIControlStateNormal];
        }
        if (map[kThemeMapKeyHighlightedImageName]) {
            [obj setImage:TImage(map[kThemeMapKeyHighlightedImageName]) forState:UIControlStateHighlighted];
        }
        if (map[kThemeMapKeySelectedImageName]) {
            [obj setImage:TImage(map[kThemeMapKeySelectedImageName]) forState:UIControlStateSelected];
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
    }
    else {
        if (map[kThemeMapKeyColorName]) {
            self.backgroundColor = TColor(map[kThemeMapKeyColorName]);
        }
    }
}

@end
