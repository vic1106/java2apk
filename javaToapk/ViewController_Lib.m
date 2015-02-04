//
//  ViewController_Lib.m
//  java2apk
//
//  Created by cpuser on 3/2/15.
//  Copyright (c) 2015 cpuser. All rights reserved.
//

#import "ViewController_Lib.h"

@interface ViewController_Lib ()

@end

@implementation ViewController_Lib

- (void)viewDidLoad {
    [super viewDidLoad];
    
}


- (IBAction)btn_Lib:(id)sender {
    
    
    NSString *libLocation =[tf_Lib stringValue];
     NSString *target =[tf_target stringValue];
    NSString * decrunch = [NSString stringWithFormat:@"%@/bin/res",libLocation];
    
    
    NSString * launchPath = @"/bin/rm";
    NSArray *arguments = [NSArray arrayWithObjects:
                          @"-R",
                          @"crunch",
                          nil];
    NSString * launchPath2 = @"/Users/cpuser/Documents/adt-bundle-mac-x86_64-20140702/sdk/tools/android";
    if([target isEqualToString:@""]){
        arguments2 = [NSArray arrayWithObjects:
                      @"update",
                      @"lib-project",
                      @"-p",
                      libLocation,
                      nil];
    }else{
        arguments2 = [NSArray arrayWithObjects:
                      @"update",
                      @"lib-project",
                      @"-p",
                      libLocation,
                      @"-t",
                      target,
                      nil];
         }
    
    NSString* filePath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString* fileName = @"libRecord_j2a.txt";
    NSString* fileAtPath = [filePath stringByAppendingPathComponent:fileName];
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:fileAtPath]) {
        [[NSFileManager defaultManager] createFileAtPath:fileAtPath contents:nil attributes:nil];
    }
    NSString *contents = [NSString stringWithContentsOfFile:fileAtPath];
    NSArray *arr = [contents componentsSeparatedByCharactersInSet:
                    [NSCharacterSet characterSetWithCharactersInString:@"\n"]];
    
    NSLog(@"%d",(int)arr.count);

    
        for(int i=0;i<arr.count;i++){
            
            originalString = arr[i];
            
            NSLog(@"%@ %@", libLocation, originalString);
            
            if(![originalString isEqualToString: libLocation]){
                d=i;
            }else{
                break;
            }
        }
    if(d==arr.count-1){
        contents = [contents stringByAppendingString:[NSString stringWithFormat:@"%@\n",libLocation]];
        [contents writeToFile:fileAtPath atomically:YES encoding:NSUTF8StringEncoding error:nil];
    }
    
    
    
    NSString* output1=runCommand2(decrunch, launchPath,arguments);
    NSString* output2=runCommand2(libLocation, launchPath2,arguments2);
    NSLog(@"%@\n%@\n",output1,output2);
    NSString *string = [NSString stringWithFormat:@"%@\n%@\n",output1,output2];
   [tv_Lib setString:string];
}

- (IBAction)btn_Chk:(id)sender {
    
    NSString* filePath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString* fileName = @"libRecord_j2a.txt";
    NSString* fileAtPath = [filePath stringByAppendingPathComponent:fileName];
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:fileAtPath]) {
        [[NSFileManager defaultManager] createFileAtPath:fileAtPath contents:nil attributes:nil];
    }
    NSString *contents = [NSString stringWithContentsOfFile:fileAtPath];
    NSArray *arr = [contents componentsSeparatedByCharactersInSet:
                    [NSCharacterSet characterSetWithCharactersInString:@"\n"]];
    
    for(int i=0;i<arr.count;i++){
        
        originalString = arr[i];
        
        NSString *target =[tf_target stringValue];
        NSString * decrunch = [NSString stringWithFormat:@"%@/bin/res",originalString];
        
        
        NSString * launchPath = @"/bin/rm";
        NSArray *arguments = [NSArray arrayWithObjects:
                              @"-R",
                              @"crunch",
                              nil];
        NSString * launchPath2 = @"/Users/cpuser/Documents/adt-bundle-mac-x86_64-20140702/sdk/tools/android";
        if([target isEqualToString:@""]){
            arguments2 = [NSArray arrayWithObjects:
                          @"update",
                          @"lib-project",
                          @"-p",
                          originalString,
                          nil];
        }else{
            arguments2 = [NSArray arrayWithObjects:
                          @"update",
                          @"lib-project",
                          @"-p",
                          originalString,
                          @"-t",
                          target,
                          nil];
        }
        
        NSString* output1=runCommand2(decrunch, launchPath,arguments);
        NSString* output2=runCommand2(originalString, launchPath2,arguments2);
        NSLog(@"%@\n%@\n",output1,output2);
        NSString *string = [NSString stringWithFormat:@"%@\n%@\n",output1,output2];
        [tv_Lib setString:string];
        
    }
}

- (IBAction)btnRemove:(id)sender {
    
}




NSString *runCommand2(NSString * currentDirectoryPath,
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
