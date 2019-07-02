//
//  AFNManager.h
//  imiss-ios-master
//
//  Created by 郑业强 on 2018/10/27.
//  Copyright © 2018年 kk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MXAPPResult.h"
#import "MyMXAPPViewRequest.h"

NS_ASSUME_NONNULL_BEGIN


#pragma mark - typeof
typedef void(^__nullable AFNManagerCompleteBlock)(MXAPPResult *result);
typedef void(^__nullable AFNManagerProgressBlock)(CGFloat currentProgress, CGFloat maxProgress, CGFloat percentage);


#pragma mark - 声明
@interface AFNNetworkManager : NSObject


+ (void)POST:(NSString *)url complete:(AFNManagerCompleteBlock)complete;
+ (void)POST:(NSString *)url params:(NSDictionary *)params complete:(AFNManagerCompleteBlock)complete;
+ (void)POST:(NSString *)url params:(NSDictionary *)params progress:(AFNManagerProgressBlock)progress complete:(AFNManagerCompleteBlock)complete;
+ (void)POST:(NSString *)url params:(NSDictionary *)params andImages:(NSArray<UIImage *> *)images progress:(AFNManagerProgressBlock)progress complete:(AFNManagerCompleteBlock)complete;


@end


NS_ASSUME_NONNULL_END
