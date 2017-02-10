//
//  NetworkAPI.h
//  BuilditTouchID
//
//  Created by Tiago Bencardino on 10/02/2017.
//  Copyright © 2017 Juliana Cipa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IPHandler.h"

typedef void(^successResponse)(id object);
typedef void(^failureResponse)(NSError *error);


@interface NetworkAPI : NSObject

#pragma mark - fingerprint
- (void)postSuccessFingerprintWithHash:(NSString *)hash success:(successResponse)success failure:(failureResponse)failure;
- (void)postFailureFingerprintWithSuccess:(successResponse)success failure:(failureResponse)failure;

#pragma mark - voice
- (void)postSuccessVoiceWithHash:(NSString *)hash success:(successResponse)success failure:(failureResponse)failure;
- (void)postFailureVoiceWithSuccess:(successResponse)success failure:(failureResponse)failure;

@end
