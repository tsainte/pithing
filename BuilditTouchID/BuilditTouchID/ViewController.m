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
@property (nonatomic, strong) NSString *hash;

@end

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.api = [NetworkAPI new];
    self.hash = [[UIDevice currentDevice] name];
    [self refreshIPButtonTitle];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)configureIP:(id)sender {
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Setting new address" message:@"Please enter your new IP and port" preferredStyle:UIAlertControllerStyleAlert];
    
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = [IPHandler IP];
    }];
    
    UIAlertAction *nevermindAction = [UIAlertAction actionWithTitle:@"Nevermind" style:UIAlertActionStyleDefault handler:nil];
    [alert addAction:nevermindAction];
    
    UIAlertAction *doneAction = [UIAlertAction actionWithTitle:@"Done" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        UITextField *ipTextfield = [alert.textFields firstObject];
        NSString *ip = [ipTextfield text];
        
        [IPHandler setIP:ip];
        [self refreshIPButtonTitle];
    }];
    [alert addAction:doneAction];
    
    [self presentViewController:alert animated:YES completion:nil];
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
                                    
                                    [self.api postSuccessFingerprintWithHash:self.hash success:^(id object) {
                                        [self alertMessage:@"Door open 👯"];
                                    } failure:^(NSError *error) {
                                        [self alertMessage:@"Door not open: we don't know who you are 😤"];
                                    }];
                                } else {
                                    
                                    [self.api postFailureFingerprintWithSuccess:^(id object) {
                                        [self alertMessage:@"Door not open: can't recognize your finger 😦"];
                                    } failure:^(NSError *error) {
                                        [self alertMessage:@"Door not open: can't recognize your finger 😦"];
                                    }];
                                }
                            }];
    } else {
        // Could not evaluate policy; look at authError and present an appropriate message to user
    }
}

- (IBAction)microphoneTapped:(id)sender {
//    
//    [self.api postSuccessVoiceWithHash:self.hash success:^(id object) {
//        
//    } failure:];
}

#pragma mark - UI helpers

- (void)alertMessage:(NSString*)message {
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:message message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
    [alert addAction:action];
    
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)refreshIPButtonTitle {
    
    [self.ipButton setTitle:[IPHandler IP] forState:UIControlStateNormal];
}


@end
