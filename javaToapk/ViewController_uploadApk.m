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
    [comboBox setStringValue:@"/"];
    NSString *path_combo = [[NSBundle mainBundle] pathForResource:@"uploadRecord_sht" ofType:@"txt"];
    
    NSString *contents_combo= [NSString stringWithContentsOfFile:path_combo];
    comboBoxItems = [contents_combo componentsSeparatedByCharactersInSet:
                     [NSCharacterSet characterSetWithCharactersInString:@"\n"]];
    // Do view setup here.
}

//Choose the file
- (IBAction)lcPath:(id)sender {
    NSString *projectLocation  = [NSString stringWithFormat:@"%@",self.locationPath.URL.path];
    [tf_apkPath setStringValue:projectLocation];
    NSString *contents = [tf_apkPath stringValue];
    arr2 = [contents componentsSeparatedByCharactersInSet:
           [NSCharacterSet characterSetWithCharactersInString:@"/"]];
    int y=(int)arr2.count-1;
    NSString*pathElement=arr2[y];
    NSString*pathElement2=[NSString stringWithFormat:@"/%@",pathElement];
    [comboBox setStringValue:pathElement2];
    
}

//Upload the file to SFTP server
- (IBAction)btn_upload:(id)sender {
    
    NSString * path=[tf_apkPath stringValue];
    NSString * apkName=[comboBox stringValue];
    NSString * host=[tf_FTP stringValue];
    NSString * name=[tf_Name stringValue];
    NSString * password=[tf_Password stringValue];
    NSString * port1=[tf_Port stringValue];
    NSString *path2 = [[NSBundle mainBundle] pathForResource:@"uploadRecord_j2a" ofType:@"txt"];
    NSString *path_combo = [[NSBundle mainBundle] pathForResource:@"uploadRecord_sht" ofType:@"txt"];
    
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
    remotePath=[NSString stringWithFormat:@"%@%@",host,apkName];
    [tv_detail setString:[NSString stringWithFormat:@"Upload success!!\n\n\n\nUpload location:\n%@\n\n\n\n",remotePath]];
//        NSString* filePath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
//        NSString* fileName = @"uploadRecord_j2a.txt";
//        NSString* path = [filePath stringByAppendingPathComponent:fileName];
//        if (![[NSFileManager defaultManager] fileExistsAtPath:path]) {
//            [[NSFileManager defaultManager] createFileAtPath:path contents:@"Upload Record:\n" attributes:nil];
//        }
//        
//        if (![[NSFileManager defaultManager] fileExistsAtPath:path2]) {
//            [[NSFileManager defaultManager] createFileAtPath:path2 contents:@"Date and Time:\n" attributes:nil];
//        }
        
        NSString *contents = [NSString stringWithContentsOfFile:path2];
        arr = [contents componentsSeparatedByCharactersInSet:
               [NSCharacterSet characterSetWithCharactersInString:@"\n"]];
        
            for(i=0;i<arr.count;i++){
                
                originalString = arr[i];
                originalString2 = comboBoxItems[i];
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
                
                contents2 = [NSString stringWithContentsOfFile:path2];
                contents2 = [contents2 stringByAppendingString:[NSString stringWithFormat:@"%@\n",remotePath]];
                [contents2 writeToFile:path2 atomically:YES encoding:NSUTF8StringEncoding error:nil];
                
                if(arr.count>=20){
                    arr = [contents componentsSeparatedByCharactersInSet:
                           [NSCharacterSet characterSetWithCharactersInString:@"\n"]];
                    contents = @"/\n";
                    [contents writeToFile:path2 atomically:YES encoding:NSUTF8StringEncoding error:nil ];
                    
                    for(i=2;i<arr.count;i++){
                        contents = [contents stringByAppendingString:[NSString stringWithFormat:@"%@",arr[i]]];
                        [contents writeToFile:path atomically:YES encoding:NSUTF8StringEncoding error:nil];
                    }
                }
                
            }
        
        NSString *contents_combo= [NSString stringWithContentsOfFile:path_combo];
        comboBoxItems = [contents_combo componentsSeparatedByCharactersInSet:
                         [NSCharacterSet characterSetWithCharactersInString:@"\n"]];
        
        for(i=0;i<comboBoxItems.count;i++){
            
            originalString2 = comboBoxItems[i];
            NSLog(@"%@ %@", remotePath, originalString2);
        
            if(![originalString2 isEqualToString: apkName]){
                b=i;
            }else{
                NSString *string = @"This path added already!";
                [lb_apkName setStringValue:string];
                [tf_apkName setStringValue:@""];
                break;
            }
        }
            if(b==comboBoxItems.count-1){
                contents_combo = [NSString stringWithContentsOfFile:path_combo];
                NSLog(@"%@  %@",contents_combo,path_combo);
                contents_combo = [contents_combo stringByAppendingString:[NSString stringWithFormat:@"%@\n",apkName]];
                NSLog(@"%@  %@",contents_combo,path_combo);
                [contents_combo writeToFile:path_combo atomically:YES encoding:NSUTF8StringEncoding error:nil];
                NSLog(@"%@  %@",contents_combo,path_combo);
                
                if(comboBoxItems.count>=20){
                    comboBoxItems = [contents_combo componentsSeparatedByCharactersInSet:
                                     [NSCharacterSet characterSetWithCharactersInString:@"\n"]];
                    
                    contents = @"/\n";
                    [contents writeToFile:path_combo atomically:YES encoding:NSUTF8StringEncoding error:nil ];
                    
                    for(i=2;i<comboBoxItems.count;i++){
                        contents = [contents stringByAppendingString:[NSString stringWithFormat:@"%@\n",comboBoxItems[i]]];
                        [contents writeToFile:path_combo atomically:YES encoding:NSUTF8StringEncoding error:nil];
                    }
                    
                }
        }
    }
   
    NSString *contents_combo= [NSString stringWithContentsOfFile:path_combo];
    comboBoxItems = [contents_combo componentsSeparatedByCharactersInSet:
                     [NSCharacterSet characterSetWithCharactersInString:@"\n"]];
    _dataSource = comboBoxItems;
    comboBox.dataSource = self;
    comboBox.delegate = self;
    [comboBox reloadData];
}

//dropdown list
- (void)dealloc {
    
}
- (NSInteger)numberOfItemsInComboBox:(NSComboBox *)aComboBox {
    
    return [comboBoxItems count];
}
- (id)comboBox:(NSComboBox *)aComboBox objectValueForItemAtIndex:(NSInteger)index {
    if (aComboBox == comboBox) {
        i =(int) index;
        return [comboBoxItems objectAtIndex:index];
    }
    return nil;
}
- (void)comboBoxSelectionDidChange:(NSNotification *)notification {
        NSLog(@"[%@ %@] value == %@", NSStringFromClass([self class]),
              NSStringFromSelector(_cmd), [comboBoxItems objectAtIndex:
                                           [(NSComboBox *)[notification object] indexOfSelectedItem]]);
        NSString* select=[NSString stringWithFormat:@"%@",[comboBoxItems objectAtIndex:
                                                           [(NSComboBox *)[notification object] indexOfSelectedItem]]];
        NSLog(@"%@",select);
        [comboBox setStringValue:select];
}


@end

