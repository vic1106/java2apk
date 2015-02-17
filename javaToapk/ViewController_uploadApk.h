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
    IBOutlet NSTextView *tv_apk;
    IBOutlet NSTextField *tf_FTP;
    IBOutlet NSTextField *tf_Name;
    IBOutlet NSTextField *tf_Password;
    IBOutlet NSTextField *tf_apkName;
    IBOutlet NSTextField *tf_Port;
    
//    BRRequestUpload *uploadData;  // Black Raccoon's upload object
//    NSData *uploadData;
}
- (IBAction)btn_upload:(id)sender;

@end
