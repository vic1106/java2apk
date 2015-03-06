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
    self.title=@"Update Library";
    NSString *target_list = [NSString stringWithFormat:@"Target list : \n%@\n%@\n%@\n%@\n%@\n%@\n%@\n",
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

- (IBAction)lcPath:(id)sender {
    NSString *projectLocation  = [NSString stringWithFormat:@"%@",self.locationPath.URL.path];
    [tf_Lib setStringValue:projectLocation];
    
}

- (IBAction)btnRemove:(id)sender{
    
    NSString *libLocation =[tf_Lib stringValue];
    
    NSString* filePath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString* fileName = @"libRecord_j2a.txt";
    NSString* fileAtPath = [filePath stringByAppendingPathComponent:fileName];
    
    NSString *contents = [NSString stringWithContentsOfFile:fileAtPath];
    arr = [contents componentsSeparatedByCharactersInSet:
                    [NSCharacterSet characterSetWithCharactersInString:@"\n"]];
    
    NSLog(@"%d",(int)arr.count);
    
    if(![libLocation isEqualTo:@""]){
        
        contents = @"";
        [contents writeToFile:fileAtPath atomically:YES encoding:NSUTF8StringEncoding error:nil ];

        for(i=0;i<arr.count;i++){
            
            originalString = arr[i];
            
            NSLog(@"%@ %@", libLocation, originalString);
            
            if(![originalString isEqualToString: libLocation]){
                if(i==0){
                    contents = [contents stringByAppendingString:[NSString stringWithFormat:@"%@",originalString]];
                    [contents writeToFile:fileAtPath atomically:YES encoding:NSUTF8StringEncoding error:nil];
                }else{
                    contents = [contents stringByAppendingString:[NSString stringWithFormat:@"\n%@",originalString]];
                    [contents writeToFile:fileAtPath atomically:YES encoding:NSUTF8StringEncoding error:nil];
                }
            }else{
                d=i;
                break;
                
            }
            
            if(i==arr.count-1&& ![originalString isEqualToString: libLocation]){
                d=i;
                NSString *string = @"No suitable path!";
                [tv_Lib setString:string];
                [tf_Lib setStringValue:@""];
            }
        }
        
        
            for(i=d+1;i<arr.count;i++){
                
                originalString = arr[i];
                
                NSLog(@"%@ %@", libLocation, originalString);
                
                if(![originalString isEqualToString: libLocation]){
                    contents = [contents stringByAppendingString:[NSString stringWithFormat:@"\n%@",originalString]];
                    [contents writeToFile:fileAtPath atomically:YES encoding:NSUTF8StringEncoding error:nil];
//                    NSString *string = [NSString stringWithFormat:@"%@\n",contents];
//                    [tv_Record setString:string];
                    [tf_Lib setStringValue:@""];
                    [lb_warning setStringValue:@""];
                    _dataSource = arr;
                    table.dataSource = self;
                    table.delegate = self;
        }
    }
        
    }else{
        [lb_warning setStringValue:@"Please enter the path of library!"];
    }
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
    NSString * launchPath2 = @"~/adt-bundle-mac-x86_64-20140702/sdk/tools/android";
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
        [[NSFileManager defaultManager] createFileAtPath:fileAtPath contents:@"Library Record:\n" attributes:nil];
    }
    NSString *contents = [NSString stringWithContentsOfFile:fileAtPath];
    arr = [contents componentsSeparatedByCharactersInSet:
                    [NSCharacterSet characterSetWithCharactersInString:@"\n"]];
    
    
    NSLog(@"%d",(int)arr.count);
    
    if(![libLocation isEqualTo:@""]){
        
        for(i=0;i<arr.count;i++){
            
            originalString = arr[i];
            
            NSLog(@"%@ %@", libLocation, originalString);
            
            if(![originalString isEqualToString: libLocation]){
                d=i;
            }else{
                NSString *string = @"Added already!";
                [lb_warning setStringValue:string];
                [tf_Lib setStringValue:@""];
                break;
            }
        }
        if(d==arr.count-1){
            
                contents = [contents stringByAppendingString:[NSString stringWithFormat:@"%@\n",libLocation]];
                [contents writeToFile:fileAtPath atomically:YES encoding:NSUTF8StringEncoding error:nil];
            
            
            NSString* output1=runCommand2(decrunch, launchPath,arguments);
            NSString* output2=runCommand2(libLocation, launchPath2,arguments2);
            NSLog(@"%@\n%@\n",output1,output2);
            NSString *string = [NSString stringWithFormat:@"%@\n%@\n",output1,output2];
            [tv_Lib setString:string];
            [tf_Lib setStringValue:@""];
            [lb_warning setStringValue:@" "];
//            NSString *string2 = [NSString stringWithFormat:@"%@\n",contents];
//            [tv_Record setString:string2];
            
        }else{
            NSString* output1=runCommand2(decrunch, launchPath,arguments);
            NSString* output2=runCommand2(libLocation, launchPath2,arguments2);
            NSLog(@"%@\n%@\n",output1,output2);
            NSString *string = [NSString stringWithFormat:@"%@\n%@\n",output1,output2];
            [tv_Lib setString:string];
            [tf_Lib setStringValue:@""];
            NSString *string1 = @"Added already!";
            [lb_warning setStringValue:string1];
        }
    }else{
        [lb_warning setStringValue:@"Please enter the path of library!"];
    }
    
    
}

- (IBAction)btn_Chk:(id)sender {
   
    NSString* filePath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString* fileName = @"libRecord_j2a.txt";
    NSString* fileAtPath = [filePath stringByAppendingPathComponent:fileName];
    
    NSString *contents = [NSString stringWithContentsOfFile:fileAtPath];
    if(![contents isEqualToString:@"Library Record:\n"]){
        arr = [contents componentsSeparatedByCharactersInSet:
               [NSCharacterSet characterSetWithCharactersInString:@"\n"]];
        
        _dataSource = arr;
        table.dataSource = self;
        table.delegate = self;
        
        for(i=1;i<arr.count;i++){
            
            originalString = arr[i];
            
            NSString * decrunch = [NSString stringWithFormat:@"%@/bin/res",originalString];
            
            
            NSString * launchPath = @"/bin/rm";
            NSArray *arguments = [NSArray arrayWithObjects:
                                  @"-R",
                                  @"crunch",
                                  nil];
            NSString * launchPath2 = @"~/adt-bundle-mac-x86_64-20140702/sdk/tools/android";
            
            arguments2 = [NSArray arrayWithObjects:
                          @"update",
                          @"lib-project",
                          @"-p",
                          originalString,
                          nil];
            
            
            
            
            NSString* output1=runCommand2(decrunch, launchPath,arguments);
            NSString* output2=runCommand2(originalString, launchPath2,arguments2);
            NSLog(@"%@\n%@\n",output1,output2);
            
            NSString *string = [NSString stringWithFormat:@"%@\n",contents];
            [tv_Lib setString:string];
            [tf_Lib setStringValue:@""];
        }
    }else{
        [tv_Lib setString:@"No Record!"];
    }
}


- (void) awakeFromNib {
    NSString* filePath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString* fileName = @"libRecord_j2a.txt";
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
        [tf_Lib setStringValue:abc];
        [tv_Lib setString:abc];
    }else{
        [tf_Lib setStringValue:@""];
        [tv_Lib setString:@""];
    }
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
