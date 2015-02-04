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
}

- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];

}

- (IBAction)btn1:(id)sender {
   
    NSString *location=[tf1 stringValue];
    NSString * decrunch = [NSString stringWithFormat:@"%@/bin/res",location];
    NSString * currentDirectoryPath = [NSString stringWithFormat:@"%@",location];
    
    
    NSString * launchPath = @"/bin/rm";
    NSArray *arguments = [NSArray arrayWithObjects:
                          @"-R",
                          @"crunch",
                          nil];
    
    NSString * launchPath2 = @"/Users/cpuser/Documents/adt-bundle-mac-x86_64-20140702/sdk/tools/android";
    NSArray *arguments2 = [NSArray arrayWithObjects:
                           @"update",
                           @"project",
                           @"-p",
                           currentDirectoryPath,
                           @"-s",
                           nil];
    
    NSString * launchPath3 = @"/Users/cpuser/Desktop/apache-ant-1.9.4/bin/ant";
    NSArray *arguments3 = [NSArray arrayWithObjects:
                           @"debug",
                           nil];
    
    NSString*output1=runCommand(decrunch, launchPath,arguments);
    NSString*output2=runCommand(nil, launchPath2,arguments2);
    NSString*output3=runCommand( currentDirectoryPath,launchPath3,arguments3);
    
    NSLog(@"%@\n%@\n%@",output1,output2,output3);
    NSString *string = [NSString stringWithFormat:@"%@\n%@\n%@",output1,output2,output3];
    [tv1 setString:string];
    
    
   
}


NSString *runCommand(NSString * currentDirectoryPath,
                     NSString * launchPath,
                     NSArray * arguments1
                     ){
    NSTask *task;
    
    task = [[NSTask alloc] init];
    if(currentDirectoryPath!=nil){
        [task setCurrentDirectoryPath:currentDirectoryPath];
    }
    [task setLaunchPath: launchPath];
    NSArray *arguments = arguments1;
    
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
