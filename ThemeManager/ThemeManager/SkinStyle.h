//
//  SkinStyle.h
//  ThemeManagerDemo
//
//  Created by zhuangyanjun on 6/8/13.
//  Copyright (c) 2013年 Leejune. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SkinStyle : NSObject
@property (nonatomic) NSInteger skinID;
@property (nonatomic, copy) NSString *skinName;
@property (nonatomic, copy) NSString *icon;
@property (nonatomic, copy) NSString *pathPrefix;

- (id)initWithContentOfFile:(NSString *)filePath withPathPrefix:(NSString *)pathPrefix;
- (void)merge:(SkinStyle *)skinStyle;
- (NSString *)fullResourcePathForName:(NSString *)name;
- (NSString *)resourceForName:(NSString *)name;
- (UIColor *)colorForName:(NSString *)name;

@end
