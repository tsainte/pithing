//
//  ViewController.m
//  BuilditTouchID
//
//  Created by Juliana Cipa on 10/02/2017.
//  Copyright © 2017 Juliana Cipa. All rights reserved.
//

#import "ViewController.h"
#import <LocalAuthentication/LocalAuthentication.h>
#import "NetworkAPI.h"

@interface ViewController ()

@property (nonatomic, strong) NetworkAPI *api;

@end

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.api = [NetworkAPI new];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction) btnTouchIDPressed
{
    LAContext *myContext = [[LAContext alloc] init];
    NSError *authError = nil;
    NSString *myLocalizedReasonString = @"Used for quick and secure access to the test app";
    
    if ([myContext canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&authError]) {
        [myContext evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics
                  localizedReason:myLocalizedReasonString
                            reply:^(BOOL success, NSError *error) {
                                if (success) {
                                    // User authenticated successfully, take appropriate action
                                    [self.api postSuccessFingerprintWithHash:@"hashthing" success:^(id object) {
                                        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Door open" message:nil preferredStyle:UIAlertControllerStyleAlert];
                                        UIAlertAction *action = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
                                        [alert addAction:action];
                                        
                                        [self presentViewController:alert animated:YES completion:nil];
                                    } failure:^(NSError *error) {
                                        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Door not open: we don't know who you are" message:nil preferredStyle:UIAlertControllerStyleAlert];
                                        UIAlertAction *action = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
                                        [alert addAction:action];

                                        
                                        [self presentViewController:alert animated:YES completion:nil];
                                    }];
                                } else {
                                    [self.api postFailureFingerprintWithSuccess:^(id object) {
                                        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Door not open: can't recognize your finger" message:nil preferredStyle:UIAlertControllerStyleAlert];
                                        UIAlertAction *action = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
                                        [alert addAction:action];

                                        [self presentViewController:alert animated:YES completion:nil];
                                    } failure:^(NSError *error) {
                                        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Door not open: can't recognize your finger" message:nil preferredStyle:UIAlertControllerStyleAlert];
                                        UIAlertAction *action = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
                                        [alert addAction:action];

                                        [self presentViewController:alert animated:YES completion:nil];
                                    }];
                                }
                            }];
    } else {
        // Could not evaluate policy; look at authError and present an appropriate message to user
    }
}


@end
