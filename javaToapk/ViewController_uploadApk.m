//
//  ViewController_uploadApk.m
//  javaToapk
//
//  Created by cpuser on 4/2/15.
//  Copyright (c) 2015 cpuser. All rights reserved.
//

#import "ViewController_uploadApk.h"
#import "CkoSFtp.h"
#import "CkoSFtpDir.h"
#import "CkoSFtpFile.h"


@interface ViewController_uploadApk ()

@end

@implementation ViewController_uploadApk

- (void)viewDidLoad {
    [super viewDidLoad];
    
    recordPath = [[NSBundle mainBundle] pathForResource:@"android_ant_path" ofType:@"txt"];
    
    NSString *contents = [NSString stringWithContentsOfFile:recordPath];
    arr3 = [contents componentsSeparatedByCharactersInSet:
           [NSCharacterSet characterSetWithCharactersInString:@"\n"]];
    
    NSString* serverPath=[NSString stringWithFormat:@"%@",arr3[2]];
    
    
    self.title=@"Upload Server";
    [tf_Port setStringValue:@"22"];
    [tf_FTP setStringValue:serverPath];
    [tf_apkName setStringValue:@"/"];
    // Do view setup here.
}

- (IBAction)lcPath:(id)sender {
    NSString *projectLocation  = [NSString stringWithFormat:@"%@",self.locationPath.URL.path];
    [tf_apkPath setStringValue:projectLocation];
    NSString *contents = [tf_apkPath stringValue];
    arr2 = [contents componentsSeparatedByCharactersInSet:
           [NSCharacterSet characterSetWithCharactersInString:@"/"]];
    int y=(int)arr2.count-1;
    NSString*pathElement=arr2[y];
    NSString*pathElement2=[NSString stringWithFormat:@"/%@",pathElement];
    [tf_apkName setStringValue:pathElement2];
    
}

- (IBAction)createTable:(id)sender {
//    CkoSFtp *sftp = [[CkoSFtp alloc] init];
//    
//    
//    
//    //  Any string automatically begins a fully-functional 30-day trial.
//    BOOL success = [sftp UnlockComponent: @"Anything for 30-day trial"];
//    if (success != YES) {
//        NSLog(@"%@",sftp.LastErrorText);
//        return;
//    }
//    
//    //  Set some timeouts, in milliseconds:
//    sftp.ConnectTimeoutMs = [NSNumber numberWithInt:5000];
//    sftp.IdleTimeoutMs = [NSNumber numberWithInt:10000];
//    
//    //  Connect to the SSH server.
//    //  The standard SSH port = 22
//    //  The hostname may be a hostname or IP address.
//    int port =[tf_Port intValue];
//    NSString *hostname=[tf_FTP stringValue];
////    hostname = @"www.my-sftp-server.com";
////    port = 22;
//    success = [sftp Connect: hostname port: [NSNumber numberWithInt: port]];
//    if (success != YES) {
//        NSLog(@"%@",sftp.LastErrorText);
//        return;
//    }
//    
//    //  Authenticate with the SSH server.  Chilkat SFTP supports
//    //  both password-based authenication as well as public-key
//    //  authentication.  This example uses password authenication.
//    NSString*myLogin =[tf_Name stringValue];
//    NSString*myPassword=[tf_Password stringValue];
//    success = [sftp AuthenticatePw: myLogin password: myPassword];
//    if (success != YES) {
//        NSLog(@"%@",sftp.LastErrorText);
//        return;
//    }
//    
//    //  After authenticating, the SFTP subsystem must be initialized:
//    success = [sftp InitializeSftp];
//    if (success != YES) {
//        NSLog(@"%@",sftp.LastErrorText);
//        return;
//    }
//    
//    //  Open a directory on the server...
//    //  Paths starting with a slash are "absolute", and are relative
//    //  to the root of the file system. Names starting with any other
//    //  character are relative to the user's default directory (home directory).
//    //  A path component of ".." refers to the parent directory,
//    //  and "." refers to the current directory.
//    NSString *handle;
//    handle = [sftp OpenDir: @"."];
//    if (handle == nil ) {
//        NSLog(@"%@",sftp.LastErrorText);
//        return;
//    }
//    
//    //  Download the directory listing:
//    CkoSFtpDir *dirListing = 0;
//    dirListing = [sftp ReadDir: handle];
//    if (dirListing == nil ) {
//        NSLog(@"%@",sftp.LastErrorText);
//        return;
//    }
//    
//    //  Iterate over the files.
//    int i;
//    int n = [dirListing.NumFilesAndDirs intValue];
//    if (n == 0) {
//        NSLog(@"%@",@"No entries found in this directory.");
//    }
//    else {
//        for (i = 0; i <= n - 1; i++) {
//            CkoSFtpFile *fileObj = 0;
//            fileObj = [dirListing GetFileObject: [NSNumber numberWithInt: i]];
//            NSLog(@"%@",fileObj.Filename);
//            NSLog(@"%@",fileObj.FileType);
//            NSLog(@"%@%lld",@"Size in bytes: ",[fileObj.Size64 longLongValue]);
//            NSLog(@"%@",@"----");
//            
//        }
//        
//    }
//    
//    //  Close the directory
//    success = [sftp CloseHandle: handle];
//    if (success != YES) {
//        NSLog(@"%@",sftp.LastErrorText);
//        return;
//    }
//    
//    NSLog(@"%@",@"Success.");
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
    BOOL success = [sftp UnlockComponent: @"abc"];
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
    NSString *remoteFilePath = [NSString stringWithFormat:@"/var/www/%@%@",host,apkName];
    NSString *localFilePath = path;
    success = [sftp UploadFileByName: remoteFilePath localFilePath: localFilePath];
    if (success != YES) {
        NSLog(@"%@",sftp.LastErrorText);
        [tv_detail setString:[NSString stringWithFormat:@"%@",sftp.LastErrorText]];
        return;
    }
    
    
    NSLog(@"%@",@"Success.");
//        NSTask *task;
//        task = [[NSTask alloc] init];
//        [task setLaunchPath: @"task date"];
        
        NSDate *currDate = [NSDate date];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
        NSDateFormatter *timeFormatter = [[NSDateFormatter alloc]init];
        [dateFormatter setDateFormat:@"dd/MM/YY HH:mm:ss"];
        NSString *dateString = [dateFormatter stringFromDate:currDate];
        NSLog(@"%@",dateString);
        
     
    [tv_detail setString:[NSString stringWithFormat:@"Upload success.\n\nUpload location: %@%@\n\nDate and Time:%@\n\n",host,apkName,dateString]];
        remotePath=[NSString stringWithFormat:@"%@%@",host,apkName];
//        NSString* filePath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
//        NSString* fileName = @"uploadRecord_j2a.txt";
//        NSString* path = [filePath stringByAppendingPathComponent:fileName];
        
         NSString *path = [[NSBundle mainBundle] pathForResource:@"uploadRecord_j2a" ofType:@"txt"];
        NSString *path2 = [[NSBundle mainBundle] pathForResource:@"dateAndtime" ofType:@"txt"];
        
        if (![[NSFileManager defaultManager] fileExistsAtPath:path]) {
            [[NSFileManager defaultManager] createFileAtPath:path contents:@"Upload Record:\n" attributes:nil];
        }
        
        if (![[NSFileManager defaultManager] fileExistsAtPath:path2]) {
            [[NSFileManager defaultManager] createFileAtPath:path2 contents:@"Date and Time:\n" attributes:nil];
        }
        
        NSString *contents = [NSString stringWithContentsOfFile:path];
        arr = [contents componentsSeparatedByCharactersInSet:
               [NSCharacterSet characterSetWithCharactersInString:@"\n"]];
        NSString *contents_time = [NSString stringWithContentsOfFile:path2];
        arr_time = [contents_time componentsSeparatedByCharactersInSet:
               [NSCharacterSet characterSetWithCharactersInString:@"\n"]];
        
            for(i=0;i<arr.count;i++){
                
                originalString = arr[i];
                
                NSLog(@"%@ %@", remotePath, originalString);
                
                if(![originalString isEqualToString: remotePath]){
                    d=i;
                }else{
                    NSString *string = @"This path added already!";
                    [lb_apkName setStringValue:string];
                    [tf_apkName setStringValue:@""];
                    break;
                }
            }
            if(d==arr.count-1){
                
                contents2 = [NSString stringWithContentsOfFile:path];
                contents2 = [contents2 stringByAppendingString:[NSString stringWithFormat:@"%@\n",remotePath]];
                [contents2 writeToFile:path atomically:YES encoding:NSUTF8StringEncoding error:nil];
                contents_time = [NSString stringWithContentsOfFile:path2];
                contents_time = [contents_time stringByAppendingString:[NSString stringWithFormat:@"%@\n",dateString]];
                [contents_time writeToFile:path2 atomically:YES encoding:NSUTF8StringEncoding error:nil];
                
            }
    }
}



- (IBAction)btn_download:(id)sender {
//    NSString * path=[tf_apkPath stringValue];
//    NSString * apkName=[tf_apkName stringValue];
//    NSString * host=[tf_FTP stringValue];
//    NSString * name=[tf_Name stringValue];
//    NSString * password=[tf_Password stringValue];
//    NSString * port1=[tf_Port stringValue];
//    
//    if([path isEqual: @""]){
//        [lb_path setStringValue:@"Please enter LOCATION PATH!"];
//    }else{
//        [lb_path setStringValue:@""];
//    }
//    if([apkName isEqual: @""]){
//        [lb_apkName setStringValue:@"Please enter REMOTE PATH!"];
//    }else{
//        [lb_apkName setStringValue:@""];
//    }
//    if([host isEqual: @""]){
//        [lb_host setStringValue:@"Please enter HOST!"];
//    }else{
//        [lb_host setStringValue:@""];
//    }
//    if([name isEqual: @""]){
//        [lb_name setStringValue:@"Please enter NAME!"];
//    }else{
//        [lb_name setStringValue:@""];
//    }
//    if([password isEqual: @""]){
//        [lb_password setStringValue:@"Please enter PASSWORD!"];
//    }else{
//        [lb_password setStringValue:@""];
//    }
//    if([port1 isEqual: @""]){
//        [lb_port setStringValue:@"Please enter PORT!"];
//    }else{
//        [lb_port setStringValue:@""];
//    }
//    if(![path isEqual: @""]&&![apkName isEqual: @""]&&![host isEqual: @""]&&![name isEqual: @""]&&![password isEqual: @""]&&![port1 isEqual: @""]){
//    
//    CkoSFtp *sftp = [[CkoSFtp alloc] init];
//    
//    //  Any string automatically begins a fully-functional 30-day trial.
//    BOOL success = [sftp UnlockComponent: @"Anything for 30-day trial"];
//    if (success != YES) {
//        NSLog(@"%@",sftp.LastErrorText);
//        [tv_detail setString:[NSString stringWithFormat:@"%@",sftp.LastErrorText]];
//        return;
//    }
//    
//    //  Set some timeouts, in milliseconds:
//    sftp.ConnectTimeoutMs = [NSNumber numberWithInt:15000];
//    sftp.IdleTimeoutMs = [NSNumber numberWithInt:15000];
//    
//    //  Connect to the SSH server.
//    //  The standard SSH port = 22
//    //  The hostname may be a hostname or IP address.
//    int port;
//    port = [tf_Port intValue];
//    success = [sftp Connect: host port: [NSNumber numberWithInt: port]];
//    if (success != YES) {
//        NSLog(@"%@",sftp.LastErrorText);
//        [tv_detail setString:[NSString stringWithFormat:@"%@",sftp.LastErrorText]];
//        return;
//    }
//    
//    //  Authenticate with the SSH server.  Chilkat SFTP supports
//    //  both password-based authenication as well as public-key
//    //  authentication.  This example uses password authenication.
//    success = [sftp AuthenticatePw: name password: password];
//    if (success != YES) {
//        NSLog(@"%@",sftp.LastErrorText);
//        [tv_detail setString:[NSString stringWithFormat:@"%@",sftp.LastErrorText]];
//        return;
//    }
//    
//    //  After authenticating, the SFTP subsystem must be initialized:
//    success = [sftp InitializeSftp];
//    if (success != YES) {
//        NSLog(@"%@",sftp.LastErrorText);
//        [tv_detail setString:[NSString stringWithFormat:@"%@",sftp.LastErrorText]];
//        return;
//    }
//    
//    //  Download the file:
//    NSString *remoteFilePath = apkName;
//    NSString *localFilePath = path;
//    success = [sftp DownloadFileByName: remoteFilePath localFilePath: localFilePath];
//    if (success != YES) {
//        NSLog(@"%@",sftp.LastErrorText);
//        [tv_detail setString:[NSString stringWithFormat:@"%@",sftp.LastErrorText]];
//        return;
//    }
//    
//    NSLog(@"%@",@"Success.");
//    [tv_detail setString:@"Success."];
//    }
}


@end

