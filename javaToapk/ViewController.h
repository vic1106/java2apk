//
//  ViewController.h
//  javaToapk
//
//  Created by cpuser on 28/1/15.
//  Copyright (c) 2015 cpuser. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface ViewController : NSViewController<NSApplicationDelegate, NSTableViewDelegate,NSTableViewDataSource>{
    
    IBOutlet NSTextField *tf1;
    IBOutlet NSTextView *tv1;
    
    IBOutlet NSTableView *table;
    NSArray *_dataSource;
    NSArray *arr;
    
}
- (IBAction)btn1:(id)sender;



@end

