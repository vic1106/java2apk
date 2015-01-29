//
//  ViewController.h
//  javaToapk
//
//  Created by cpuser on 28/1/15.
//  Copyright (c) 2015 cpuser. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface ViewController : NSViewController{
    NSString *output;
    NSString *output2;
    NSString *output3;
    NSString *location;
    NSString *debug;
    IBOutlet NSTextField *tf1;
    IBOutlet NSTextField *lb1;
    IBOutlet NSTextView *tv1;
}
- (IBAction)btn1:(id)sender;
- (IBAction)decrunch:(id)sender;




@end

