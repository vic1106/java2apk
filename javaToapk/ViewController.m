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
    
    NSString *path_option = [[NSBundle mainBundle] pathForResource:@"android_ant_path" ofType:@"txt"];
    
    NSString *contents_option = [NSString stringWithContentsOfFile:path_option];
    arr_option = [contents_option componentsSeparatedByCharactersInSet:
           [NSCharacterSet characterSetWithCharactersInString:@"\n"]];
    androidPath=[NSString stringWithFormat:@"%@",arr_option[0]];
    antPath=[NSString stringWithFormat:@"%@",arr_option[1]];
    keyPath=[NSString stringWithFormat:@"%@",arr_option[3]];
    keyName=[NSString stringWithFormat:@"%@",arr_option[4]];
    keypw1=[NSString stringWithFormat:@"%@",arr_option[5]];
    keypw2=[NSString stringWithFormat:@"%@",arr_option[6]];
    
    
//    NSString *projectLocation  = [NSString stringWithFormat:@"%@",self.locationPath.URL.path];
//    [tf1 setStringValue:projectLocation];
    self.title=@"Build App";
    
    
    NSString * launchPath =androidPath;
    NSArray *arguments = [NSArray arrayWithObjects:
                          @"list",
                          @"targets",
                          nil];
    NSString *target_list = runCommand(nil, launchPath, arguments);
    [tv_detail setString:target_list];
    
}

- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];

}

- (IBAction)lcPath:(id)sender {
    NSString *projectLocation  = [NSString stringWithFormat:@"%@",self.locationPath.URL.path];
    [tf1 setStringValue:projectLocation];
    
}

- (IBAction)btn_release:(id)sender {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"locationPath" ofType:@"txt"];
    NSString *target =[tf_target stringValue];
    NSString *name =[tf_Name stringValue];
    
    NSString *location=[tf1 stringValue];
    NSString *path_properties = [NSString stringWithFormat:@"%@/local.properties",location];
    NSString *contents_properties1 = [NSString stringWithContentsOfFile:path_properties];
    NSString *contents_properties2 = [NSString stringWithContentsOfFile:path_properties];
    NSLog(@"%@",contents_properties2);
//    NSArray* arr_properties = [contents_properties componentsSeparatedByCharactersInSet:
//           [NSCharacterSet characterSetWithCharactersInString:@"\n"]];
    NSString* key=[NSString stringWithFormat:@"%@\n%@\n%@\n%@\n",[NSString stringWithFormat: @"key.store=%@",keyPath],
                                               [NSString stringWithFormat:@"key.alias=%@", keyName],
                                               [NSString stringWithFormat:@"key.store.password=%@", keypw1],
                                               [NSString stringWithFormat:@"key.alias.password=%@", keypw2]];
    
    contents_properties1 = [contents_properties1 stringByAppendingString:[NSString stringWithFormat:@"\n%@",key]];
    [contents_properties1 writeToFile:path_properties atomically:YES encoding:NSUTF8StringEncoding error:nil];
//    NSString* contents2 = @"";
//    [contents2 writeToFile:path atomically:YES encoding:NSUTF8StringEncoding error:nil ];
    
    if(![location isEqual: @""]){
        
        NSString * decrunch = [NSString stringWithFormat:@"%@/bin/res",location];
        NSString * currentDirectoryPath = [NSString stringWithFormat:@"%@",location];
        
        //remove crunch
        NSString * launchPath = @"/bin/rm";
        NSArray *arguments = [NSArray arrayWithObjects:
                              @"-R",
                              @"crunch",
                              nil];
        //android update project
        NSString * launchPath2 = androidPath;
        if([target isEqualToString:@""]&&[name isEqualToString:@""]){
            
            arguments2 = [NSArray arrayWithObjects:
                          @"update",
                          @"project",
                          @"-p",
                          currentDirectoryPath,
                          @"-t",
                          @"6",
                          @"-s",
                          @"-n",
                          @"test",
                          nil];
            updateType=@"update project without Name without API level";
        }
        if(![target isEqualToString:@""]&&[name isEqualToString:@""]){
            arguments2 = [NSArray arrayWithObjects:
                          @"update",
                          @"project",
                          @"-p",
                          currentDirectoryPath,
                          @"-t",
                          @"test",
                          @"-s",
                          @"-n",
                          name,
                          nil];
            updateType=@"update project without Name with API level";
        }
        if([target isEqualToString:@""]&&![name isEqualToString:@""]){
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
        //ant release
        NSString * launchPath3 = antPath;
        NSArray *arguments3 = [NSArray arrayWithObjects:
                               @"release",
                               nil];
        if(![name isEqualToString:@""]){
            currentDirectoryPath4= [NSString stringWithFormat:@"%@/bin",location];
            launchPath4 = @"/bin/mv";
            arguments4= [NSArray arrayWithObjects:
                                  [NSString stringWithFormat:@"%@-release.apk",name],
                                  [NSString stringWithFormat:@"%@.apk",name],
                                  nil];
        }else{
            currentDirectoryPath4= [NSString stringWithFormat:@"%@/bin",location];
            launchPath4 = @"/bin/mv";
            arguments4= [NSArray arrayWithObjects:
                                  @"test-release.apk",
                                  @"test.apk",
                                  nil];
        }
        
        if (![[NSFileManager defaultManager] fileExistsAtPath:path]) {
            [[NSFileManager defaultManager] createFileAtPath:path contents:@"Location Record:\n" attributes:nil];
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
            
            NSString*output1=runCommand(decrunch, launchPath,arguments);
            NSString*output2=runCommand(nil, launchPath2,arguments2);
            NSString*output3=runCommand( currentDirectoryPath,launchPath3,arguments3);
            NSString*output4=runCommand( currentDirectoryPath4,launchPath4,arguments4);
            
            contents = [contents stringByAppendingString:[NSString stringWithFormat:@"%@\n",currentDirectoryPath]];
            [contents writeToFile:path atomically:YES encoding:NSUTF8StringEncoding error:nil];
            
            NSLog(@"%@\n%@\n%@%@\n",output1,output2,output3,output4);
            NSString *string = [NSString stringWithFormat:@"%@\n%@\n%@\n%@\n%@\n%@\n%@",output1,output2,output3,output4,updateType,name,target];
            [tv1 setString:string];
        }else{
            NSString*output1=runCommand(decrunch, launchPath,arguments);
            NSString*output2=runCommand(nil, launchPath2,arguments2);
            NSString*output3=runCommand( currentDirectoryPath,launchPath3,arguments3);
            NSString*output4=runCommand( currentDirectoryPath4,launchPath4,arguments4);
            NSLog(@"%@\n%@\n%@%@\n",output1,output2,output3,output4);
            NSString *string = [NSString stringWithFormat:@"%@\n%@\n%@\n%@\n%@\n%@\n%@",output1,output2,output3,output4,updateType,name,target];
            [tv1 setString:string];
        }
    }else{
        [lb_warning setStringValue:@"Please enter a path!"];
    }
    
    NSString *contents = [NSString stringWithContentsOfFile:path];
    arr = [contents componentsSeparatedByCharactersInSet:
           [NSCharacterSet characterSetWithCharactersInString:@"\n"]];
    
    contents_properties1 = @"";
    NSLog(@"%@",contents_properties2);
    [contents_properties1 writeToFile:path_properties atomically:YES encoding:NSUTF8StringEncoding error:nil];
    [contents_properties2 writeToFile:path_properties atomically:YES encoding:NSUTF8StringEncoding error:nil];
    
    _dataSource = arr;
    table.dataSource = self;
    table.delegate = self;
    [table reloadData];
}

- (IBAction)btn_sign:(id)sender {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"locationPath" ofType:@"txt"];
    
    NSString *target =[tf_target stringValue];
    NSString *name =[tf_Name stringValue];
    
    NSString *location=[tf1 stringValue];
    if(![location isEqual: @""]){
        
        NSString * decrunch = [NSString stringWithFormat:@"%@/bin/res",location];
        NSString * currentDirectoryPath = [NSString stringWithFormat:@"%@",location];
        
        //remove crunch
        NSString * launchPath = @"/bin/rm";
        NSArray *arguments = [NSArray arrayWithObjects:
                              @"-R",
                              @"crunch",
                              nil];
        //android update project
        NSString * launchPath2 = androidPath;
        if([target isEqualToString:@""]&&[name isEqualToString:@""]){
            target=@"6";
            name=@"test";
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
            updateType=@"update project without Name without API level";
        }
        if(![target isEqualToString:@""]&&[name isEqualToString:@""]){
            name=@"test";
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
            updateType=@"update project without Name with API level";
        }
        if([target isEqualToString:@""]&&![name isEqualToString:@""]){
            name=@"test";
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
        //ant release
        NSString * launchPath3 = antPath;
        NSArray *arguments3 = [NSArray arrayWithObjects:
                               @"release",
                               nil];
        
        if (![[NSFileManager defaultManager] fileExistsAtPath:path]) {
            [[NSFileManager defaultManager] createFileAtPath:path contents:@"Location Record:\n" attributes:nil];
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
                [tf1 setStringValue:@""];
                break;
            }
        }
        
        if(d==arr.count-1){
            
            NSString*output1=runCommand(decrunch, launchPath,arguments);
            NSString*output2=runCommand(nil, launchPath2,arguments2);
            NSString*output3=runCommand( currentDirectoryPath,launchPath3,arguments3);
            
            contents = [contents stringByAppendingString:[NSString stringWithFormat:@"%@\n",currentDirectoryPath]];
            [contents writeToFile:path atomically:YES encoding:NSUTF8StringEncoding error:nil];
            
            NSLog(@"%@\n%@\n%@",output1,output2,output3);
            NSString *string = [NSString stringWithFormat:@"%@\n%@\n%@",output1,output2,output3];
            [tv1 setString:string];
        }else{
            NSString*output1=runCommand(decrunch, launchPath,arguments);
            NSString*output2=runCommand(nil, launchPath2,arguments2);
            NSString*output3=runCommand( currentDirectoryPath,launchPath3,arguments3);
            NSLog(@"%@\n%@\n%@",output1,output2,output3);
            NSString *string = [NSString stringWithFormat:@"%@\n%@\n%@\n%@\n%@\n%@",output1,output2,output3,updateType,name,target];
            [tv1 setString:string];
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

- (IBAction)btn1:(id)sender {
    
    NSString *path_option = [[NSBundle mainBundle] pathForResource:@"android_ant_path" ofType:@"txt"];
    
    NSString *contents_option = [NSString stringWithContentsOfFile:path_option];
    arr_option = [contents_option componentsSeparatedByCharactersInSet:
                  [NSCharacterSet characterSetWithCharactersInString:@"\n"]];
    androidPath=[NSString stringWithFormat:@"%@",arr_option[0]];
    antPath=[NSString stringWithFormat:@"%@",arr_option[1]];
    
    
    
//    NSString* filePath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
//    NSString* fileName = @"locationPath.txt";
//    NSString* path = [filePath stringByAppendingPathComponent:fileName];
    
     NSString *path = [[NSBundle mainBundle] pathForResource:@"locationPath" ofType:@"txt"];
    
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
             
        NSString * launchPath2 = androidPath;
        if([target isEqualToString:@""]&&[name isEqualToString:@""]){
            
            arguments2 = [NSArray arrayWithObjects:
                          @"update",
                          @"project",
                          @"-p",
                          currentDirectoryPath,
                          @"-t",
                          @"6",
                          @"-s",
                          @"-n",
                          @"test",
                          nil];
                updateType=@"update project without Name without API level";
            }
        if(![target isEqualToString:@""]&&[name isEqualToString:@""]){
            arguments2 = [NSArray arrayWithObjects:
                          @"update",
                          @"project",
                          @"-p",
                          currentDirectoryPath,
                          @"-t",
                          @"test",
                          @"-s",
                          @"-n",
                          name,
                          nil];
                updateType=@"update project without Name with API level";
            }
    if([target isEqualToString:@""]&&![name isEqualToString:@""]){
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
        
             NSString * launchPath3 = antPath;
             NSArray *arguments3 = [NSArray arrayWithObjects:
                                    @"debug",
                                    nil];
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:path]) {
        [[NSFileManager defaultManager] createFileAtPath:path contents:@"Location Record:\n" attributes:nil];
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
//            [tf1 setStringValue:@""];
            break;
        }
    }
   
    if(d==arr.count-1){
    
    NSString*output1=runCommand(decrunch, launchPath,arguments);
    NSString*output2=runCommand(nil, launchPath2,arguments2);
    NSString*output3=runCommand( currentDirectoryPath,launchPath3,arguments3);
        
    contents = [contents stringByAppendingString:[NSString stringWithFormat:@"%@\n",currentDirectoryPath]];
    [contents writeToFile:path atomically:YES encoding:NSUTF8StringEncoding error:nil];
    
    NSLog(@"%@\n%@\n%@",output1,output2,output3);
        NSString *string = [NSString stringWithFormat:@"%@\n%@\n%@",output1,output2,output3];
        [tv1 setString:string];
    }else{
        NSString*output1=runCommand(decrunch, launchPath,arguments);
        NSString*output2=runCommand(nil, launchPath2,arguments2);
        NSString*output3=runCommand( currentDirectoryPath,launchPath3,arguments3);
        NSLog(@"%@\n%@\n%@",output1,output2,output3);
        NSString *string = [NSString stringWithFormat:@"%@\n%@\n%@\n%@\n%@\n%@",output1,output2,output3,updateType,name,target];
        [tv1 setString:string];
    }
    }else{
        [lb_warning setStringValue:@"Please enter a path!"];
    }
    
   
}



- (void) awakeFromNib {
    
//    NSString* filePath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
//    NSString* fileName = @"locationPath.txt";
//    NSString* path = [filePath stringByAppendingPathComponent:fileName];
    
     NSString *path = [[NSBundle mainBundle] pathForResource:@"locationPath" ofType:@"txt"];
    
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
