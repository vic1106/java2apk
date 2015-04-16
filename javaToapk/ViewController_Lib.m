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
    
    NSString *path_option = [[NSBundle mainBundle] pathForResource:@"android_ant_path" ofType:@"txt"];
    
    NSString *contents_option = [NSString stringWithContentsOfFile:path_option];
    arr_option = [contents_option componentsSeparatedByCharactersInSet:
                  [NSCharacterSet characterSetWithCharactersInString:@"\n"]];
    androidPath=[NSString stringWithFormat:@"%@",arr_option[0]];
    antPath=[NSString stringWithFormat:@"%@",arr_option[1]];
    
    self.title=@"Update Library";
    NSString * launchPath =androidPath;
    NSArray *arguments = [NSArray arrayWithObjects:
                          @"list",
                          @"targets",
                          nil];
    NSString *target_list = runCommand2(nil, launchPath, arguments);
    [tv_detail setString:target_list];
    
}

//Choose the project
- (IBAction)lcPath:(id)sender {
    NSString *projectLocation  = [NSString stringWithFormat:@"%@",self.locationPath.URL.path];
    [tf_Lib setStringValue:projectLocation];
    
}

// delete the crunch
- (IBAction)deleteCrunch:(id)sender {
    NSString *libLocation =[tf_Lib stringValue];
    NSString * decrunch = [NSString stringWithFormat:@"%@/bin/res",libLocation];
    
    
    NSString * launchPath = @"/bin/rm";
    NSArray *arguments = [NSArray arrayWithObjects:
                          @"-R",
                          @"crunch",
                          nil];
    
    NSString* output2=runCommand2(decrunch, launchPath,arguments);
    NSLog(@"%@\n",output2);
    NSString *string = [NSString stringWithFormat:@"%@\n",output2];
    [tv_Lib setString:string];
    [lb_warning setStringValue:@" "];
}

//Remove the path in tableView
- (IBAction)btnRemove:(id)sender{
    
    NSString *libLocation =[tf_Lib stringValue];
    
//    NSString* filePath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
//    NSString* fileName = @"libRecord_j2a.txt";
//    NSString* fileAtPath = [filePath stringByAppendingPathComponent:fileName];
    
     NSString *path = [[NSBundle mainBundle] pathForResource:@"libRecord_j2a" ofType:@"txt"];
    
    NSString *contents = [NSString stringWithContentsOfFile:path];
    arr = [contents componentsSeparatedByCharactersInSet:
                    [NSCharacterSet characterSetWithCharactersInString:@"\n"]];
    
    NSLog(@"%d",(int)arr.count);
    
    if(![libLocation isEqualTo:@""]){
        
        contents = @"";
        [contents writeToFile:path atomically:YES encoding:NSUTF8StringEncoding error:nil ];

        for(i=0;i<arr.count;i++){
            
            originalString = arr[i];
            [arr2[i] addObject:originalString];
            NSLog(@"%@ %@", libLocation, originalString);
            
            if(![originalString isEqualToString: libLocation]){
                if(i==0){
                    contents = [contents stringByAppendingString:[NSString stringWithFormat:@"%@",originalString]];
                    [contents writeToFile:path atomically:YES encoding:NSUTF8StringEncoding error:nil];
                }else{
                    contents = [contents stringByAppendingString:[NSString stringWithFormat:@"\n%@",originalString]];
                    [contents writeToFile:path atomically:YES encoding:NSUTF8StringEncoding error:nil];
                }
                d=i;
            }else{
                d=i;
                break;
                
            }
            
            if(i==arr.count-1&& ![originalString isEqualToString: libLocation]){
                d=i;
                NSString *string = @"No suitable path!";
                [tv_Lib setString:string];
//                [tf_Lib setStringValue:@""];
            }
        }
        
        
            for(i=d+1;i<arr.count;i++){
                
                originalString = arr[i];
                
                NSLog(@"%@ %@", libLocation, originalString);
                
                if(![originalString isEqualToString: libLocation]){
                    if(i==0){
                        contents = [contents stringByAppendingString:[NSString stringWithFormat:@"%@",originalString]];
                        [contents writeToFile:path atomically:YES encoding:NSUTF8StringEncoding error:nil];
                    }else{
                        contents = [contents stringByAppendingString:[NSString stringWithFormat:@"\n%@",originalString]];
                        [contents writeToFile:path atomically:YES encoding:NSUTF8StringEncoding error:nil];
                    }
                
        }
    }
        
    }else{
        [lb_warning setStringValue:@"Please enter the path of library!"];
        
    }
    
    arr = [contents componentsSeparatedByCharactersInSet:
           [NSCharacterSet characterSetWithCharactersInString:@"\n"]];
    _dataSource = arr;
    table.dataSource = self;
    table.delegate = self;
    [table reloadData];

}

//Update library
- (IBAction)btn_Lib:(id)sender {
    
    NSString *path_option = [[NSBundle mainBundle] pathForResource:@"android_ant_path" ofType:@"txt"];
    
    NSString *contents_option = [NSString stringWithContentsOfFile:path_option];
    arr_option = [contents_option componentsSeparatedByCharactersInSet:
                  [NSCharacterSet characterSetWithCharactersInString:@"\n"]];
    androidPath=[NSString stringWithFormat:@"%@",arr_option[0]];
    antPath=[NSString stringWithFormat:@"%@",arr_option[1]];
    
    NSString *libLocation =[tf_Lib stringValue];
    NSString *target =[tf_target stringValue];
    NSString * launchPath2 = androidPath;
    if([target isEqualToString:@""]){
        arguments2 = [NSArray arrayWithObjects:
                      @"update",
                      @"lib-project",
                      @"-p",
                      libLocation,
                      @"-t",
                      @"6",
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
    
    
    
     NSString *path = [[NSBundle mainBundle] pathForResource:@"libRecord_j2a" ofType:@"txt"];
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:path]) {
        [[NSFileManager defaultManager] createFileAtPath:path contents:@"/\n" attributes:nil];
    }
    NSString *contents = [NSString stringWithContentsOfFile:path];
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
                break;
            }
        }
        if(d==arr.count-1){
                contents = [contents stringByAppendingString:[NSString stringWithFormat:@"%@\n",libLocation]];
                [contents writeToFile:path atomically:YES encoding:NSUTF8StringEncoding error:nil];
            
            NSString* output1=runCommand2(libLocation, launchPath2,arguments2);
            NSLog(@"%@\n",output1);
            NSString *string = [NSString stringWithFormat:@"%@\n",output1];
            [tv_Lib setString:string];
            [lb_warning setStringValue:@" "];
            
        }else{
            NSString* output1=runCommand2(libLocation, launchPath2,arguments2);
            NSLog(@"%@\n",output1);
            NSString *string = [NSString stringWithFormat:@"%@\n",output1];
            [tv_Lib setString:string];
            [lb_warning setStringValue:@"Added already!"];
        }
    }else{
        [lb_warning setStringValue:@"Please enter the path of library!"];
    }
    arr = [contents componentsSeparatedByCharactersInSet:
           [NSCharacterSet characterSetWithCharactersInString:@"\n"]];
    _dataSource = arr;
    table.dataSource = self;
    table.delegate = self;
    [table reloadData];
}

//tableView
- (void) awakeFromNib {
//    NSString* filePath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
//    NSString* fileName = @"libRecord_j2a.txt";
//    NSString* fileAtPath = [filePath stringByAppendingPathComponent:fileName];

    NSString *path = [[NSBundle mainBundle] pathForResource:@"libRecord_j2a" ofType:@"txt"];

    NSString *contents= [NSString stringWithContentsOfFile:path];
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
        [lb_warning setStringValue:@" "];
    }else{
        [tf_Lib setStringValue:@""];
        [tv_Lib setString:@""];
        [lb_warning setStringValue:@" "];
        
    }
}

//Run the Command
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
