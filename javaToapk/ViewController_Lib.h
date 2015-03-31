//
//  ViewController_Lib.h
//  java2apk
//
//  Created by cpuser on 3/2/15.
//  Copyright (c) 2015 cpuser. All rights reserved.
//

#import <Cocoa/Cocoa.h>



@interface ViewController_Lib : NSViewController<NSApplicationDelegate, NSTableViewDelegate,NSTableViewDataSource>{
    NSArray *arguments2;
    NSString *originalString;
    int d;
    int i;
    
    IBOutlet NSTextView *tv_Lib;
    IBOutlet NSTextField *tf_Lib;
    IBOutlet NSTextField *tf_target;
    IBOutlet NSTextView *tv_detail;
    
    IBOutlet NSTextField *lb_warning;
    IBOutlet NSTableView *table;
    NSArray *_dataSource;
    NSArray *arr;
    
     NSArray *arr_option;
    NSString *androidPath;
    NSString* antPath;
}
- (IBAction)btn_Lib:(id)sender;
- (IBAction)btn_Chk:(id)sender;
- (IBAction)btnRemove:(id)sender;

@property (strong) IBOutlet NSPathControl *locationPath;
- (IBAction)lcPath:(id)sender;



@end
