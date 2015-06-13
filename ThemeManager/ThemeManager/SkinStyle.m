//
//  SkinStyle.m
//  ThemeManagerDemo
//
//  Created by zhuangyanjun on 6/8/13.
//  Copyright (c) 2013年 Leejune. All rights reserved.
//

#import "SkinStyle.h"
#import "ThemeConstants.h"

#define kSkinStyleFilePathKey   @"res"
#define kSkinStyleColorKey      @"constant"

@interface SkinStyle ()
@property (nonatomic, strong) NSDictionary *filePathDict;
@property (nonatomic, strong) NSDictionary *colorDict;
@end

@implementation SkinStyle

- (id)initWithContentOfFile:(NSString *)filePath withPathPrefix:(NSString *)pathPrefix
{
    if (self = [super init]) {
        self.pathPrefix = pathPrefix;
        [self loadFromFile:filePath];
        [self concatPathPrefix];
    }
    return self;
}

- (void)loadFromFile:(NSString *)filePath
{
    NSMutableDictionary *fileContent = [[NSMutableDictionary alloc] initWithContentsOfFile:filePath];
    self.filePathDict = fileContent[kSkinStyleFilePathKey];
    self.colorDict = fileContent[kSkinStyleColorKey];
}

- (void)concatPathPrefix
{
    NSMutableDictionary *newFilePathDict = [NSMutableDictionary dictionary];
    for (NSString *key in self.filePathDict.allKeys) {
        NSString *v = self.filePathDict[key];
        v = [self.pathPrefix stringByAppendingPathComponent:v];
        newFilePathDict[key] = v;
    }
    self.filePathDict = newFilePathDict;
}

- (void)merge:(SkinStyle *)skinStyle
{
    [self.filePathDict setValuesForKeysWithDictionary:skinStyle.filePathDict];
    [self.colorDict setValuesForKeysWithDictionary:skinStyle.colorDict];
}

- (NSString *)fullResourcePathForName:(NSString *)name
{
//    return [self.path stringByAppendingPathComponent:[self resourceForName:name]];
    return [self resourceForName:name];
}

- (NSString *)resourceForName:(NSString *)name
{
    NSString *ret = self.filePathDict[name];
    if ([ret hasPrefix:@"/"]) { // Bugfix: iOS8 will not work with res with the prefix "/"
        ret = [ret substringFromIndex:1];
    }
    return ret;
}

- (UIColor *)colorForName:(NSString *)name
{
    id colorValue = self.colorDict[name];
    
    if ([colorValue isKindOfClass:[NSNumber class]]) {
        NSNumber* rvalue = colorValue;
        int color32 = [rvalue intValue];
        return [SkinStyle colorFromInt:color32];
    }
    else if ([colorValue isKindOfClass:[NSString class]]) {
        return [SkinStyle colorFromHexString:(NSString *)colorValue];
    }
    else {
        return [UIColor blackColor];
    }
}

+ (UIColor *)colorFromInt:(int)color32
{
    CGFloat r,g,b,a;
    r =  ((color32 >> 16)& 0xFF) / 255.0f;
    g =  ((color32 >> 8) & 0xFF) / 255.0f;
    b =  ((color32) & 0xFF) / 255.0f;
    a =  ((color32 >> 24) & 0xFF) / 255.0f;
//    NSLog(@"[colorFromInt] %x, %f, %f, %f, %f", color32, r, g, b, a);
    return [UIColor colorWithRed:r green:g blue:b alpha:a];
}

+ (UIColor *)colorFromHexString:(NSString *)stringToConvert
{    
    NSString *cString = [[stringToConvert stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // String should be 8 or 10 characters
    if ([cString length] < 8) return [UIColor blackColor];
    
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"]) cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"]) cString = [cString substringFromIndex:1];
    
    if ([cString length] != 8) return [UIColor blackColor];
    
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *aString = [cString substringWithRange:range];
    
    range.location = 2;
    NSString *rString = [cString substringWithRange:range];
    
    range.location = 4;
    NSString *gString = [cString substringWithRange:range];
    
    range.location = 6;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b, a;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    [[NSScanner scannerWithString:aString] scanHexInt:&a];
//    NSLog(@"[colorFromString] %@, %x, %x, %x, %x", stringToConvert, r, g, b, a);
    return [UIColor colorWithRed:((float) r / 255.0f)
                           green:((float) g / 255.0f)
                            blue:((float) b / 255.0f)
                           alpha:((float) a / 255.0f)];
}

@end
