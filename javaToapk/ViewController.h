//
//  ViewController.h
//  javaToapk
//
//  Created by cpuser on 28/1/15.
//  Copyright (c) 2015 cpuser. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface ViewController : NSViewController<NSApplicationDelegate, NSTableViewDelegate,NSTableViewDataSource>{
    
    int i;
    int d;
    int k;
    int p;
    int s;
    NSString *originalString;
    NSArray *arguments2;
    
    IBOutlet NSTextField *tf1;
    IBOutlet NSTextField *tf_target;
    IBOutlet NSTextView *tv1;
    IBOutlet NSTextView *tv_detail;
    
    IBOutlet NSTableView *table;
    NSArray *_dataSource;
    NSArray *arr;
    IBOutlet NSTextField *lb_warning;
    IBOutlet NSTextField *tf_Name;
    NSArray* arr_option;
    NSString*androidPath;
    NSString*antPath;
    NSString*updateType;
    NSString*contents_keyPath;
    IBOutlet NSTextField *apkRl_path;
    IBOutlet NSTextField *apkRl_name;
    
    NSString* keyPath;
    NSString* keyName;
    NSString* keypw1;
    NSString* keypw2;
    
    NSString * currentDirectoryPath4;
    NSString * launchPath4;
    NSArray *arguments4;
}
- (IBAction)btn1:(id)sender;
@property (strong) IBOutlet NSPathControl *locationPath;
- (IBAction)lcPath:(id)sender;
- (IBAction)btn_release:(id)sender;
- (IBAction)btn_update:(id)sender;
- (IBAction)btn_deleteCrunch:(id)sender;
- (IBAction)btnRemove:(id)sender;


@end

