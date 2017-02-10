//
//  NetworkAPI.m
//  BuilditTouchID
//
//  Created by Tiago Bencardino on 10/02/2017.
//  Copyright © 2017 Juliana Cipa. All rights reserved.
//

#import "NetworkAPI.h"
#import <AFNetworking/AFNetworking.h>

NSString const *serverAddress = @"http://192.168.0.1:8080";

@implementation NetworkAPI

- (void)postSuccessFingerprintWithHash:(NSString *)hash success:(successResponse)success failure:(failureResponse)failure {
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    NSString *path = [NSString stringWithFormat:@"%@/api/auth/fingerprint/%@", serverAddress, hash];
    [manager POST:path parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
    }];
}

- (void)postFailureFingerprintWithSuccess:(successResponse)success failure:(failureResponse)failure {
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    NSString *path = [NSString stringWithFormat:@"%@/api/auth/fingerprint", serverAddress];
    [manager POST:path parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
    }];
}

@end
