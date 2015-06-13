//
//  ThemeConstants.h
//  ThemeManagerDemo
//
//  Created by zhuangyanjun on 7/8/13.
//  Copyright (c) 2013年 Leejune. All rights reserved.
//

#ifndef ThemeManagerDemo_ThemeConstants_h
#define ThemeManagerDemo_ThemeConstants_h

#define kThemeDidChangeNotification @"kThemeDidChangeNotification"

#define kStyleID        @"id"
#define kStyleConfig    @"configPath"
#define kStyleName      @"name"
#define kStyleIcon      @"icon"
#define kStylePath      @"themePath"
#define kStyleDetail    @"detail"

#define THEME_STYLE_CLASSIC		1
#define THEME_STYLE_NIGHT		2

#define TResource(name)     [[ThemeManager sharedInstance].skinInstance fullResourcePathForName:name]
#define TColor(name) [[ThemeManager sharedInstance].skinInstance colorForName:name]
#define TImage(name) [UIImage imageNamed:TResource(name)]
#endif
