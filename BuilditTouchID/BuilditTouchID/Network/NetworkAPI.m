//
//  NetworkAPI.m
//  BuilditTouchID
//
//  Created by Tiago Bencardino on 10/02/2017.
//  Copyright © 2017 Juliana Cipa. All rights reserved.
//

#import "NetworkAPI.h"
#import <AFNetworking/AFNetworking.h>

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

#pragma mark - fingerprints

- (void)postSuccessFingerprintWithHash:(NSString *)hash success:(successResponse)success failure:(failureResponse)failure {
    
    NSString *escapedHash = [hash stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLHostAllowedCharacterSet]];
    NSString *path = [NSString stringWithFormat:@"http://%@/api/auth/fingerprint/%@", [IPHandler IP], escapedHash];
    [self.manager POST:path parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        failure(error);
    }];
}

- (void)postFailureFingerprintWithSuccess:(successResponse)success failure:(failureResponse)failure {
    
    NSString *path = [NSString stringWithFormat:@"http://%@/api/auth/fingerprint", [IPHandler IP]];
    [self.manager POST:path parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        failure(error);
    }];
}

#pragma mark - voice

- (void)postSuccessVoiceWithHash:(NSString *)hash success:(successResponse)success failure:(failureResponse)failure {
    
    NSString *escapedHash = [hash stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLHostAllowedCharacterSet]];
    NSString *path = [NSString stringWithFormat:@"http://%@/api/auth/voice/%@", [IPHandler IP], escapedHash];
    [self.manager POST:path parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        failure(error);
    }];
}

- (void)postFailureVoiceWithSuccess:(successResponse)success failure:(failureResponse)failure {
    
    NSString *path = [NSString stringWithFormat:@"http://%@/api/auth/voice", [IPHandler IP]];
    [self.manager POST:path parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        failure(error);
    }];
}


@end
