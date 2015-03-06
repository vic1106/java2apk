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
    
    NSString *projectLocation  = [NSString stringWithFormat:@"%@",self.locationPath.URL.path];
    [tf1 setStringValue:projectLocation];
    self.title=@"Build App";
    
    NSString *target_list = [NSString stringWithFormat:@"%@\n\nTarget list : \n%@\n%@\n%@\n%@\n%@\n%@\n%@\n",
                             @"1. Put the android project path in the\n    textField / Enter the target\n2. Click the Create button",
                             @"1- Android 4.1.2, API level: 16",
                             @"2- Android 4.4.2, API level: 19",
                             @"3- Android 4.4W, API level: 20",
                             @"4- Google APIs, Android 4.1.2, API level: 16",
                             @"5- Glass Development Kit Preview, Android 4.4.2, API level: 19",
                             @"6- Google APIs, Android 4.4.2, API level: 19",
                             @"7- Google APIs (x86 System Image), Android 4.4.2, API level: 19"
                             ];
    [tv_detail setString:target_list];
    
}

- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];

}

- (IBAction)lcPath:(id)sender {
    NSString *projectLocation  = [NSString stringWithFormat:@"%@",self.locationPath.URL.path];
    [tf1 setStringValue:projectLocation];
    
}

- (IBAction)btn1:(id)sender {
    
    NSString* filePath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString* fileName = @"locationPath.txt";
    NSString* fileAtPath = [filePath stringByAppendingPathComponent:fileName];
    NSString *target =[tf_target stringValue];
    NSString *name =[tf_Name stringValue];
    
    NSString *location=[tf1 stringValue];
    if(![location isEqual: @""]){
        
             NSString * decrunch = [NSString stringWithFormat:@"%@/bin/res",location];
             NSString * currentDirectoryPath = [NSString stringWithFormat:@"%@",location];
             
             
             NSString * launchPath = @"/bin/rm";
             NSArray *arguments = [NSArray arrayWithObjects:
                                   @"-R",
                                   @"crunch",
                                   nil];
             
             NSString * launchPath2 = @"~/adt-bundle-mac-x86_64-20140702/sdk/tools/android";
        if([target isEqualToString:@""]){
            if([name isEqualToString:@""]){
                arguments2 = [NSArray arrayWithObjects:
                              @"update",
                              @"project",
                              @"-p",
                              currentDirectoryPath,
                              @"-s",
                              @"-n",
                              @"test",
                              nil];
            }else{
                arguments2 = [NSArray arrayWithObjects:
                              @"update",
                              @"project",
                              @"-p",
                              currentDirectoryPath,
                              @"-t",
                              target,
                              @"-s",
                              @"-n",
                              @"test",
                              nil];
            }
        }else{
            if(![name isEqualToString:@""]){
                arguments2 = [NSArray arrayWithObjects:
                              @"update",
                              @"project",
                              @"-p",
                              currentDirectoryPath,
                              @"-s",
                              @"-n",
                              name,
                              nil];
            }else{
                arguments2 = [NSArray arrayWithObjects:
                              @"update",
                              @"project",
                              @"-p",
                              currentDirectoryPath,
                              @"-t",
                              target,
                              @"-s",
                              @"-n",
                              name,
                              nil];
            }
        }
        
             NSString * launchPath3 = @"~/apache-ant-1.9.4/bin/ant";
             NSArray *arguments3 = [NSArray arrayWithObjects:
                                    @"debug",
                                    nil];
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:fileAtPath]) {
        [[NSFileManager defaultManager] createFileAtPath:fileAtPath contents:@"Location Path:\n" attributes:nil];
    }
    NSString *contents = [NSString stringWithContentsOfFile:fileAtPath];
    arr = [contents componentsSeparatedByCharactersInSet:
           [NSCharacterSet characterSetWithCharactersInString:@"\n"]];
    
    for(i=0;i<arr.count;i++){
        
        originalString = arr[i];
        
        NSLog(@"%@ %@", location, originalString);
        
        if(![originalString isEqualToString: location]){
            d=i;
        }else{
            NSString *string = @"Added already!";
            [lb_warning setStringValue:string];
            [tf1 setStringValue:@""];
            break;
        }
    }
   
    if(d==arr.count-1){
    
    NSString*output1=runCommand(decrunch, launchPath,arguments);
    NSString*output2=runCommand(nil, launchPath2,arguments2);
    NSString*output3=runCommand( currentDirectoryPath,launchPath3,arguments3);
        
    contents = [contents stringByAppendingString:[NSString stringWithFormat:@"%@\n",currentDirectoryPath]];
    [contents writeToFile:fileAtPath atomically:YES encoding:NSUTF8StringEncoding error:nil];
    
    NSLog(@"%@\n%@\n%@",output1,output2,output3);
        NSString *string = [NSString stringWithFormat:@"%@\n%@\n%@",output1,output2,output3];
        [tv1 setString:string];
    }else{
        NSString*output1=runCommand(decrunch, launchPath,arguments);
        NSString*output2=runCommand(nil, launchPath2,arguments2);
        NSString*output3=runCommand( currentDirectoryPath,launchPath3,arguments3);
        NSLog(@"%@\n%@\n%@",output1,output2,output3);
        NSString *string = [NSString stringWithFormat:@"%@\n%@\n%@",output1,output2,output3];
        [tv1 setString:string];
    }
    }else{
        [lb_warning setStringValue:@"Please enter a path!"];
    }
    
    
   
}



- (void) awakeFromNib {
    
    NSString* filePath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString* fileName = @"locationPath.txt";
    NSString* fileAtPath = [filePath stringByAppendingPathComponent:fileName];
    
    NSString *contents= [NSString stringWithContentsOfFile:fileAtPath];
    arr = [contents componentsSeparatedByCharactersInSet:
           [NSCharacterSet characterSetWithCharactersInString:@"\n"]];
    
    _dataSource = arr;
    table.dataSource = self;
    table.delegate = self;
    
}

- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView {
    return _dataSource.count;
}

- (id)tableView:(NSTableView *)tableView objectValueForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row;
{
    return [_dataSource objectAtIndex:row];
}

- (BOOL)tableView:(NSTableView *)tableView shouldEditTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row
{
    return NO;
}

- (void)tableViewSelectionDidChange:(NSNotification *)notification {
    NSLog(@"tableViewSelectionDidChange - %ld", table.selectedRow);
    if(table.selectedRow!=0){
        NSString *abc = [NSString stringWithFormat:@"%@",arr[table.selectedRow]];
        [tv1 setString:abc];
        [tf1 setStringValue: abc];
    }else{
        [tv1 setString:@""];
    }
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
