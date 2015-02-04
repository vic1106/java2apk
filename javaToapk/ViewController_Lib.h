//
//  ViewController_Lib.h
//  java2apk
//
//  Created by cpuser on 3/2/15.
//  Copyright (c) 2015 cpuser. All rights reserved.
//

#import <Cocoa/Cocoa.h>



@interface ViewController_Lib : NSViewController{
    NSArray *arguments2;
    NSString *originalString;
    int d;
    
    IBOutlet NSTextView *tv_Lib;
    IBOutlet NSTextField *tf_Lib;
    IBOutlet NSTextField *tf_target;
    
}
- (IBAction)btn_Lib:(id)sender;
- (IBAction)btn_Chk:(id)sender;
- (IBAction)btnRemove:(id)sender;



@end
