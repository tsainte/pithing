//
//  NetworkAPI.m
//  BuilditTouchID
//
//  Created by Tiago Bencardino on 10/02/2017.
//  Copyright © 2017 Juliana Cipa. All rights reserved.
//

#import "NetworkAPI.h"
#import <AFNetworking/AFNetworking.h>

NSString const *serverAddress = @"http://10.0.1.107:3000";

@interface NetworkAPI()

@property (nonatomic, strong) AFHTTPSessionManager *manager;

@end

@implementation NetworkAPI

//lazy instanciation
- (AFHTTPSessionManager*)manager {
    
    if (!_manager) {
        _manager = [AFHTTPSessionManager manager];
        _manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        _manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/plain"];
    }
    return _manager;
}

#pragma mark - endpoints

- (void)postSuccessFingerprintWithHash:(NSString *)hash success:(successResponse)success failure:(failureResponse)failure {
    
    NSString *path = [NSString stringWithFormat:@"%@/api/auth/fingerprint/%@", serverAddress, hash];
    [self.manager POST:path parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        failure(error);
    }];
}

- (void)postFailureFingerprintWithSuccess:(successResponse)success failure:(failureResponse)failure {
    
    NSString *path = [NSString stringWithFormat:@"%@/api/auth/fingerprint", serverAddress];
    [self.manager POST:path parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        failure(error);
    }];
}

@end
