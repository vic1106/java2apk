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
    IBOutlet NSScrollView *tv_apk;
//    BRRequestUpload *uploadData;  // Black Raccoon's upload object
//    NSData *uploadData;
}
- (IBAction)btn_upload:(id)sender;

@end
