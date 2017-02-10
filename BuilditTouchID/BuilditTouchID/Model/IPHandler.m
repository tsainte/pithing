//
//  IPHandler.m
//  BuilditTouchID
//
//  Created by Tiago Bencardino on 10/02/2017.
//  Copyright © 2017 Juliana Cipa. All rights reserved.
//

#import "IPHandler.h"

NSString * const kIP = @"IP";
NSString * const defaultIP = @"10.0.1.107:3000";

@implementation IPHandler

+ (NSString*)IP {
  
    NSString *ip = [[NSUserDefaults standardUserDefaults] objectForKey:kIP];
    
    return ip ? ip : defaultIP;
}

+ (void)setIP:(NSString*)IP {
    
    if (IP) {
        [[NSUserDefaults standardUserDefaults] setObject:IP forKey:kIP];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

@end
