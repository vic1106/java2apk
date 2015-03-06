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
    
}
- (IBAction)btn1:(id)sender;
@property (strong) IBOutlet NSPathControl *locationPath;
- (IBAction)lcPath:(id)sender;




@end

