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
    
    self.title=@"Build App";
    
    NSString* filePath1 = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString* fileName1 = @"locationPath.txt";
    NSString* fileAtPath1 = [filePath1 stringByAppendingPathComponent:fileName1];
    if (![[NSFileManager defaultManager] fileExistsAtPath:fileAtPath1]) {
        [[NSFileManager defaultManager] createFileAtPath:fileAtPath1 contents:@"/\n" attributes:nil];
    }
    
    NSString* filePath2 = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString* fileName2 = @"android_ant_path.txt";
    NSString* fileAtPath2 = [filePath2 stringByAppendingPathComponent:fileName2];
    if (![[NSFileManager defaultManager] fileExistsAtPath:fileAtPath2]) {
        [[NSFileManager defaultManager] createFileAtPath:fileAtPath2 contents:@"~/\n~/\nsftp.com\nkey\nkey\nkey\nkey\n~/" attributes:nil];
    }
    
}

- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];

}

- (IBAction)btnAPI:(id)sender{
    NSString* filePath2 = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString* fileName2 = @"android_ant_path.txt";
    NSString* path_option = [filePath2 stringByAppendingPathComponent:fileName2];
//    NSString *path_option = [[NSBundle mainBundle] pathForResource:@"android_ant_path" ofType:@"txt"];
    
    NSString *contents_option = [NSString stringWithContentsOfFile:path_option];
    arr_option = [contents_option componentsSeparatedByCharactersInSet:
                  [NSCharacterSet characterSetWithCharactersInString:@"\n"]];
    androidPath=[NSString stringWithFormat:@"%@",arr_option[0]];
    NSString * launchPath =androidPath;
    NSArray *arguments = [NSArray arrayWithObjects:
                          @"list",
                          @"targets",
                          nil];
    NSString *target_list = runCommand(nil, launchPath, arguments);
    [tv1 setString:target_list];
}

- (IBAction)lcPath:(id)sender {
    NSString *projectLocation  = [NSString stringWithFormat:@"%@",self.locationPath.URL.path];
    [tf1 setStringValue:projectLocation];
    
}


//ant release
- (IBAction)btn_release:(id)sender {
    NSString* filePath2 = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString* fileName2 = @"android_ant_path.txt";
    NSString* path_option = [filePath2 stringByAppendingPathComponent:fileName2];
    
//    NSString *path_option = [[NSBundle mainBundle] pathForResource:@"android_ant_path" ofType:@"txt"];
    
    NSString *contents_option = [NSString stringWithContentsOfFile:path_option];
    arr_option = [contents_option componentsSeparatedByCharactersInSet:
                  [NSCharacterSet characterSetWithCharactersInString:@"\n"]];
    androidPath=[NSString stringWithFormat:@"%@",arr_option[0]];
    antPath=[NSString stringWithFormat:@"%@",arr_option[1]];
    keyPath=[NSString stringWithFormat:@"%@",arr_option[3]];
    keyName=[NSString stringWithFormat:@"%@",arr_option[4]];
    keypw1=[NSString stringWithFormat:@"%@",arr_option[5]];
    keypw2=[NSString stringWithFormat:@"%@",arr_option[6]];
    NSString *location=[tf1 stringValue];
    NSString *path_properties = [NSString stringWithFormat:@"%@/local.properties",location];
    NSString *contents_properties1 = [NSString stringWithContentsOfFile:path_properties];
    NSString *contents_properties2 = [NSString stringWithContentsOfFile:path_properties];
    
    if(![location isEqual: @""]){
        
        NSString * currentDirectoryPath = [NSString stringWithFormat:@"%@",location];
        NSString * launchPath3 = antPath;
        NSArray *arguments3 = [NSArray arrayWithObjects:
                               @"release",
                               nil];
        if(![keyPath isEqualToString:@""]&&![keyName isEqualToString:@""]&&![keypw1 isEqualToString:@""]&&![keypw2 isEqualToString:@""]){
            NSLog(@"%@",contents_properties1);
            NSString* key=[NSString stringWithFormat:@"\n%@\n%@\n%@\n%@\n",[NSString stringWithFormat: @"key.store=%@",keyPath],
                           [NSString stringWithFormat:@"key.alias=%@", keyName],
                           [NSString stringWithFormat:@"key.store.password=%@", keypw1],
                           [NSString stringWithFormat:@"key.alias.password=%@", keypw2]];
            
            contents_properties1 = [contents_properties1 stringByAppendingString:[NSString stringWithFormat:@"\n%@",key]];
            [contents_properties1 writeToFile:path_properties atomically:YES encoding:NSUTF8StringEncoding error:nil];
            
        }
        if (![[NSFileManager defaultManager] fileExistsAtPath:location]) {
            [tv1 setString:@"This path isn't exist!!"];
        }else{
            NSString*output3=runCommand( currentDirectoryPath,launchPath3,arguments3);
            NSLog(@"%@",output3);
            [tv1 setString:output3];
        }
        
            NSString *contents_properties3 = @"";
            NSLog(@"%@",contents_properties2);
            [contents_properties3 writeToFile:path_properties atomically:YES encoding:NSUTF8StringEncoding error:nil];
            [contents_properties2 writeToFile:path_properties atomically:YES encoding:NSUTF8StringEncoding error:nil];
        NSLog(@"%@",contents_properties2);
        
        
    }else{
        [lb_warning setStringValue:@"Please enter a path!"];
    }
    
    
    NSString *string = @"";
    [lb_warning setStringValue:string];
}

//android update
- (IBAction)btn_update:(id)sender {
    NSString* filePath2 = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString* fileName2 = @"android_ant_path.txt";
    NSString* path_option = [filePath2 stringByAppendingPathComponent:fileName2];
//    NSString *path_option = [[NSBundle mainBundle] pathForResource:@"android_ant_path" ofType:@"txt"];
    
    NSString *contents_option = [NSString stringWithContentsOfFile:path_option];
    arr_option = [contents_option componentsSeparatedByCharactersInSet:
                  [NSCharacterSet characterSetWithCharactersInString:@"\n"]];
    androidPath=[NSString stringWithFormat:@"%@",arr_option[0]];
    name =[tf_Name stringValue];
    
    NSString* filePath1 = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString* fileName1 = @"locationPath.txt";
    NSString* path = [filePath1 stringByAppendingPathComponent:fileName1];
    
    NSString *target =[tf_target stringValue];
    NSString *location=[tf1 stringValue];
    
   
    if(![location isEqual: @""]){
        
        NSString * currentDirectoryPath = [NSString stringWithFormat:@"%@",location];
        //android update project
        NSString * launchPath2 = androidPath;
        if([target isEqualToString:@""]&&[name isEqualToString:@""]){
            
            arguments2 = [NSArray arrayWithObjects:
                          @"update",
                          @"project",
                          @"-p",
                          currentDirectoryPath,
                          @"-s",
                          @"-n",
                          @"test",
                          nil];
            updateType=@"update project without Name without API level";
        }
        if([target isEqualToString:@""]&&![name isEqualToString:@""]){
            arguments2 = [NSArray arrayWithObjects:
                          @"update",
                          @"project",
                          @"-p",
                          currentDirectoryPath,
                          @"-s",
                          @"-n",
                          name,
                          nil];
            updateType=@"update project without Name with API level";
        }
        if(![target isEqualToString:@""]&&[name isEqualToString:@""]){
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
            updateType=@"update project with Name without API level";
        }
        if(![target isEqualToString:@""]&&![name isEqualToString:@""]){
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
            
            updateType=@"update project with Name with API level";
        }
        
        

        NSString *contents = [NSString stringWithContentsOfFile:path];
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
                //                [tf1 setStringValue:@""];
                break;
            }
            
            
        }
        
        
        if(d==arr.count-1){
            
            if (![[NSFileManager defaultManager] fileExistsAtPath:location]) {
                
                [tv1 setString:@"This path isn't exist!!"];
            }else{
                NSString*output1=runCommand(nil, launchPath2,arguments2);
                NSLog(@"%@\n",output1);
                NSString *string = [NSString stringWithFormat:@"%@\n",output1];
                [tv1 setString:string];
                contents = [contents stringByAppendingString:[NSString stringWithFormat:@"%@\n",currentDirectoryPath]];
                [contents writeToFile:path atomically:YES encoding:NSUTF8StringEncoding error:nil];
            }
            
        }else{

            if (![[NSFileManager defaultManager] fileExistsAtPath:location]) {
                [tv1 setString:@"This path isn't exist!!"];
            }else{
                NSString*output1=runCommand(nil, launchPath2,arguments2);
                NSLog(@"%@\n",output1);
                NSString *string = [NSString stringWithFormat:@"%@\n",output1];
                [tv1 setString:string];
            }
            }
    }else{
        [lb_warning setStringValue:@"Please enter a path!"];
    }
    
    NSString *contents = [NSString stringWithContentsOfFile:path];
    arr = [contents componentsSeparatedByCharactersInSet:
           [NSCharacterSet characterSetWithCharactersInString:@"\n"]];
    _dataSource = arr;
    table.dataSource = self;
    table.delegate = self;
    [table reloadData];
}

//delete crunch
- (IBAction)btn_deleteCrunch:(id)sender {
    
    
    NSString *location=[tf1 stringValue];
    if(![location isEqual: @""]){
        
        NSString * decrunch = [NSString stringWithFormat:@"%@/bin/res",location];
        NSString * decrunch2 = [NSString stringWithFormat:@"%@/bin/res/crunch",location];
        
        //remove crunch
        NSString * launchPath = @"/bin/rm";
        NSArray *arguments = [NSArray arrayWithObjects:
                              @"-R",
                              @"crunch",
                              nil];
        
        if (![[NSFileManager defaultManager] fileExistsAtPath:decrunch2]) {
            [tv1 setString:@"No Crunch!!"];
        }else{
            NSString*output1=runCommand(decrunch, launchPath,arguments);
            NSLog(@"%@\n",output1);
            [tv1 setString:@"Delete Crunch Successfully!!"];
        }
        
        
    }else{
        [lb_warning setStringValue:@"Please enter a path!"];
    }
    
}

//android debug
- (IBAction)btn1:(id)sender {
    
    NSString* filePath2 = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString* fileName2 = @"android_ant_path.txt";
    NSString* path_option = [filePath2 stringByAppendingPathComponent:fileName2];
//    NSString *path_option = [[NSBundle mainBundle] pathForResource:@"android_ant_path" ofType:@"txt"];
    
    NSString *contents_option = [NSString stringWithContentsOfFile:path_option];
    arr_option = [contents_option componentsSeparatedByCharactersInSet:
                  [NSCharacterSet characterSetWithCharactersInString:@"\n"]];
    antPath=[NSString stringWithFormat:@"%@",arr_option[1]];
    
    NSString *location=[tf1 stringValue];
    if(![location isEqual: @""]){
        NSString * currentDirectoryPath = [NSString stringWithFormat:@"%@",location];
        NSString * launchPath3 = antPath;
        NSArray *arguments3 = [NSArray arrayWithObjects:
                               @"debug",
                               nil];
        if (![[NSFileManager defaultManager] fileExistsAtPath:location]) {
            [tv1 setString:@"This path isn't exist!!"];
        }else{
            NSString*output3=runCommand( currentDirectoryPath,launchPath3,arguments3);
            NSLog(@"%@\n",output3);
            NSString *string = [NSString stringWithFormat:@"%@\n",output3];
            [tv1 setString:string];
        }
    }else{
        [lb_warning setStringValue:@"Please enter a path!"];
    }
    
    NSString *string = @"";
    [lb_warning setStringValue:string];
   
}

//Remove the path
- (IBAction)btnRemove:(id)sender{
    
    NSString *libLocation =[tf1 stringValue];
    
    NSString* filePath1 = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString* fileName1 = @"locationPath.txt";
    NSString* path = [filePath1 stringByAppendingPathComponent:fileName1];
    
//    NSString *path = [[NSBundle mainBundle] pathForResource:@"locationPath" ofType:@"txt"];
    
    NSString *contents = [NSString stringWithContentsOfFile:path];
    arr = [contents componentsSeparatedByCharactersInSet:
           [NSCharacterSet characterSetWithCharactersInString:@"\n"]];
    
    NSLog(@"%d",(int)arr.count);
    
    if(![libLocation isEqualTo:@""]){
        
        contents = @"";
        [contents writeToFile:path atomically:YES encoding:NSUTF8StringEncoding error:nil ];
        
        for(i=0;i<arr.count;i++){
            
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
            }else{
                d=i;
                break;
                
            }
            
            if(i==arr.count-1&& ![originalString isEqualToString: libLocation]){
                d=i;
                NSString *string = @"No suitable path!";
                [lb_warning setStringValue:string];
                //                [tf_Lib setStringValue:@""];
            }
        }
        
        
        for(i=d+1;i<arr.count;i++){
            
            originalString = arr[i];
            
            NSLog(@"%@ %@", libLocation, originalString);
            
            if(![originalString isEqualToString: libLocation]){
                contents = [contents stringByAppendingString:[NSString stringWithFormat:@"\n%@",originalString]];
                [contents writeToFile:path atomically:YES encoding:NSUTF8StringEncoding error:nil];
                [lb_warning setStringValue:@""];
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
    NSString *string = @"";
    [lb_warning setStringValue:string];
    
}

//tableView of the path
- (void) awakeFromNib {
    
    NSString* filePath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString* fileName = @"locationPath.txt";
    NSString* path = [filePath stringByAppendingPathComponent:fileName];
    
//     NSString *path = [[NSBundle mainBundle] pathForResource:@"locationPath" ofType:@"txt"];
    
    NSString *contents= [NSString stringWithContentsOfFile:path];
    arr = [contents componentsSeparatedByCharactersInSet:
           [NSCharacterSet characterSetWithCharactersInString:@"\n"]];
    
    _dataSource = arr;
    table.dataSource = self;
    table.delegate = self;
    [table reloadData];

    
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

//Run the command for terminal
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
