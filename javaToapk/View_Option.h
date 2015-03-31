//
//  View_Option.h
//  javaToapk
//
//  Created by cpuser on 24/3/15.
//  Copyright (c) 2015 cpuser. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface View_Option : NSViewController{
    
    IBOutlet NSTextField *path_ant;
    IBOutlet NSTextField *path_android;
    
    int i;
    
    NSArray *arr;
    NSString* androidPath;
    NSString* antPath;
    NSString* serverPath;
    NSString* contents;
    NSString* keyPath;
    NSString* keyName;
    NSString* keypw1;
    NSString* keypw2;
    IBOutlet NSTextField *path_server;
    
    NSString *path;
    IBOutlet NSTextField *lb_okay;
    IBOutlet NSTextField *keyStore;
    IBOutlet NSTextField *keyAlias;
    IBOutlet NSTextField *keyStore_pw;
    IBOutlet NSTextField *keyAlias_pw;
}
- (IBAction)bt_save:(id)sender;

@end
