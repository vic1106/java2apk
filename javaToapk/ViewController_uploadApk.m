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
    self.title=@"Upload Server";
    [tf_Port setStringValue:@"22"];
    [tf_FTP setStringValue:@"/var/www/download.cherrypicks.com/"];
    // Do view setup here.
}

- (IBAction)lcPath:(id)sender {
    NSString *projectLocation  = [NSString stringWithFormat:@"%@",self.locationPath.URL.path];
    [tf_apkPath setStringValue:projectLocation];
    
}

- (IBAction)btn_upload:(id)sender {
    NSString * path=[tf_apkPath stringValue];
    NSString * apkName=[tf_apkName stringValue];
    NSString * host=[tf_FTP stringValue];
    NSString * name=[tf_Name stringValue];
    NSString * password=[tf_Password stringValue];
    NSString * port1=[tf_Port stringValue];
    
    if([path isEqual: @""]){
        [lb_path setStringValue:@"Please enter LOCATION PATH!"];
    }else{
        [lb_path setStringValue:@""];
    }
    if([apkName isEqual: @""]){
        [lb_apkName setStringValue:@"Please enter REMOTE PATH!"];
    }else{
        [lb_apkName setStringValue:@""];
    }
    if([host isEqual: @""]){
        [lb_host setStringValue:@"Please enter HOST!"];
    }else{
        [lb_host setStringValue:@""];
    }
    if([name isEqual: @""]){
        [lb_name setStringValue:@"Please enter NAME!"];
    }else{
        [lb_name setStringValue:@""];
    }
    if([password isEqual: @""]){
        [lb_password setStringValue:@"Please enter PASSWORD!"];
    }else{
        [lb_password setStringValue:@""];
    }
    if([port1 isEqual: @""]){
        [lb_port setStringValue:@"Please enter PORT!"];
    }else{
        [lb_port setStringValue:@""];
    }
    
    //  Important: It is helpful to send the contents of the
    //  sftp.LastErrorText property when requesting support.
    if(![path isEqual: @""]&&![apkName isEqual: @""]&&![host isEqual: @""]&&![name isEqual: @""]&&![password isEqual: @""]&&![port1 isEqual: @""]){
        
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
        port = [tf_Port intValue];
        success = [sftp Connect: host port: [NSNumber numberWithInt: port]];
        if (success != YES) {
            NSLog(@"%@",sftp.LastErrorText);
            [tv_detail setString:[NSString stringWithFormat:@"%@",sftp.LastErrorText]];
                        return;
        
        }
    //  Authenticate with the SSH server.  Chilkat SFTP supports
    //  both password-based authenication as well as public-key
    //  authentication.  This example uses password authenication.
    success = [sftp AuthenticatePw: name password: password];
    if (success != YES) {
        NSLog(@"%@",sftp.LastErrorText);
        [tv_detail setString:[NSString stringWithFormat:@"%@",sftp.LastErrorText]];
        return;
    }
    
    //  After authenticating, the SFTP subsystem must be initialized:
    success = [sftp InitializeSftp];
    if (success != YES) {
        NSLog(@"%@",sftp.LastErrorText);
        [tv_detail setString:[NSString stringWithFormat:@"%@",sftp.LastErrorText]];
        return;
    }
    
    //  Upload from the local file to the SSH server.
    //  Important -- the remote filepath is the 1st argument,
    //  the local filepath is the 2nd argument;
    NSString *remoteFilePath = apkName;
    NSString *localFilePath = path;
    
    success = [sftp UploadFileByName: remoteFilePath localFilePath: localFilePath];
    if (success != YES) {
        NSLog(@"%@",sftp.LastErrorText);
        [tv_detail setString:[NSString stringWithFormat:@"%@",sftp.LastErrorText]];
        return;
    }
    
    NSLog(@"%@",@"Success.");
    [tv_detail setString:@"Success."];

    }
}

- (IBAction)btn_download:(id)sender {
    NSString * path=[tf_apkPath stringValue];
    NSString * apkName=[tf_apkName stringValue];
    NSString * host=[tf_FTP stringValue];
    NSString * name=[tf_Name stringValue];
    NSString * password=[tf_Password stringValue];
    NSString * port1=[tf_Port stringValue];
    
    if([path isEqual: @""]){
        [lb_path setStringValue:@"Please enter LOCATION PATH!"];
    }else{
        [lb_path setStringValue:@""];
    }
    if([apkName isEqual: @""]){
        [lb_apkName setStringValue:@"Please enter REMOTE PATH!"];
    }else{
        [lb_apkName setStringValue:@""];
    }
    if([host isEqual: @""]){
        [lb_host setStringValue:@"Please enter HOST!"];
    }else{
        [lb_host setStringValue:@""];
    }
    if([name isEqual: @""]){
        [lb_name setStringValue:@"Please enter NAME!"];
    }else{
        [lb_name setStringValue:@""];
    }
    if([password isEqual: @""]){
        [lb_password setStringValue:@"Please enter PASSWORD!"];
    }else{
        [lb_password setStringValue:@""];
    }
    if([port1 isEqual: @""]){
        [lb_port setStringValue:@"Please enter PORT!"];
    }else{
        [lb_port setStringValue:@""];
    }
    if(![path isEqual: @""]&&![apkName isEqual: @""]&&![host isEqual: @""]&&![name isEqual: @""]&&![password isEqual: @""]&&![port1 isEqual: @""]){
    
    CkoSFtp *sftp = [[CkoSFtp alloc] init];
    
    //  Any string automatically begins a fully-functional 30-day trial.
    BOOL success = [sftp UnlockComponent: @"Anything for 30-day trial"];
    if (success != YES) {
        NSLog(@"%@",sftp.LastErrorText);
        [tv_detail setString:[NSString stringWithFormat:@"%@",sftp.LastErrorText]];
        return;
    }
    
    //  Set some timeouts, in milliseconds:
    sftp.ConnectTimeoutMs = [NSNumber numberWithInt:15000];
    sftp.IdleTimeoutMs = [NSNumber numberWithInt:15000];
    
    //  Connect to the SSH server.
    //  The standard SSH port = 22
    //  The hostname may be a hostname or IP address.
    int port;
    port = [tf_Port intValue];
    success = [sftp Connect: host port: [NSNumber numberWithInt: port]];
    if (success != YES) {
        NSLog(@"%@",sftp.LastErrorText);
        [tv_detail setString:[NSString stringWithFormat:@"%@",sftp.LastErrorText]];
        return;
    }
    
    //  Authenticate with the SSH server.  Chilkat SFTP supports
    //  both password-based authenication as well as public-key
    //  authentication.  This example uses password authenication.
    success = [sftp AuthenticatePw: name password: password];
    if (success != YES) {
        NSLog(@"%@",sftp.LastErrorText);
        [tv_detail setString:[NSString stringWithFormat:@"%@",sftp.LastErrorText]];
        return;
    }
    
    //  After authenticating, the SFTP subsystem must be initialized:
    success = [sftp InitializeSftp];
    if (success != YES) {
        NSLog(@"%@",sftp.LastErrorText);
        [tv_detail setString:[NSString stringWithFormat:@"%@",sftp.LastErrorText]];
        return;
    }
    
    //  Download the file:
    NSString *remoteFilePath = apkName;
    NSString *localFilePath = path;
    success = [sftp DownloadFileByName: remoteFilePath localFilePath: localFilePath];
    if (success != YES) {
        NSLog(@"%@",sftp.LastErrorText);
        [tv_detail setString:[NSString stringWithFormat:@"%@",sftp.LastErrorText]];
        return;
    }
    
    NSLog(@"%@",@"Success.");
    [tv_detail setString:@"Success."];
    }
}


//- (void) awakeFromNib {
//    
//    NSString* filePath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
//    NSString* fileName = @"locationPath.txt";
//    NSString* fileAtPath = [filePath stringByAppendingPathComponent:fileName];
//    
//    
//    
//    
//    NSString *contents= [NSString stringWithContentsOfFile:fileAtPath];
//    arr = [contents componentsSeparatedByCharactersInSet:
//           [NSCharacterSet characterSetWithCharactersInString:@"\n"]];
//    
//    
//    _dataSource = arr;
//    table.dataSource = self;
//    table.delegate = self;
//    
//    
//}
//
//- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView {
//    return _dataSource.count;
//}
//
//- (id)tableView:(NSTableView *)tableView objectValueForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row;
//{
//    return [_dataSource objectAtIndex:row];
//}
//
//- (BOOL)tableView:(NSTableView *)tableView shouldEditTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row
//{
//    return NO;
//}
//
//- (void)tableViewSelectionDidChange:(NSNotification *)notification {
//    NSLog(@"tableViewSelectionDidChange - %ld", table.selectedRow);
//    if(table.selectedRow!=0){
//        NSString *abc = [NSString stringWithFormat:@"%@",arr[table.selectedRow]];
//        [tf_apkPath setStringValue: abc];
//    }
//    
//}
@end

