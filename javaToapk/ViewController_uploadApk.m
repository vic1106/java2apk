//
//  ViewController_uploadApk.m
//  javaToapk
//
//  Created by cpuser on 4/2/15.
//  Copyright (c) 2015 cpuser. All rights reserved.
//

#import "ViewController_uploadApk.h"

#import "CkoSFtp.h"

@interface ViewController_uploadApk ()

@end

@implementation ViewController_uploadApk

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do view setup here.
}



- (IBAction)btn_upload:(id)sender {
    
    
    //  Important: It is helpful to send the contents of the
    //  sftp.LastErrorText property when requesting support.
    
    CkoSFtp *sftp = [[CkoSFtp alloc] init];
    
    //  Any string automatically begins a fully-functional 30-day trial.
    BOOL success = [sftp UnlockComponent: @"Anything for 30-day trial"];
    if (success != YES) {
        NSLog(@"%@",sftp.LastErrorText);
        return;
    }
    
    //  Set some timeouts, in milliseconds:
    sftp.ConnectTimeoutMs = [NSNumber numberWithInt:15000];
    sftp.IdleTimeoutMs = [NSNumber numberWithInt:15000];
    
    //  Connect to the SSH server.
    //  The standard SSH port = 22
    //  The hostname may be a hostname or IP address.
    int port;
    NSString *hostname;
    hostname = [NSString stringWithFormat:@"%@", tf_FTP];
    port = 22;
    success = [sftp Connect: hostname port: [NSNumber numberWithInt: port]];
    if (success != YES) {
        NSLog(@"%@",sftp.LastErrorText);
        return;
    }
    
    //  Authenticate with the SSH server.  Chilkat SFTP supports
    //  both password-based authenication as well as public-key
    //  authentication.  This example uses password authenication.
    success = [sftp AuthenticatePw: [NSString stringWithFormat:@"%@", tf_Name] password: [NSString stringWithFormat:@"%@", tf_Password]];
    if (success != YES) {
        NSLog(@"%@",sftp.LastErrorText);
        return;
    }
    
    //  After authenticating, the SFTP subsystem must be initialized:
    success = [sftp InitializeSftp];
    if (success != YES) {
        NSLog(@"%@",sftp.LastErrorText);
        return;
    }
    
    //  Upload from the local file to the SSH server.
    //  Important -- the remote filepath is the 1st argument,
    //  the local filepath is the 2nd argument;
    NSString *remoteFilePath = [NSString stringWithFormat:@"%@", tf_apkName];
    NSString *localFilePath = [NSString stringWithFormat:@"%@", tf_apkPath];
    
    success = [sftp UploadFileByName: remoteFilePath localFilePath: localFilePath];
    if (success != YES) {
        NSLog(@"%@",sftp.LastErrorText);
        return;
    }
    
    NSLog(@"%@",@"Success.");

}



@end

