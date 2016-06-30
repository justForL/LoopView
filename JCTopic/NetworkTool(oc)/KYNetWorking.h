//
//  KYNetWorking.h
//  testJK
//
//  Created by DaysSummer on 16/1/19.
//  Copyright © 2016年 SayDy. All rights reserved.
//

#import "AFNetworking.h"

@interface KYNetWorking : AFHTTPSessionManager
+ (instancetype)sharedNetWorking;

/**
 *  封装POST网络请求
 *  @param url url地址,不需要
 *  @param parameterDict 参数字典
 *  @param success 成功后的回调,返回字典
 *  @param failure 失败后的回调
 */
- (void)POSTWithURlString:(NSString *)url parameterDict:(NSDictionary *)parameterDict success:(void (^)(NSDictionary *responseObject))success failure:(void (^)(NSError *error))failure;

/**
 *  封装GET网络请求
 *  @param url url地址,不需要
 *  @param parameterDict 参数字典
 *  @param success 成功后的回调,返回字典
 *  @param failure 失败后的回调
 */
- (void)GETWithURlString:(NSString *)url parameterDict:(NSDictionary *)parameterDict success:(void (^)(NSDictionary *responseObject))success failure:(void (^)(NSError *error))failure;

@end
