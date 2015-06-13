//
//  ThemeManager.m
//  ThemeManagerDemo
//
//  Created by zhuangyanjun on 6/8/13.
//  Copyright (c) 2013年 Leejune. All rights reserved.
//

#import "ThemeManager.h"

@interface ThemeManager ()

@end

@implementation ThemeManager

+ (ThemeManager *)sharedInstance
{
    static ThemeManager *_instance;
    @synchronized(self) {
        if (_instance == nil) {
            _instance = [[ThemeManager alloc] init];
        }
    }
    return _instance;
}

- (id)init
{
    if (self = [super init]) {
        NSString *filePath = [[NSBundle mainBundle] pathForResource:@"theme" ofType:@"plist"];
        if (filePath == nil) {
            NSString *resourcePath = [[NSBundle mainBundle] resourcePath];
            filePath = [resourcePath stringByAppendingPathComponent:@"/res/themes/theme.plist"];
            if (![[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
                NSLog(@"ERROR %@", filePath);
            }
        }
        self.allStyleArray = [[NSMutableArray alloc] initWithContentsOfFile:filePath];
    }
    return self;
}

- (void)loadConfig:(NSInteger)skinID
{
    NSDictionary *skinInfo = [self getSkinInfo:THEME_STYLE_CLASSIC];
    SkinStyle *skinStyle = [[SkinStyle alloc] initWithContentOfFile:[self getSkinConfigPath:skinInfo[kStyleConfig]] withPathPrefix:skinInfo[kStylePath]];
    
    if (skinID != THEME_STYLE_CLASSIC) {
        skinInfo = [self getSkinInfo:skinID];
        SkinStyle *skinMerge = [[SkinStyle alloc] initWithContentOfFile:[self getSkinConfigPath:skinInfo[kStyleConfig]] withPathPrefix:skinInfo[kStylePath]];
        [skinStyle merge:skinMerge];
    }
    skinStyle.skinID = skinID;
    skinStyle.skinName = skinInfo[kStyleName];
    skinStyle.icon = skinInfo[kStyleIcon];
    self.skinInstance = skinStyle;
}

- (void)resetConfig
{
    [self loadConfig:THEME_STYLE_CLASSIC];
}

- (NSDictionary *)getSkinInfo:(NSInteger)skinID
{
    NSDictionary *themeInfo = nil;
    
    for (themeInfo in self.allStyleArray) {
        if ([themeInfo[kStyleID] intValue] == skinID) {
            break;
        }
    }
    return themeInfo;
}

- (NSString *)getSkinConfigPath:(NSString *)name
{
    NSString *resourcePath = [[NSBundle mainBundle] resourcePath];
    return [resourcePath stringByAppendingPathComponent:name];
}

//- (NSString *)getSkinIconPath:(NSInteger)skinID
//{
//    NSDictionary *skinInfo = [self getSkinInfo:skinID];
//    NSString *icon = skinInfo[kStyleIcon];
//    NSString *resourcePath = [[NSBundle mainBundle] resourcePath];
//    return [resourcePath stringByAppendingPathComponent:icon];
//}

- (void)switchToStyleByID:(NSInteger)skinID
{
    [self loadConfig:skinID];
    [[NSNotificationCenter defaultCenter] postNotificationName:kThemeDidChangeNotification object:nil];
}

@end
