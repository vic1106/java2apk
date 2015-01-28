//
//  ViewController.m
//  javaToapk
//
//  Created by cpuser on 28/1/15.
//  Copyright (c) 2015 cpuser. All rights reserved.
//

#import "ViewController.h"

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
}

- (IBAction)btn1:(id)sender {
   
    location=[tf1 stringValue];
    output=runCommand(location);
   
}

NSString *runCommand(NSString *location){
    NSTask *task;
    task = [[NSTask alloc] init];
    [task setCurrentDirectoryPath:@"/Users/cpuser/Desktop/ant"];
    [task setLaunchPath: @"/Users/cpuser/Documents/adt-bundle-mac-x86_64-20140702/sdk/tools/android"];
    NSArray *arguments = [NSArray arrayWithObjects:
                          @"android update project -p .",
                          nil];
    NSLog(@"run command: %@ ",location);
    [task setArguments: arguments];
    
    NSPipe *pipe;
    pipe = [NSPipe pipe];
    [task setStandardOutput: pipe];
    
    NSFileHandle *file;
    file = [pipe fileHandleForReading];
    
    [task launch];
    
    NSData *data;
    data = [file readDataToEndOfFile];
    
    NSString *output;
    output = [[NSString alloc] initWithData: data encoding: NSUTF8StringEncoding];
    
    return output;
}




@end
