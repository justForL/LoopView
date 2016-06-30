//
//  KYNetWorking.m
//  testJK
//
//  Created by DaysSummer on 16/1/19.
//  Copyright © 2016年 SayDy. All rights reserved.
//

#import "KYNetWorking.h"

#define BASEURL @""

static KYNetWorking *_INSTANCE;

@implementation KYNetWorking
+ (instancetype)sharedNetWorking {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _INSTANCE = [[self alloc] initWithBaseURL:[NSURL URLWithString:BASEURL]];
        _INSTANCE.requestSerializer = [AFJSONRequestSerializer serializer];
        _INSTANCE.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    });
    return _INSTANCE;
    
}


- (void)POSTWithURlString:(NSString *)url parameterDict:(NSDictionary *)parameterDict success:(void (^)(NSDictionary *responseObject))success failure:(void (^)(NSError *error))failure {
    
    [self POST:url parameters:parameterDict progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary * responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
    }];
    
}

- (void)GETWithURlString:(NSString *)url parameterDict:(NSDictionary *)parameterDict success:(void (^)(NSDictionary *responseObject))success failure:(void (^)(NSError *error))failure {
    
    [self GET:url parameters:parameterDict progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
    }];
    
}

@end
