//
//  ThemeManager.h
//  ThemeManagerDemo
//
//  Created by zhuangyanjun on 6/8/13.
//  Copyright (c) 2013年 Leejune. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ThemeConstants.h"
#import "SkinStyle.h"


@interface ThemeManager : NSObject {

}

@property (nonatomic, copy) NSString *themeName;
@property (nonatomic, strong) NSMutableArray *allStyleArray;
@property (nonatomic, strong) NSDictionary *themeConfig;
@property (nonatomic, strong) NSDictionary *colorConfig;
@property (nonatomic, strong) SkinStyle *skinInstance;

+ (ThemeManager *)sharedInstance;
- (void)switchToStyleByID:(NSInteger)skinID;
- (NSDictionary *)getSkinInfo:(NSInteger)skinID;
//- (NSString *)getSkinIconPath:(NSInteger)skinID;
@end
