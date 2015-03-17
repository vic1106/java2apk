//
//  ViewController_uploadApk.h
//  javaToapk
//
//  Created by cpuser on 4/2/15.
//  Copyright (c) 2015 cpuser. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface ViewController_uploadApk : NSViewController{
    
    IBOutlet NSTextField *tf_apkPath;
    IBOutlet NSTextField *tf_FTP;
    IBOutlet NSTextField *tf_Name;
    IBOutlet NSTextField *tf_Password;
    IBOutlet NSTextField *tf_apkName;
    IBOutlet NSTextField *tf_Port;
    IBOutlet NSTextView *tv_detail;
    IBOutlet NSTextField *lb_path;
    IBOutlet NSTextField *lb_apkName;
    IBOutlet NSTextField *lb_host;
    IBOutlet NSTextField *lb_name;
    IBOutlet NSTextField *lb_password;
    IBOutlet NSTextField *lb_port;
//    BRRequestUpload *uploadData;  // Black Raccoon's upload object
//    NSData *uploadData;
    IBOutlet NSTableView *table;
    NSArray *_dataSource;
    NSArray *arr;
    NSString* contents2;
    
}
- (IBAction)btn_upload:(id)sender;
- (IBAction)btn_download:(id)sender;
@property (strong) IBOutlet NSPathControl *locationPath;
- (IBAction)lcPath:(id)sender;

@end
